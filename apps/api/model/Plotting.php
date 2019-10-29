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

class Plotting extends \think\Model
{
    protected $table='eacoo_plotting';
    protected $autoWriteTimestamp = true;

    //定义模型一对多关系
    public function details(){
        return $this->hasMany('PlottingDetails','plotting_id','id');
    }
}