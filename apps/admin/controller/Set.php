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
 * 后台设置
 */
class Set extends Admin
{
    protected $set;
    //protected $groupIds;

    function _initialize()
    {
        parent::_initialize();

        $this->set = model('Set');
    }

    /**
     * 联系客户
     */
    public function index($id = 1) {
       // $title = $uid ? "编辑" : "新增";
        $title = '编辑';
        if (IS_POST) {
            $data = input('param.');
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->set->editData($data);

            if ($result) {
                $this->success($title.'成功', url('index'));
            } else {
                $this->error($this->set->getError());
            }
        } else {

            return (new Iframe())
                ->setMetaTitle($title.'联系客户')
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
            $info = $this->set->get($id);
            //unset($info['password']);
        }
        return builder('Form')
            ->addFormItem('id', 'hidden', 'id', '')
            ->addFormItem('customer_tel', 'text', '客户电话', '电话','require')
          /*  ->addFormItem('title', 'text', '关于我们标题', '填写一个标题','','require')
            ->addFormItem('qq', 'text', '官方qq','官方qq','require')
            ->addFormItem('weixing', 'text', '官方微信', '官方微信','','require')
            //->addFormItem('password', 'password', '密码', '新增默认密码123456','','placeholder="留空则不修改密码"')
            ->addFormItem('email', 'email', '邮箱', '','','data-rule="email" data-tip="请填写一个邮箱地址"')
            ->addFormItem('tel', 'left_icon_number', '手机号', '',['icon'=>'<i class="fa fa-phone"></i>'],'placeholder="填写手机号"')
            ->addFormItem('content', 'textarea', '主要说明', '请填说明')*/
            ->setFormData($info)//->setAjaxSubmit(false)
            ->addButton('submit')
            //->addButton('back')    // 设置表单按钮
            ->fetch();
    }

    /**
     * 编辑积分权限
     */
    public function admin($id = 1) {
        // $title = $uid ? "编辑" : "新增";
        $title = '编辑';
        if (IS_POST) {
            $data = input('param.');
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->set->editData($data);

            if ($result) {
                $this->success($title.'成功', url('admin'));
            } else {
                $this->error($this->set->getError());
            }
        } else {

            return (new Iframe())
                ->setMetaTitle($title.'积分权限')
                ->content($this->form2($id));
        }
    }

