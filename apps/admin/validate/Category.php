<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\admin\validate;
use think\Validate;
class Category extends Validate
{
    protected $rule = [
        'title|导航名称'  =>  'require',
        'type|类型'  =>  'require',
       // 'url|导航地址'  =>  'require',
    ];
    protected $scene = [
        'edit'  =>  ['title'],
    ];
}