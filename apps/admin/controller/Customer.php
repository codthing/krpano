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
 * 客服管理
 */
class Customer extends Admin
{
    protected $customer;
    //protected $groupIds;

    function _initialize()
    {
        parent::_initialize();

        $this->customer = model('Customer');
    }

    /**
     * 编辑客户
     */
    public function index($id = 1) {
        // $title = $uid ? "编辑" : "新增";
        $title = '编辑';
        if (IS_POST) {
            $data = input('param.');
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->customer->editData($data);

            if ($result) {
                $this->success($title.'成功', url('index'));
            } else {
                $this->error($this->customer->getError());
            }
        } else {

            return (new Iframe())
                ->setMetaTitle($title.'联系客服')
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
            $info = $this->customer->get($id);
            //unset($info['password']);
        }
        return builder('Form')
            ->addFormItem('id', 'hidden', 'id', '')
            ->addFormItem('line_code', 'picture', 'LINE客户二维码')
            ->addFormItem('facbook_code', 'picture', 'FACBOOK客户二维码')
            ->addFormItem('tel', 'left_icon_number', '客服电话', '',['icon'=>'<i class="fa fa-phone"></i>'],'placeholder="填写电话"')
            ->setFormData($info)//->setAjaxSubmit(false)
            ->addButton('submit')
            ->addButton('back')    // 设置表单按钮
            ->fetch();
    }


}
