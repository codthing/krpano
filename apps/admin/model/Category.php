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
class Category extends Base
{
    protected $table='eacoo_category';
    protected $autoWriteTimestamp = true;

    //获取会员昵称
    public function getStatusTextAttr($value,$data)
    {
        $s=['禁用','正常'];
        return $s[$data['status']];
    }


}