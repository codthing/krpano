<?php
// 用户管理控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 https://www.eacoophp.com, All rights reserved.         
// +----------------------------------------------------------------------
// | [EacooPHP] 并不是自由软件,可免费使用,未经许可不能去掉EacooPHP相关版权。
// | 禁止在EacooPHP整体或任何部分基础上发展任何派生、修改或第三方版本用于重新分发
// +----------------------------------------------------------------------
// | Author:  心云间、凝听 <981248356@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\api\controller\Publics;
use app\common\layout\Iframe;
use app\admin\model\Member as MemberModel;
use think\Db;
use think\Loader;

/**
 * Class Shop
 * @package app\admin\controller
 *热门收搜关键字
 */
class MemberSearch extends Admin
{
    protected $memberSearchModel;
    //protected $groupIds;

    function _initialize()
    {
        parent::_initialize();

        $this->memberSearchModel = model('MemberSearch');
    }

    /**
     * 热门关键字列表
     * @return [type] [description]
     * @date   2018-02-05
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function index()
    {
        //$gap = explode('—', '2019-5-30 09:49:20');
        return (new Iframe())
            ->setMetaTitle('服务类型列表')
          ->search([
                ['name' => 'create_time', 'type' => 'daterange', 'extra_attr' => 'placeholder="添加时间"'],
                ['name' => 'status', 'type' => 'select', 'title' => '状态', 'options' => [1 => '正常', 2 => '禁用']],
                ['name' => 'key', 'type' => 'text', 'extra_attr' => 'placeholder="请输入类型名称"'],
            ])
            ->content($this->grid());
    }

    public function grid()
    {
        $search_setting = $this->buildModelSearchSetting();
        // 获取数据
        $condition['status'] = ['egt', '0']; // 禁用和正常状态
        list($data_list, $total) = $this->memberSearchModel->search($search_setting)->getListByPage($condition, true, 'create_time asc');

      /*  $reset_password = [
            'icon'         => 'fa fa-recycle',
            'title'        => '重置原始密码',
            'class'        => 'btn btn-default ajax-table-btn confirm btn-sm',
            'confirm-info' => '该操作会重置用户密码为123456，请谨慎操作',
            'href'         => url('reset',['id' => '__data_id__'])
        ];*/


        return builder('list')
            ->setMetaTitle('热门搜索列表') // 设置页面标题
            ->addTopButton('addnew')  // 添加新增按钮
            ->addTopButton('delete')  // 添加删除按钮
            //->addTopButton('self',$reset_password)  // 添加重置按钮
            //->setSearch('custom','请输入ID/用户名/昵称')
            ->setActionUrl(url('grid')) //设置请求地址
            ->keyListItem('id', 'UID')
            // ->keyListItem('integral', '绑定手机送积分')
            ->keyListItem('key', '关键字')

            ->keyListItem('status', '状态','array',[1=>'正常',0=>'禁用'])
            ->keyListItem('create_time', '创建时间')
            ->keyListItem('right_button', '操作', 'btn')
            ->setListPrimaryKey('id')
            ->setListData($data_list)// 数据列表
            ->setListPage($total)// 数据列表分页
            ->addRightButton('edit')
            ->addRightButton('delete',array('title' => '删除关键字', 'confirm-info' => '你确定要删除关键字吗？', 'href' => url(MODULE_NAME . '/' . CONTROLLER_NAME . '/delete', ['id' => '__data_id__'])))
           // ->addRightButton('self',$reset_password)
            ->addRightButton('forbid')
            //->addRightButton('forbid')  // 添加编辑按钮
            ->fetch();
    }

    /**
     * 编辑用户
     */
    public function edit($id = 0) {
        $title = $id ? "编辑" : "新增";
        if (IS_POST) {
            $data = input('param.');
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->memberSearchModel->editData($data);
            if ($result) {
                $this->success($title.'成功', url('index'));
            } else {
                $this->error($this->memberSearchModel->getError());
            }
        } else {
            // 获取账号信息
            if ($id>0) {
                $info = $this->memberSearchModel->get($id);
            }else{
                $info=[];
            }
            $builder = builder('Form')
                ->addFormItem('id', 'hidden', 'UID', '')
                ->addFormItem('key', 'text', '关键字', '热门搜索关键字','','require')

                ->addFormItem('status', 'select', '状态', '',[0=>'禁用',1=>'正常'])
                ->setFormData($info)//->setAjaxSubmit(false)
                ->addButton('submit')
                ->addButton('back')    // 设置表单按钮
                ->fetch();

            return (new Iframe())
                ->setMetaTitle($title.'关键字')
                ->content($builder);

        }
    }

    /**
     * 构建模型搜索查询条件
     * @return [type] [description]
     * @date   2018-09-30
     * @author 心云间、凝听 <981248356@qq.com>
     */
    private function buildModelSearchSetting()
    {
        //时间范围
        $timegap = input('create_time');
        $extend_conditions = [];
        if($timegap){
            $gap = explode('—', $timegap);
            $reg_begin = $gap[0];
            $reg_end = $gap[1];

            $extend_conditions =[
                'create_time'=>['between',[strtotime($reg_begin.' 00:00:00'),strtotime($reg_end.' 23:59:59')]]
            ];
        }
        //自定义查询条件
        $search_setting = [
            'keyword_condition' => 'id|key',
            //忽略数据库不存在的字段
            //'ignore_keys' => ['reg_time_range'],
            //扩展的查询条件
            'extend_conditions'=>$extend_conditions
        ];

        return $search_setting;
    }



    /**
     * @param int $id
     * @throws \think\Exception
     * @throws \think\exception\PDOExceptions
     * 删除关键字
     */
    public function delete($id=0){
        if ($id==0){
            $this->error('没有可操作的数据');
            exit();
        }


        //删除用户
        $rest=Db::table('eacoo_member_search')->where('id',$id)->delete();
        if (false !=$rest){
            $this->success('删除成功');
        }else{
            $this->error('删除失败');
        }

    }

    /**
     * 设置用户的状态
     */
    public function setStatus($model = CONTROLLER_NAME,$script=false){
        $ids = input('param.ids/a');
        /*if (is_array($ids)) {
            if(in_array('1', $ids)) {
                $this->error('超级管理员不允许操作');
            }
        }else{
            if($ids === '1') {
                $this->error('超级管理员不允许操作');
            }
        }*/
        parent::setStatus($model);
    }

}
