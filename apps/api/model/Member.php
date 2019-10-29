<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/18
 * Time: 17:06
 */

namespace app\api\model;

use app\api\controller\Publics;

class Member extends \think\Model
{
    protected $table='eacoo_member';
    protected $autoWriteTimestamp = true;



    /*public function getIconAttr($value)
    {
        return Publics::get_icon($value);//获取图片路径
        //$status = [ 1 => '正常', -1 => '删除', 0 => '禁用', 2 => '待审核', 3 => '草稿'];
       // return isset($status[$data['status']]) ? $status[$data['status']] : '未知';
    }*/


    public function getSexAttr($value)
    {
        $sex = [ 0 => '保密', 1 => '男', 2 => '女'];
        return $sex[$value];
    }



    /**
     * @param $data
     * @param int $id
     * @return bool
     * 修改参数
     */
    public function update_member($data,$id=0){
        if (empty($id) || $id==0){
            return false;
        }
        $result=$this->allowField(true)->save($data,['id'=>$id]);
        if ($result !==false){
            return true;
        }else{
            return false;
        }

    }

    //定义模型一对多关系
    public function login_record(){
        return $this->hasMany('LoginRecord','member_id','id');
    }

}