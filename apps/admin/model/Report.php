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

class Report extends Base
{
    protected $table='eacoo_report';
    protected $autoWriteTimestamp = true;

    //获取用户名
    public function getMemberNameAttr($value,$data){
        return db('member')->where('id',$data['member_id'])->value('name');
    }

    //被举报名称
    public function getNameAttr($value,$data){

            if ($data['type'] ==1){//帖子
                $map['article_id']=array('eq',$data['ac_id']);
                $map['type']=array('eq',1);
                $name =db('article_details')->where($map)->value('words');
            }else{//评论

                $name =db('comment')->where('id',$data['ac_id'])->value('comment');
                $name =mb_substr($name,'0','10','utf-8').'....';

            }
            return $name;
    }

    //举报内容
    public function getContentAttr($value){
        return mb_substr($value,0,10,'utf-8').'....';
    }

}