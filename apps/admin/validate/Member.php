<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\admin\validate;
use think\Validate;
class Member extends Validate
{
    protected $rule = [
        'name|用户昵称'  =>  'require',
        'tel|手机'  =>  'require',
        'email|邮箱'  =>  'require',
        'sex|性别'=>'require',
    ];
    protected $scene = [
        'edit'  =>  ['name','sex','tel','email'],
    ];
}