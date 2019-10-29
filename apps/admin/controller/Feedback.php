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
 * 用户反馈
 */
class Feedback extends Admin
{
    protected $feedback;

    function _initialize()
    {
        parent::_initialize();

        $this->feedback = model('Feedback');

    }

    /**
     * 公司历程
     * @return [type] [description]
     * @date   2018-02-05
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function index()
    {
        //$gap = explode('—', '2019-5-30 09:49:20');
        return (new Iframe())
            ->setMetaTitle('反馈列表')
           ->search([
               ['name' => 'create_time', 'type' => 'daterange', 'extra_attr' => 'placeholder="反馈时间"'],
              /*  ['name' => 'type', 'type' => 'select', 'title' => '类型', 'options' => [1 => '举报', 2 => '热门收搜']],

              ['name' => 'sex', 'type' => 'select', 'title' => '性别', 'options' => [0 => '未知', 1 => '男', 2 => '女']],
                ['name' => 'is_lock', 'type' => 'select', 'title' => '是否锁定', 'options' => [0 => '否', 1 => '是']],
                ['name' => 'name', 'type' => 'text', 'extra_attr' => 'placeholder="请输入会员昵称"'],*/
            ])
            ->content($this->grid());
    }

    public function grid()
    {
        $search_setting = $this->buildModelSearchSetting();
        // 获取数据
        $condition['status'] = ['egt', '0']; // 禁用和正常状态
        list($data_list, $total) = $this->feedback->search($search_setting)->getListByPage($condition, true, 'create_time desc');

        return builder('list')
            ->setMetaTitle('反馈列表') // 设置页面标题
            ->addTopButton('addnew')  // 添加新增按钮
            ->addTopButton('resume')  // 添加启用按钮
            ->addTopButton('forbid')  // 添加禁用按钮
            ->addTopButton('delete')  // 添加删除按钮
            //->addTopButton('self',$reset_password)  // 添加重置按钮
            //->setSearch('custom','请输入ID/用户名/昵称')
            ->setActionUrl(url('grid')) //设置请求地址
            ->keyListItem('id', 'UID')
            ->keyListItem('name', '反馈人')
            ->keyListItem('tel', '联系方式')
            ->keyListItem('content_text', '内容')
            ->keyListItem('status_text', '状态')
            ->keyListItem('create_time', '反馈时间')
            ->keyListItem('right_button', '操作', 'btn')
            ->setListPrimaryKey('id')
            ->setListData($data_list)// 数据列表
            ->setListPage($total)// 数据列表分页
            ->addRightButton('edit')
            ->addRightButton('delete',array('title' => '删除反馈', 'confirm-info' => '你确定要删除反馈吗？', 'href' => url(MODULE_NAME . '/' . CONTROLLER_NAME . '/delete', ['id' => '__data_id__'])))
           // ->addRightButton('self',$reset_password)
           ->addRightButton('forbid')
            //->addRightButton('forbid')  // 添加编辑按钮
            ->fetch();
    }
    public function edit($id = 0) {
        $title = $id ? "编辑" : "新增";
        if (IS_POST) {
            $data = input('param.');
            if ($id){
                $data['update_time']=time();
            }else{
                $data['update_time']=time();
                $data['create_time']=time();
            }


            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->feedback->editData($data);
            if ($result) {
                $this->success($title.'成功', url('index'));
            } else {
                $this->error($this->feedback->getError());
            }
        } else {

            return (new Iframe())
                ->setMetaTitle($title.'历程')
                ->content($this->form($id));

        }
    }

    /**
     * 表单构建
     * @param  integer $id [description]
     * @return [type] [description]
     * @date   2018-10-03
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function form($id = 0)
    {


        $info=[];
        if ($id>0) {
            $info = $this->feedback->get($id);
        }
        return builder('Form')
            ->addFormItem('id', 'hidden', 'UID', '')
            ->addFormItem('name', 'text', '反馈人', '反馈人','','require')
            ->addFormItem('tel', 'text', '联系方式', '联系方式','','require')
            ->addFormItem('content', 'textarea', '反馈内容')
            ->addFormItem('status', 'radio', '状态', '',[1=>'正常',0=>'禁用'])
            ->setFormData($info)//->setAjaxSubmit(false)
            ->addButton('submit')
            ->addButton('back')    // 设置表单按钮
            ->fetch();
    }
    /**
     * 构建模型搜索查询条件
     * @return [type] [description]
     * @date   2018-09-30
     * @author 心云间、凝听 <981248356@qq.com>
     */
    private function buildModelSearchSetting()
    {
       // $params = $this->request->param();
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
            'keyword_condition' => 'id|name|tel',
            //忽略数据库不存在的字段
            //'ignore_keys' => ['reg_time_range'],
            //扩展的查询条件
            'extend_conditions'=>$extend_conditions
        ];

        return $search_setting;
    }

    /**
     * 设置用户的状态
     */
    public function setStatus($model = CONTROLLER_NAME,$script=false){
        $ids = input('param.ids/a');

        if (!empty($ids)) {
            foreach ($ids as $key => $uid) {
                //清理缓存
                cache('User_info_'.$uid, null);
            }
        }
        parent::setStatus($model);
    }

    /**
     * @param int $id
     * @throws \think\Exception
     * @throws \think\exception\PDOExceptions
     * 删除会员
     */
    public function delete($id=0){
        if ($id==0){
            $this->error('没有可操作的数据');
            exit();
        }
        //删除用户
        $rest=Db::table('eacoo_feedback')->where('id',$id)->delete();
        if (false !=$rest){
            $this->success('删除成功');
        }else{
            $this->error('删除失败');
        }

    }

}
