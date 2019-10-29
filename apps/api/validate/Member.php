<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\api\validate;
class Member extends \think\Validate
{
    protected $rule = [
        'name|用户昵称'  =>  'require',
        'icon|用户头像' =>  'require',
        'tel|手机号' =>  'require|max:11|/^1[3-8]{1}[0-9]{9}$/|unique:member',
        'email|邮箱'=>'require',
        'sex|性别'=>'require',
        'password|密码'=>'require',
        'autograph|个性签名'=>'require',
        'qq_id|qq'=>'require',
        'wx_id|微信'=>'require',
    ];

    //场景验证
    protected $scene = [
        'tel'  =>  ['tel','password'],
        'email'  =>  ['email','password','name'],
        'name'  =>  ['password','name'],
    ];


}