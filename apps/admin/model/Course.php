<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/18
 * Time: 17:06
 */

namespace app\admin\model;

use app\api\controller\Publics;
use app\common\model\Base;
class Course extends Base
{
    protected $table='eacoo_course';
    protected $autoWriteTimestamp = true;

    //获取会员昵称
    public function getStatusTextAttr($value,$data)
    {
        $s=['禁用','正常'];
        return $s[$data['status']];
    }

    //获取会员昵称
    public function getContentValueAttr($value,$data)
    {
      return mb_substr($data['content'],0,10,'utf-8').'....';
    }

    //获取会员昵称
    public function getCourseTimeAttr($value,$data)
    {
        return date('Y-m-d',$value);
    }



}