    /**
     * 表单构建
     * @param  integer $id [description]
     * @return [type] [description]
     * @date   2018-10-03
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function form2($id = 0)
    {
        /* $info = [
             'sex'     =>0,
             'is_lock' =>0,
             'status'  =>1
         ];*/
        $info=[];
        // 获取账号信息
        if ($id>0) {
            $info = $this->set->get($id);
            //unset($info['password']);
        }
        return builder('Form')
            ->addFormItem('id', 'hidden', 'id', '')
            ->addFormItem('admin_integral', 'text', '成为管理员所需积分', '单位(分)','require')
            ->addFormItem('new_integral', 'text', '成为新手所需积分', '单位(分)','require')
            ->addFormItem('plain_integral', 'text', '成为普通用户所需积分', '单位(分)','require')
            /*  ->addFormItem('title', 'text', '关于我们标题', '填写一个标题','','require')
              ->addFormItem('qq', 'text', '官方qq','官方qq','require')
              ->addFormItem('weixing', 'text', '官方微信', '官方微信','','require')
              //->addFormItem('password', 'password', '密码', '新增默认密码123456','','placeholder="留空则不修改密码"')
              ->addFormItem('email', 'email', '邮箱', '','','data-rule="email" data-tip="请填写一个邮箱地址"')
              ->addFormItem('tel', 'left_icon_number', '手机号', '',['icon'=>'<i class="fa fa-phone"></i>'],'placeholder="填写手机号"')
              ->addFormItem('content', 'textarea', '主要说明', '请填说明')*/
            ->setFormData($info)//->setAjaxSubmit(false)
            ->addButton('submit')
            //->addButton('back')    // 设置表单按钮
            ->fetch();
    }


    /**
     * 黑名单设置
     */
    public function black($id = 1) {
        // $title = $uid ? "编辑" : "新增";
        $title = '编辑';
        if (IS_POST) {
            $data = input('param.');
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->set->editData($data);

            if ($result) {
                $this->success($title.'成功', url('black'));
            } else {
                $this->error($this->set->getError());
            }
        } else {

            return (new Iframe())
                ->setMetaTitle($title.'黑明单设置')
                ->content($this->form3($id));
        }
    }

    /**
     * 表单构建
     * @param  integer $id [description]
     * @return [type] [description]
     * @date   2018-10-03
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function form3($id = 0)
    {
        /* $info = [
             'sex'     =>0,
             'is_lock' =>0,
             'status'  =>1
         ];*/
        $info=[];
        // 获取账号信息
        if ($id>0) {
            $info = $this->set->get($id);
            //unset($info['password']);
        }
        return builder('Form')
            ->addFormItem('id', 'hidden', 'id', '')
            ->addFormItem('coefficiet_n', 'text', '到期时间系数n', '单位(无)','require')
            ->addFormItem('coefficiet_m', 'text', '到期恢复积分', '单位(分)','require')
            /*  ->addFormItem('title', 'text', '关于我们标题', '填写一个标题','','require')
              ->addFormItem('qq', 'text', '官方qq','官方qq','require')
              ->addFormItem('weixing', 'text', '官方微信', '官方微信','','require')
              //->addFormItem('password', 'password', '密码', '新增默认密码123456','','placeholder="留空则不修改密码"')
              ->addFormItem('email', 'email', '邮箱', '','','data-rule="email" data-tip="请填写一个邮箱地址"')
              ->addFormItem('tel', 'left_icon_number', '手机号', '',['icon'=>'<i class="fa fa-phone"></i>'],'placeholder="填写手机号"')
              ->addFormItem('content', 'textarea', '主要说明', '请填说明')*/
            ->setFormData($info)//->setAjaxSubmit(false)
            ->addButton('submit')
            //->addButton('back')    // 设置表单按钮
            ->fetch();
    }


    /**
     * 编辑邮件类容
     */
    public function econtent($id = 1) {
        // $title = $uid ? "编辑" : "新增";
        $title = '编辑';
        if (IS_POST) {
            $data = input('param.');
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->set->editData($data);

            if ($result) {
                $this->success($title.'成功', url('econtent'));
            } else {
                $this->error($this->set->getError());
            }
        } else {

            return (new Iframe())
                ->setMetaTitle($title.'邮件类容')
                ->content($this->form4($id));
        }
    }

    /**
     * 表单构建
     * @param  integer $id [description]
     * @return [type] [description]
     * @date   2018-10-03
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function form4($id = 0)
    {
        /* $info = [
             'sex'     =>0,
             'is_lock' =>0,
             'status'  =>1
         ];*/
        $info=[];
        // 获取账号信息
        if ($id>0) {
            $info = $this->set->get($id);
            //unset($info['password']);
        }
        return builder('Form')
            ->addFormItem('id', 'hidden', 'id')
            ->addFormItem('email_content', 'ueditor', '邮件类容')
            /*  ->addFormItem('title', 'text', '关于我们标题', '填写一个标题','','require')
              ->addFormItem('qq', 'text', '官方qq','官方qq','require')
              ->addFormItem('weixing', 'text', '官方微信', '官方微信','','require')
              //->addFormItem('password', 'password', '密码', '新增默认密码123456','','placeholder="留空则不修改密码"')
              ->addFormItem('email', 'email', '邮箱', '','','data-rule="email" data-tip="请填写一个邮箱地址"')
              ->addFormItem('tel', 'left_icon_number', '手机号', '',['icon'=>'<i class="fa fa-phone"></i>'],'placeholder="填写手机号"')
              ->addFormItem('content', 'textarea', '主要说明', '请填说明')*/
            ->setFormData($info)//->setAjaxSubmit(false)
            ->addButton('submit')
            //->addButton('back')    // 设置表单按钮
            ->fetch();
    }



}
