<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\api\validate;
class Service extends \think\Validate
{
    protected $rule = [
        'title|服务名称'  =>  'require',
        'icon|宣传图' =>  'require',
        'details|服务描述'=>'require',
        'service_class|服务分类'=>'require',
        'taiwan|服务区域'=>'require',
        'service_time|服务时间'=>'require',
    ];

}