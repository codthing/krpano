<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\admin\validate;
use think\Validate;
class Course extends Validate
{
    protected $rule = [
        'title|历程名称'  =>  'require',
        'content|历程类容'  =>  'require',
        'course_time|历程时间'  =>  'require',
    ];
    protected $scene = [
        'edit'  =>  ['title','content','course_time'],
    ];
}