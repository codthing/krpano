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

class Point extends Base
{
    protected $table='eacoo_member_integral';
    protected $autoWriteTimestamp = true;



    //获取会员昵称
    public function getMemberNameAttr($value,$data)
    {
        return Db::table('eacoo_member')->where('id',$data['member_id'])->value('name');
       // return Publics::get_icon($value);//获取图片路径
        //$status = [ 1 => '正常', -1 => '删除', 0 => '禁用', 2 => '待审核', 3 => '草稿'];
        // return isset($status[$data['status']]) ? $status[$data['status']] : '未知';
    }

    public function getCreateTimeAttr($value)
    {
        return date('Y-m-d H:i',$value);
    }



}