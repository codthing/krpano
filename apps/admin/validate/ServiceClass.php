<?php
// 规则验证器
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 https://www.eacoophp.com, All rights reserved.         
// +----------------------------------------------------------------------
// | [EacooPHP] 并不是自由软件,可免费使用,未经许可不能去掉EacooPHP相关版权。
// | 禁止在EacooPHP整体或任何部分基础上发展任何派生、修改或第三方版本用于重新分发
// +----------------------------------------------------------------------
// | Author:  心云间、凝听 <981248356@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\validate;

use think\Validate;

class ServiceClass extends Validate
{
    // 验证规则
    protected $rule = [
        'title' => 'require',
        'icon'  => 'require',
    ];

    protected $message = [
        'title.require'   => '标题不能为空',
        'icon.require'    => '图片不能为空',
        // 'name.between' => '链接长度为1-80个字符',
        // 'name.unique'  => '链接已经存在',
    ];

    protected $scene=[
        'edit' => ['title','icon'],
    ];
}