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
 * 会员管理
 */
class Member extends Admin
{
    protected $member;
    function _initialize()
    {
        parent::_initialize();

        $this->member = model('Member');

    }

    /**
     * 管理员列表
     * @return [type] [description]
     * @date   2018-02-05
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function index()
    {
        //$gap = explode('—', '2019-5-30 09:49:20');
        return (new Iframe())
            ->setMetaTitle('会员列表')
         /*   ->search([
                ['name' => 'reg_time_range', 'type' => 'daterange', 'extra_attr' => 'placeholder="注册时间"'],
                ['name' => 'status', 'type' => 'select', 'title' => '状态', 'options' => [1 => '正常', 0 => '禁用']],
                ['name' => 'sex', 'type' => 'select', 'title' => '性别', 'options' => [0 => '未知', 1 => '男', 2 => '女']],
                ['name' => 'is_lock', 'type' => 'select', 'title' => '是否锁定', 'options' => [0 => '否', 1 => '是']],
                ['name' => 'name', 'type' => 'text', 'extra_attr' => 'placeholder="请输入会员昵称"'],
            ])*/
            ->content($this->grid());
    }

    public function grid()
    {
        $search_setting = $this->buildModelSearchSetting();
        // 获取数据
        $condition['status'] = ['egt', '0']; // 禁用和正常状态
        list($data_list, $total) = $this->member->search($search_setting)->getListByPage($condition, true, 'create_time desc');
        return builder('list')
            ->setMetaTitle('用户列表') // 设置页面标题
            ->addTopButton('addnew')  // 添加新增按钮
            ->addTopButton('resume')  // 添加启用按钮
            ->addTopButton('forbid')  // 添加禁用按钮
            ->addTopButton('delete')  // 添加删除按钮
            //->addTopButton('self',$reset_password)  // 添加重置按钮
            //->setSearch('custom','请输入ID/用户名/昵称')
            ->setActionUrl(url('grid')) //设置请求地址
            ->keyListItem('id', 'UID')
            // ->keyListItem('integral', '绑定手机送积分')
            ->keyListItem('name', '商家名称')
            ->keyListItem('tel', '电话')
            ->keyListItem('icon','头像','picture',['width'=>30])
            ->keyListItem('sex', '性别','array',[1=>'男',2=>'女'])
            ->keyListItem('right_button', '操作', 'btn')
            ->setListPrimaryKey('id')
            ->setListData($data_list)// 数据列表
            ->setListPage($total)// 数据列表分页
            ->addRightButton('edit')
            ->addRightButton('delete',array('title' => '删除用户', 'confirm-info' => '你确定要删除用户吗？', 'href' => url(MODULE_NAME . '/' . CONTROLLER_NAME . '/delete', ['id' => '__data_id__'])))
            ->addRightButton('self',array('title' => '新增展绘','class'=>'btn btn btn-info btn-xs','href' => url(MODULE_NAME . '/plotting/edit', ['member_id' => '__data_id__'])))
            /*->addRightButton('self',array('title' => '积分明细','class'=>'btn btn-success btn-xs','href' => url(MODULE_NAME . '/point/index', ['member_id' => '__data_id__'])))
            ->addRightButton('self',array('title' => '查看帖子','class'=>'btn btn btn-info btn-xs','href' => url(MODULE_NAME . '/article/index', ['member_id' => '__data_id__'])))
            ->addRightButton('self',array('title' => '查看回复','class'=>'btn btn btn-info btn-xs','href' => url(MODULE_NAME . '/comment/comment', ['member_id' => '__data_id__'])))*/
           // ->addRightButton('self',$reset_password)
            //->addRightButton('forbid')
            //->addRightButton('edit')  // 添加编辑按钮
            ->fetch();
    }
    public function edit($id = 0) {
        $title = $id ? "编辑" : "新增";
        if (IS_POST) {
            $data = input('param.');
            // 密码为空表示不修改密码
            if ($data['password'] === '') {
                $data['password']=md5('123456');
                $data['password_plaintext']=123456;
            }else{
                $data['password_plaintext']=$data['password'];
                $data['password']=md5($data['password']);
            }
            if ($data['icon'] ===''){
                $data['icon']=179;
            }

            if ($data['name'] ===''){
                $data['name']=member_name(8);
            }

           /* if ($data['create_time'] === ''){
                $data['create_time']=time();
            }else{
                $data['create_time']=strtotime($data['create_time']);
            }*/
            $id  = isset($data['id']) && $data['id']>0 ? intval($data['id']) : false;
            $validate = Loader::validate('Member');
            if ($id>0) {
                //$this->validateData($data,'User.edit');
               if (!$validate->scene('edit')->check($data)){
                    $this->error($validate->getError());exit();
               }
            } else{
                if (!$validate->check($data)){
                    $this->error($validate->getError());exit();
                }
               // $this->validateData($data,'User.add');
            }
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->member->editData($data);
            if ($result) {
                $this->success($title.'成功', url('index'));
            } else {
                $this->error($this->member->getError());
            }
        } else {
            return (new Iframe())
                ->setMetaTitle($title.'商家')
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

        // 获取账号信息
        $info = $this->member->get($id);
        return builder('Form')
            ->addFormItem('id', 'hidden', 'UID', '')
            ->addFormItem('name', 'text', '商家昵称', '登录账户所用名称','','require')
            ->addFormItem('email', 'text', '用户邮箱', '用户邮箱')
            ->addFormItem('password', 'password', '密码', '新增默认密码123456','','placeholder="留空则不修改密码"')
            ->addFormItem('tel', 'left_icon_number', '手机号', '',['icon'=>'<i class="fa fa-phone"></i>'],'placeholder="填写手机号"')
            ->addFormItem('icon', 'picture', '头像', '请设置头像')

            //->addFormItem('create_time', 'datetime', '注册时间')
            ->addFormItem('sex', 'radio', '性别', '',[0=>'保密',1=>'男',2=>'女'])
            ->addFormItem('status', 'radio', '状态', '',[1=>'正常',0=>'禁用'])
            ->addFormItem('autograph', 'textarea', '个性签名')
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
            'keyword_condition' => 'id|name|tel|sex',
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
        $rest=Db::table('eacoo_member')->where('id',$id)->delete();
        //删除会员所有帖子和回复
        db('article')->where('member_id',$id)->delete();
        db('comment')->where('member_id',$id)->delete();
        if (false !=$rest){
            $this->success('删除成功');
        }else{
            $this->error('删除失败');
        }

    }

}
