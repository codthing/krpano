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
 * 后台统计管理
 */
class Count extends Admin
{

    /**
     * @param Request $request
     * 统计详情
     */
    public function index(Request $request)
    {

        $create_time=input('create_time');
        if ($create_time){
            $data=explode('~',$create_time);
            $start_time=strtotime($data[0]);
            $end_time=strtotime($data[1]);

           //总会员数
            $count =db('member')->count();

            $map['create_time']=array('between',[$start_time,$end_time]);
            //单位时间内新增会员数
            $newcount=db('member')->where($map)->count();

            //单位时间内访问过的数量
            $map2['timestamp']=array('between',[$start_time,$end_time]);
            $logincount=db('login_record')->where($map2)->count();

            //单位时间内，互动过的数量
            $interaction=db('comment')->where($map)->count();

        }else{
            //总会员数
            $count =db('member')->count();
            $data=[
              strtotime(date('Y-m-d',time())),strtotime(date('Y-m-d',time()))+86400
            ];

            $map['create_time']=array('between',$data);
            //单位时间内新增会员数
            $newcount=db('member')->where($map)->count();
            //单位时间内访问过的数量
            $map2['timestamp']=array('between',$data);
            $logincount=db('login_record')->where($map2)->count();

            //单位时间内，互动过的数量
            $interaction=db('comment')->where($map)->count();
        }

        $value=[
          'count'=>$count,
          'new_count'=>$newcount,
          'login_count'=>$logincount,
          'interaction'=>$interaction
        ];
        $this->view->assign('create_time',$create_time);
        $this->view->assign('data',$value);
        return $this->fetch();
    }





}
