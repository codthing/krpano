<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\api\validate;
class Works extends \think\Validate
{
    protected $rule = [
        'title|作品集名称'  =>  'require',
        'icon|作品图片' =>  'require',
        'describe|作品描述'=>'require',
    ];

}