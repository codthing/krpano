<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
return [
    // +----------------------------------------------------------------------
    // | 应用设置
    // +----------------------------------------------------------------------

    'database'=>[
        'auto_timestamp' => true,
        'resultset_type' => '\think\Collection',//解决模型中用toarry报错问题
        'datetime_format' => false,
    ],

    'template'               => [

        //'view_path'=>'../apps/home/view/',
        'view_path'=>ROOT_PATH.'apps/api/view/',
        'auto_rule'   => 1,
        //'view_path'=>'/home/wwwroot/jbba/apps/home/view/',
        //替换输出
        'tpl_replace_string' => [

            "__CSS__"=>"/static/api/css",
            "__JS__"=>"/static/api/js",
            "__IMAGES__"=>"/static/api/images",
            "__LAYUI__"=>"/static/api/layui",
        ],
    ],

];