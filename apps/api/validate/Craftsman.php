<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\api\validate;
class Craftsman extends \think\Validate
{
    protected $rule = [
        'name|工匠名称'=>'require',
        'age|年龄'=>'require',
        'idcode|身份证号'=>'require',
        'sex|性别'=>'require',
        'tel|电话'=>'require',
        'pre_yeaer|从业年限'=>'require',
        'self_id|自我介绍'=>'require',
        'taiwan_id|服务范围'=>'require',
        'sclass_id|服务分类'=>'require',
        //'prop_id|宣传集'=>'require',
        //'license|职业技术执照'=>'require',
        'category_id|工匠类型'=>'require',
    ];

}