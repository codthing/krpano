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

class Record extends \think\Model
{
    protected $table='eacoo_record';
    protected $autoWriteTimestamp = true;

    //通过会员id查询拨打记录数
    public function get_record($member_id=0){
        if (empty($member_id)){
            return 0;
        }
        $map['status']=array('eq',1);
        $map['member_id']=array('eq',$member_id);
        $records=Db::name('record')->where($map)->count();

        //查看记录状态
        $status=Db::name('record')->where($map)->column('sta');
        if(in_array(1,$status)){
            $status=1;
        }else{
            $status=0;
        }
        $data=['record'=>$records,'status'=>$status];
        return $data;
    }



}