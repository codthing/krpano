<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\api\validate;
class Selfs extends \think\Validate
{
    protected $rule = [
        'title|自我介绍标题'  =>  'require',
        'content|自我介绍类容' =>  'require',
    ];

}