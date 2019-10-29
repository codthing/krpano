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
use think\Db;

class News extends Base
{
    protected $table='eacoo_news';
    protected $autoWriteTimestamp = true;


    public function getStatusTextAttr($value,$data)
    {
        $s=['禁用','正常'];
        return $s[$data['status']];
    }

    //获取会员昵称
    public function getCreateTimeAttr($value,$data)
    {
        return date('Y-m-d',$value);
    }


}