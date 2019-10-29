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

use app\admin\model\ArticleDetails;
use app\api\controller\Publics;
use app\common\layout\Iframe;
use app\admin\model\Member as MemberModel;
use think\Db;
use think\Loader;
use think\Request;
use think\View;

/**
 * Class Shop
 * @package app\admin\controller
 * 评论管理
 */
class Comment extends Admin
{

    protected $comment;

    function _initialize()
    {
        parent::_initialize();

        $this->comment = model('Comment');


    }

    /**
     * @return \app\common\layout\Content
     * 评论详情
     */
    public function comment(){

        $search_setting = $this->buildModelSearchSetting();

        // 获取数据
        $condition['status'] = ['egt', '0']; //未审核
        list($data_list, $total) = $this->comment->search($search_setting,['data'=>123])->getListByPage($condition, true, 'create_time desc');

        if (input('member_id')){//会员列表
            $u=url(MODULE_NAME.'/member/index');
        }else{//帖子列表
            $u=url(MODULE_NAME.'/article/index');
        }



        $form=builder('list')
            ->setMetaTitle('评论列表')// 设置页面标题
            //->addTopButton('addnew')// 添加新增按钮
            ->addTopButton('delete')// 添加删除按钮
            ->addTopButton('self',['title'=>'返回','class'=>'btn btn-info','href'=>$u])// 添加删除按钮
            //->setActionUrl(url('comment'))//设置请求地址
            ->keyListItem('id', 'UID')
            // ->keyListItem('integral', '绑定手机送积分')
            ->keyListItem('article_name', '帖子名称')
            ->keyListItem('member_name', '评论人')
            ->keyListItem('comment', '评论')
            ->keyListItem('create_time', '评论时间')
            ->keyListItem('right_button', '操作', 'btn')
            ->setListPrimaryKey('id')
            ->setListData($data_list)// 数据列表
            ->setListPage($total)// 数据列表分页
            // ->setExtraHtml($extra_html)//设置htm代码
            //->addRightButton('edit')
           // ->addRightButton('self', array('title' => '删除', 'class' => 'btn btn-danger btn-xs ajax-get', 'href' => url(MODULE_NAME . '/article/delete', ['id' => '__data_id__'])))
            //->addRightButton('self', array('title' => '禁用ip', 'class' => 'btn btn-warning btn-xs ajax-get qi', 'href' => url(MODULE_NAME . '/article/form', ['id' => '__data_id__'])))
            // ->addRightButton('self',$reset_password)
            ->addRightButton('forbid')  // 添加编辑按钮
            ->addRightButton('delete')  // 添加编辑按钮
            ->fetch();


        return (new Iframe())
            ->setMetaTitle('评论列表')
            ->search([
                ['name' => 'create_time', 'type' => 'daterange', 'extra_attr' => 'placeholder="评论时间"'],
                /*    ['name' => 'status', 'type' => 'select', 'title' => '状态', 'options' => [1 => '正常', 0 => '禁用']],
                   ['name' => 'sex', 'type' => 'select', 'title' => '性别', 'options' => [0 => '未知', 1 => '男', 2 => '女']],
                   ['name' => 'is_lock', 'type' => 'select', 'title' => '是否锁定', 'options' => [0 => '否', 1 => '是']],
                   ['name' => 'name', 'type' => 'text', 'extra_attr' => 'placeholder="请输入会员昵称"'],*/
            ])
            ->content($form);

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
        $keyword=input('keyword');
        $extend_conditions = [];
        if ($keyword){
            //查询会员
            $map['status']=array('eq',1);
            $map['name']=array('like','%'.$keyword.'%');
            $member=db('member')->where($map)->column('id');
            if ($member){
                $extend_conditions['member_id']=['in',$member];
            }else{
                $extend_conditions['comment']=['like','%'.$keyword.'%'];
            }


        }
        //查询帖子id
        $article_id=input('article_id');
        if ($article_id){
            $extend_conditions['article_id']=['eq',$article_id];
        }


        if ($timegap) {
            $gap = explode('—', $timegap);
            $reg_begin = $gap[0];
            $reg_end = $gap[1];
            $extend_conditions['create_time']=['between',[strtotime($reg_begin . ' 00:00:00'), strtotime($reg_end . ' 23:59:59')]];
        }

        //自定义查询条件
        $search_setting = [
            'keyword_condition' => 'id|comment',
            //忽略数据库不存在的字段
            'ignore_keys' => ['data'],
            //扩展的查询条件
            'extend_conditions' => $extend_conditions
        ];

        return $search_setting;
    }

    /**
     * 设置用户的状态
     */
    public function setStatus($model = CONTROLLER_NAME, $script = false)
    {
        $ids = input('param.ids/a');

        if (!empty($ids)) {
            foreach ($ids as $key => $uid) {
                //清理缓存
                cache('User_info_' . $uid, null);
            }
        }
        parent::setStatus($model);
    }

    /**
     * @param int $id
     * @throws \think\Exception
     * @throws \think\exception\PDOExceptions
     * 删除帖子
     */
    public function delete($id = 0)
    {
        if ($id == 0) {
            $this->error('没有可操作的数据');
            exit();
        }
        //删除帖子
        $rest = Db::table('eacoo_comment')->where('id', $id)->delete();
        if (false != $rest) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }

    }

}
