<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\admin\validate;
use think\Validate;
class CraftsmanMember extends Validate
{
    protected $rule = [
        'title|套餐标题'  =>  'require',
        'day|套餐天数' =>  'require',
        'price|套餐金额'=>'require',
    ];

}