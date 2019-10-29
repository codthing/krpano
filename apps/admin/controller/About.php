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
 * 联系我们
 */
class About extends Admin
{
    protected $about;
    //protected $groupIds;

    function _initialize()
    {
        parent::_initialize();

        $this->about = model('About');
    }

    /**
     * 编辑用户
     */
    public function index($id = 1) {
       // $title = $uid ? "编辑" : "新增";
        $title = '编辑';
        if (IS_POST) {
            $data = input('param.');
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->about->editData($data);

            if ($result) {
                $this->success($title.'成功', url('index'));
            } else {
                $this->error($this->about->getError());
            }
        } else {

            return (new Iframe())
                ->setMetaTitle($title.'联系我们')
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
       /* $info = [
            'sex'     =>0,
            'is_lock' =>0,
            'status'  =>1
        ];*/
       $info=[];
        // 获取账号信息
        if ($id>0) {
            $info = $this->about->get($id);
            //unset($info['password']);
        }
        return builder('Form')
            ->addFormItem('id', 'hidden', 'id', '')
            ->addFormItem('title', 'text', '公司名称', '公司名称')
            ->addFormItem('security_tel', 'text', '保安电话', '保安电话')
            ->addFormItem('recruit_tel', 'text', '人员招聘电话', '人员招聘电话')
            ->addFormItem('complaint_tel', 'text', '投诉电话', '投诉电话')
            ->addFormItem('server_tel', 'text', '业务电话', '业务电话')
            ->addFormItem('command_tel', 'text', '指挥中心电话', '指挥中心电话')
           // ->addFormItem('email', 'text', '公司邮箱', '公司邮箱')
            ->addFormItem('weixing_icon', 'picture', '微信二维码', '微信二维码')
            ->addFormItem('address', 'text', '公司地址')
            ->addFormItem('fax', 'text', '传真', '传真')
            ->addFormItem('work_time', 'text', '工作时间', '工作时间')
            ->addFormItem('qq', 'text', 'qq', 'qq')
            //->addFormItem('password', 'password', '密码', '新增默认密码123456','','placeholder="留空则不修改密码"')
            ->addFormItem('email', 'email', '邮箱', '','','data-rule="email" data-tip="请填写一个邮箱地址"')
           // ->addFormItem('tel', 'left_icon_number', '手机号', '',['icon'=>'<i class="fa fa-phone"></i>'],'placeholder="填写手机号"')
           // ->addFormItem('content', 'textarea', '主要说明', '请填说明')
            ->setFormData($info)//->setAjaxSubmit(false)
            ->addButton('submit')
            ->addButton('back')    // 设置表单按钮
            ->fetch();
    }



}
