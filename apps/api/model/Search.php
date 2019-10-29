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

class Search extends \think\Model
{
    protected $table='eacoo_search';
    protected $autoWriteTimestamp = true;

    //收搜,返回标题
    public function search_title($title)
    {

        $map['name'] = array('like', "%" . $title . "%");
        $map['status'] = array('eq', 1);
        $member = db("member")->where($map)->field('id,name')->order('create_time', 'desc')->limit(4)->select();
        $data = [];
        if ($member) {
            foreach ($member as $k => $v) {
                $data[$k] = $v;
                $data[$k]['type'] = 1;//用户
            }
        }
        //查询帖子
        $map2['words'] = array('like', "%" . $title . "%");
        $map2['type'] = array('eq', 1);
        $article = db("article_details")->where($map2)->order('create_time', 'desc')->limit(3)->field('article_id,words')->group('article_id')->select();
        if ($article) {
            $d = [];
            foreach ($article as $k => $v) {
                $d['id'] = $v['article_id'];
                $d['type'] = 2;//帖子
                $d['name'] = mb_substr($v['words'], 0, 8, 'utf-8');
                array_push($data, $d);
            }
        }

        return $data;
    }

    //收搜列表
    public function search_list($data){
        if (isset($data['page']) || !empty($data['page'])){
            $page=$data['page'];
        }else{
            $page=1;
        }
        if (isset($data['sumpage']) || !empty($data['sumpage'])){
            $sumpage=$data['sumpage'];
        }else{
            $sumpage=10;
        }
        switch ($data['type']){
            case 2://最新
               // $value['article']=$this->search_article($data['title'],1,$page,$sumpage);
                $value=$this->search_article($data['title'],1,$page,$sumpage);
                $value['member']=$this->search_member($data['title']);
                break;
            case 3://最热
                //$value['article']=$this->search_article($data['title'],2,$page,$sumpage);
                $value=$this->search_article($data['title'],2,$page,$sumpage);
                $value['member']=$this->search_member($data['title']);
                break;
            case 4://查询全部用户
                if (isset($data['token']) || !empty($data['token'])){
                    $member_id =db('member')->where('token',$data['token'])->value('id');
                    if ($member_id){
                        $value=$this->search_member($data['title'],2,$member_id);
                    }else{
                        $value=$this->search_member($data['title'],2);
                    }

                }else{
                    $value=$this->search_member($data['title'],2);
                }
                break;
        }

        return $value;
    }

    //查询用户
    public function search_member($title,$type=1,$member_id=0){
        $data = [];
        if ($type==1){//默认查询4个用户
            $map['name'] = array('like', "%" . $title . "%");
            $map['status'] = array('eq', 1);
            $member = db("member")->where($map)->field('id,name,icon')->order('create_time', 'desc')->limit(4)->select();
            if ($member) {
                foreach ($member as $k => $v) {
                    $data[$k] = $v;
                    $data[$k]['icon_path']=Publics::get_icon($v['icon']);
                }
            }
        }else{
            //查询全部
            $map['name'] = array('like', "%" . $title . "%");
            $map['status'] = array('eq', 1);
            $member = db("member")->where($map)->field('id,name,icon,autograph')->order('create_time', 'desc')->select();
            if ($member) {
                if ($member_id){
                    foreach ($member as $k => $v) {
                        $data[$k] = $v;
                        $data[$k]['icon_path']=Publics::get_icon($v['icon']);
                        //查询粉丝
                        $data[$k]['fans']=db('follow')->where('pid',$v['id'])->count();
                        //查询是否关注
                       $wh['member_id']=array('eq',$member_id);
                       $wh['pid']=array('eq',$v['id']);
                       $follow=db('follow')->where($wh)->find();
                       if ($follow){
                           $data[$k]['follow']=1;//已关注
                       }else{
                           $data[$k]['follow']=0;//未关注
                       }

                    }
                }else{
                    foreach ($member as $k => $v) {
                        $data[$k] = $v;
                        $data[$k]['icon_path']=Publics::get_icon($v['icon']);
                        //查询粉丝
                        $data[$k]['fans']=db('follow')->where('pid',$v['id'])->count();
                       $data[$k]['follow']=0;//未关注
                    }
                }

            }
        }
        return $data;


    }

