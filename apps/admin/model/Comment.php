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

class Comment extends Base
{
    protected $table='eacoo_comment';
    protected $autoWriteTimestamp = true;

    //获取帖子名称名
    public function getArticleNameAttr($value,$data){
        $map['article_id']=array('eq',$data['article_id']);
        $map['type']=array('eq',1);
        return db('article_details')->where($map)->value('words');
    }

    //获取评论人
    public function getMemberNameAttr($value,$data){
        return db('member')->where('id',$data['member_id'])->value('name');
    }



}