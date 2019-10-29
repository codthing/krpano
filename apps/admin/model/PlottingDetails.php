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

class PlottingDetails extends Base
{
    protected $table='eacoo_plotting_details';
    protected $autoWriteTimestamp = true;
    //protected $autoWriteTimestamp = false;


   /* //获取会员昵称
    public function getMemberNameAttr($value,$data)
    {
       return db('member')->where('id',$data['member_id'])->value('name');
    }*/

    public function getPlottingNameAttr($value,$data)
    {
        return db('Plotting')->where('id',$data['plotting_id'])->value('title');
    }

}