    public function search_article($title,$type=1,$page=1,$sumpage=10){
        if ($type ==1){//查询最新的

            $map2['title|content'] = array('like', "%" . $title . "%");
            $map2['status'] = array('eq', 1);

            //分页
            $count=db('article')->where($map2)->count();//总记录数
            $tou_page=ceil($count/$sumpage);//总页码
            if(($page-1)*$sumpage >$count){
                $page =$tou_page;//最大页码
            }
            if(($page-1)*$sumpage <0){
                $page =1;//最小页码
            }
            $startpag=($page-1)*$sumpage;

            $article =db('article')->where($map2)->order('create_time','desc')->limit($startpag,$sumpage)->select();
            //$data['list']=$this->article_p($article);
            $data=$this->article_p($article);

            $data['count']=$count;//统计条数

        }else{//查询最热的

            $comment_count=db('set')->where('id',1)->value('comment_count');//最热的条件
            //查询满足条件的评论
            $coumment=db('comment')->field('count(*) as counts,article_id')->group('article_id')->having('counts>'.$comment_count)->select();
            //获取热评的帖子id
            $article_hotid=array_column($coumment,'article_id');//获取数组中的article_id;

            //获取文章关键字的id
            $map2['title|content'] = array('like', "%" . $title . "%");
            $map2['status'] = array('eq', 1);
            $article_keyid = db('article')->column('id');

            $article_id=array_intersect($article_hotid,$article_keyid);//返回两个数组的交集


            $map['status']=array('eq',1);
            $map['id']=array('in',$article_id);

            //分页
            $count=db('article')->where($map)->count();;//总记录数
            $tou_page=ceil($count/$sumpage);//总页码
            if(($page-1)*$sumpage >$count){
                $page =$tou_page;//最大页码
            }
            if(($page-1)*$sumpage <0){
                $page =1;//最小页码
            }
            $startpag=($page-1)*$sumpage;

            $article=db('article')->where($map)->order('create_time','desc')->limit($startpag,$sumpage)->select();
            $data['list']=$this->article_p($article);
            $data['count']=$count;//统计条数

        }

        return $data;


    }
    public function article_p($article){
        if ($article){
            foreach ($article as $k=>$v){
                $data['article'][$k]=$v;
                $data['article'][$k]['member_name']=get_model_value('member',$v['member_id'],'name');
                $data['article'][$k]['member_icon']=Publics::get_icon(get_model_value('member',$v['member_id'],'icon'));
                $data['article'][$k]['comment_count']=Db::name('comment')->where('article_id',$v['id'])->count();//评论
                $data['article'][$k]['date']=format_date($v['create_time']);

                //查看举报状态
                $wh['type']=array('eq',1);
                $wh['ac_id']=array('eq',$v['id']);
                $report=Db::name('report')->where($wh)->count();
                if ($report !=0){
                    $data['article'][$k]['report']=1;//举报状态
                }else{
                    $data['article'][$k]['report']=0;//未举报
                }
                //$data[$k]['details']= $v->details()->select()->toArray();
            }
        }else{
            $data=[];
        }

        return $data;
    }


  /*  //查询文章
    public function search_article2($title,$type=1,$page=1,$sumpage=10){
        if ($type ==1){//查询最新的

            $map2['words'] = array('like', "%" . $title . "%");
            $map2['type'] = array('eq', 1);
            $article_id = db('article_details')->where($map2)->group('article_id')->column('article_id');
            //通过id获取文章
            $wh['id']=array('in',$article_id);
            $wh['status']=array('eq',1);

            //分页
            $count=$this->where($wh)->count();//总记录数
            $tou_page=ceil($count/$sumpage);//总页码
            if(($page-1)*$sumpage >$count){
                $page =$tou_page;//最大页码
            }
            if(($page-1)*$sumpage <0){
                $page =1;//最小页码
            }
            $startpag=($page-1)*$sumpage;

            $article =$this->where($wh)->order('create_time','desc')->limit($startpag,$sumpage)->select();
            $data['list']=$this->article_p($article);

            $data['count']=$count;//统计条数

        }else{//查询最热的

            $comment_count=db('set')->where('id',1)->value('comment_count');//最热的条件
            //查询满足条件的评论
            $coumment=db('comment')->field('count(*) as counts,article_id')->group('article_id')->having('counts>'.$comment_count)->select();
            //获取热评的帖子id
            $article_hotid=array_column($coumment,'article_id');//获取数组中的article_id;

            //获取文章关键字的id
            $map2['words'] = array('like', "%" . $title . "%");
            $map2['type'] = array('eq', 1);
            $article_keyid = db('article_details')->where($map2)->group('article_id')->column('article_id');

            $article_id=array_intersect($article_hotid,$article_keyid);//返回两个数组的交集


            $map['status']=array('eq',1);
            $map['id']=array('in',$article_id);

            //分页
            $count=$this->where($map)->count();//总记录数
            $tou_page=ceil($count/$sumpage);//总页码
            if(($page-1)*$sumpage >$count){
                $page =$tou_page;//最大页码
            }
            if(($page-1)*$sumpage <0){
                $page =1;//最小页码
            }
            $startpag=($page-1)*$sumpage;

            $article=$this->where($map)->order('create_time','desc')->limit($startpag,$sumpage)->select();
            $data['list']=$this->article_p($article);
            $data['count']=$count;//统计条数

        }

        return $data;


    }


    //文章拼凑数据
    public function article_p2($article){
        if ($article){
            foreach ($article as $k=>$v){
                $data['article'][$k]=$v->toArray();
                $data['article'][$k]['member_name']=get_model_value('member',$v->member_id,'name');
                $data['article'][$k]['member_icon']=Publics::get_icon(get_model_value('member',$v->member_id,'icon'));
                $data['article'][$k]['title']=$v->details()->where('type',1)->value('words');
                $data['article'][$k]['article_icon']=Publics::get_icon($v->details()->where('type',3)->value('icon'));
                $data['article'][$k]['comment_count']=Db::name('comment')->where('article_id',$v['id'])->count();//评论
                $data['article'][$k]['date']=format_date($v->create_time);

                //查看举报状态
                $wh['type']=array('eq',1);
                $wh['ac_id']=array('eq',$v->id);
                $report=Db::name('report')->where($wh)->count();
                if ($report !=0){
                    $data['article'][$k]['report']=1;//举报状态
                }else{
                    $data['article'][$k]['report']=0;//未举报
                }
                //$data[$k]['details']= $v->details()->select()->toArray();
            }
        }else{
            $data=[];
        }

        return $data;
    }*/

}