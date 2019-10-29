<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\api\validate;
class Bank extends \think\Validate
{
    protected $rule = [
        'type|银行卡类型'  =>  'require',
        'name|持卡人姓名' =>  'require',
        'tel|持卡人手机号'=>'require',
        'number|银行卡号'=>'require',
        'type_id|银行'=>'require',
        'open_bank|开户行'=>'require',
    ];

}