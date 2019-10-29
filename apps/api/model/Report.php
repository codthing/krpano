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

class Report extends \think\Model
{
    protected $table='eacoo_report';
    protected $autoWriteTimestamp = true;

    //获取举报列表
    public function get_list($status=1,$page=1,$sumpage=20){
        $map['status']=array('eq',$status);//未处理
        $map['sadmin']=array('eq',0);//非管理员举报管理员

        //分页

        $count=db('report')->where($map)->count();//总记录数
        $tou_page=ceil($count/$sumpage);//总页码
        if(($page-1)*$sumpage >$count){
            $page =$tou_page;//最大页码
        }
        if(($page-1)*$sumpage <0){
            $page =1;//最小页码
        }
        $startpag=($page-1)*$sumpage;

        $report = db('report')->where($map)->field('id,content,create_time')->limit($startpag,$sumpage)->select();
        if ($report){
            foreach ($report as $k=>$v){
                $report[$k]['create_time']=date('Y-m-s H:i',$v['create_time']);
            }
           return $report;
        }else{
           return false;
        }
    }


    //获取举报详情
    public function get_details($id){
        $report=$this->where('id',$id)->find();
        if ($report){
            $bmember=db('member')->where('id',$report->pid)->field('id,name,icon')->find();
            $data['pmember_name']=$bmember['name'];//被举报人
            $data['pmember_icon_path']=Publics::get_icon($bmember['icon']);
            $model=new Article();
            $article=$model->where('id',$report->ac_id)->find();

            if ($report['type']==1){//帖子
                $data['pmember_content']=cutstr_html($article->content,20);
                $data['article_title']=$article->title;
            }elseif ($report['type']==2){//评论
                $data['pmember_content']=mb_substr(db('comment')->where('id',$report->ad_id)->value('comment'),0,20,'utf-8');
                $data['article_title']=db('article')->where('id',db('comment')->where('id',$report->ad_id)->value('article_id'))->value('title');
            }


            //举报类型
            $category=explode(',',$report->category_id);
            $map['id']=array('in',$category);
            $map['status']=array('eq',1);
            $map['type']=array('eq',1);//举报类型
            $data['category']=db('category')->where($map)->field('id,name')->select();
            $data['member_content']=$report->content;//举报类容
            $member=db('member')->where('id',$report->member_id)->field('id,name,icon,create_time')->find();
            $data['member_name']=$member['name'];//举报人
            $data['member_icon_path']=Publics::get_icon($member['icon']);//举报人头像
            $data['member_reg_time']=date('Y-m-d',$member['create_time']);//举报人注册时间
            $data['report_id']=$id;

            return $data;

        }else{

            return false;
        }


    }




}