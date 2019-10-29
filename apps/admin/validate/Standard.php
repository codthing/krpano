<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\admin\validate;
use think\Validate;
class Standard extends Validate
{
    protected $rule = [
        'details_id|场景id'  =>  'require',
       // 'plotting_id|展绘id'  =>  'require',
        'ath|横坐标'  =>  'require',
        'img_url|图片路径'  =>  'require',
        'atv|纵坐标'  =>  'require',
        'type|类型'  =>  'require',
       // 'url|导航地址'  =>  'require',
    ];
    protected $scene = [
        'add1'  =>  ['detials_id','plotting_id','ath','atv','type'],
    ];
}