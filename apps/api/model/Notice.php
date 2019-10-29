<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/18
 * Time: 17:06
 */

namespace app\api\model;

use app\api\controller\Publics;
use think\Db;

class Notice extends \think\Model
{
    protected $table='eacoo_notice';
    protected $autoWriteTimestamp = true;

}