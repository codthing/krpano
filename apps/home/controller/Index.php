<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 https://www.eacoophp.com, All rights reserved.         
// +----------------------------------------------------------------------
// | [EacooPHP] 并不是自由软件,可免费使用,未经许可不能去掉EacooPHP相关版权。
// | 禁止在EacooPHP整体或任何部分基础上发展任何派生、修改或第三方版本用于重新分发
// +----------------------------------------------------------------------
// | Author:  心云间、凝听 <981248356@qq.com>
// +----------------------------------------------------------------------
namespace app\home\controller;

use think\Db;

class Index extends Home {

    function _initialize()
    {
        parent::_initialize();

    }
    
    /**
     * 首页
     * @return [type] [description]
     */
    public function index()
    {

        $va['email'] = array('eq', '1196549990@qq.com');
        $m = db('member')->where($va)->find();

        dump($m);
       /* $this->pageInfo('首页','home');
    	return $this->fetch();*/
    }


    
}