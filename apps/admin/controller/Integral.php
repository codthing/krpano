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
use app\common\layout\Iframe;
use app\admin\model\Integral as IntgModel;

/**
 * Class Integral
 * @package app\admin\controller
 * 积分设置
 */
class Integral extends Admin {
    protected $intgModel;
    protected $groupIds;

    function _initialize()
    {
        parent::_initialize();

        $this->intgModel = model('SetIntegral');

        //$this->groupIds = model('admin/AuthGroup')->where('status',1)->column('title','id');
    }

    /**
     * 充值积分列表
     * @return [type] [description]
     * @date   2018-02-05
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function index(){
        return (new Iframe())
                ->setMetaTitle('设置列表')
               /* ->search([
                    ['name'=>'status','type'=>'select','title'=>'状态','options'=>[1=>'正常',2=>'待审核']],
                    ['name'=>'sex','type'=>'select','title'=>'性别','options'=>[0=>'未知',1=>'男',2=>'女']],
                    ['name'=>'group_id','type'=>'select','title'=>'角色组','options'=>$this->groupIds],
                    ['name'=>'create_time_range','type'=>'daterange','extra_attr'=>'placeholder="注册时间"'],
                    ['name'=>'keyword','type'=>'text','extra_attr'=>'placeholder="请输入查询关键字"'],
                ])*/
                ->content($this->grid());
    }

    /**
     * Make a grid builder.
     * @return [type] [description]
     * @date   2018-09-08
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function grid()
    {
        $search_setting = $this->buildModelSearchSetting();
        // 获取数据
        $condition['status'] = ['egt', '0']; // 禁用和正常状态
        list($data_list,$total) = $this->intgModel->search($search_setting)->getListByPage($condition,true,'create_time asc');

        return builder('list')
                ->setMetaTitle('数据列表') // 设置页面标题
                //->addTopButton('addnew')  // 添加新增按钮
                ->keyListItem('id', 'UID')
               // ->keyListItem('integral', '绑定手机送积分')
                ->keyListItem('type', '积分类型','array',[1=>'帖子被赞',2=>'回复被踩',3=>'举报核销',4=>'漏签',5=>'被人举报核实',6=>'签到',7=>'举报他人核实'])
                ->keyListItem('types', '状态','array',[1=>'+',2=>'-'])
                ->keyListItem('integral', '积分')
                ->keyListItem('right_button', '操作', 'btn')
                ->setListPrimaryKey('id')
                ->setListData($data_list)    // 数据列表
                ->setListPage($total) // 数据列表分页
                ->addRightButton('edit')
                //->addRightButton('forbid')
               // ->addRightButton('forbid')  // 添加编辑按钮
                ->fetch();
    }

    /**
     * 编辑充值
     */
    public function edit($id = 0) {
        $title = $id ? "编辑" : "新增";
        if (IS_POST) {
            $data = input('param.');

            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->intgModel->editData($data);
            if ($result) {
                $this->success($title.'成功', url('index'));
            } else {
                $this->error($this->intgModel->getError());
            }
        } else {
            //设置默认值
            $info= $this->intgModel->get($id);
            $builder = builder('Form')
                        ->addFormItem('id', 'hidden', 'UID', '')
                        ->addFormItem('type', 'select', '类型', '',[1=>'帖子被赞',2=>'回复被踩',3=>'举报核销',4=>'漏签',5=>'被人举报核实',6=>'签到',7=>'举报他人核实'])
                       // ->addFormItem('types', 'select', '状态', '',[1=>'增加',2=>'减少'])
                        ->addFormItem('integral', 'text', '积分', '填写积分','','require')
                        ->setFormData($info)//->setAjaxSubmit(false)
                        ->addButton('submit')
                        ->addButton('back')    // 设置表单按钮
                        ->fetch();
            return (new Iframe())
                    ->setMetaTitle($title.'积分')
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
        $params = $this->request->param();
        //自定义查询条件
        $search_setting = [
            'keyword_condition'=>'id|integral',
            //忽略数据库不存在的字段
            //'ignore_keys' => ['create_time_range','group_id'],
            //扩展的查询条件
            //'extend_conditions'=>$extend_conditions
        ];

        return $search_setting;
    }


}
