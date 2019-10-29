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

class Article extends \think\Model
{
    protected $table='eacoo_article';
    protected $autoWriteTimestamp = true;


    //新增文章
    public function add($member_id,$data){
        //先新增一条数据
        $result=$this->allowField(true)->save(['member_id'=>$member_id,'ip'=>get_ip(),'title'=>$data['title'],'content'=>$data['content'],'icon'=>$data['icon']]);
        if ($result){
            $article_id=$this->id;//取出id
            return ['code'=>200,'article_id'=>$article_id,'msg'=>'添加成功'];
        }else{
            return ['code'=>201,'msg'=>'添加失败'];
        }
    }
    //新增文章以前的
    /*public function add2($member_id,$data){
        //先新增一条数据
        $result=$this->allowField(true)->save(['member_id'=>$member_id,'ip'=>get_ip()]);
        if ($result){
            $article_id=$this->id;//取出id
            $article=self::find($article_id);
            if (is_array($data)){
                foreach ($data as $k=>$v){
                   switch ($v['type']){
                       case 1://文章标题
                           if (empty($v['words'])){
                               return ['code'=>201,'msg'=>'words不能为空'];
                           }
                           break;
                       case 2://正文内容
                           if (empty($v['words'])){
                               return ['code'=>201,'msg'=>'words不能为空'];
                           }
                           break;
                       case 3://正文图片
                           if (empty($v['icon'])){
                               return ['code'=>201,'msg'=>'icon不能为空'];
                           }
                           break;
                       case 4://符号
                           break;
                       case 5://链接
                           if (empty($v['link'])){
                               return ['code'=>201,'msg'=>'link不能为空'];
                           }
                           if (empty($v['link_title'])){
                               return ['code'=>201,'msg'=>'link_title不能为空'];
                           }
                           break;
                   }
                }
                $ids=$article->allowField(true)->details()->saveAll($data);//批量更新
            }else{
                $ids=$article->allowField(true)->details()->save($data);
            }

            if ($ids){
                return ['code'=>200,'article_id'=>$article_id,'msg'=>'添加成功'];
            }else{
                return ['code'=>201,'msg'=>'添加失败'];
            }
        }else{
            return ['code'=>201,'msg'=>'添加失败'];
        }
    }*/



    //编辑帖子
    /*public function edit2($article_id,$member_id,$data){
        $map['id']=array('eq',$article_id);
        $map['member_id']=array('eq',$member_id);
        $article=$this->where($map)->find();
        //$article=self::find($article_id);
        if ($article){
            //1.先删除该文章的所有类容
            db('article_details')->where('article_id',$article_id)->delete();
            //2.再添加文章类容
            if (is_array($data)){
                foreach ($data as $k=>$v){
                    switch ($v['type']){
                        case 1://文章标题
                            if (empty($v['words'])){
                                return ['code'=>201,'msg'=>'words不能为空'];
                            }
                            break;
                        case 2://正文内容
                            if (empty($v['words'])){
                                return ['code'=>201,'msg'=>'words不能为空'];
                            }
                            break;
                        case 3://正文图片
                            if (empty($v['icon'])){
                                return ['code'=>201,'msg'=>'icon不能为空'];
                            }
                            break;
                        case 4://符号
                            break;
                        case 5://链接
                            if (empty($v['link'])){
                                return ['code'=>201,'msg'=>'link不能为空'];
                            }
                            if (empty($v['link_title'])){
                                return ['code'=>201,'msg'=>'link_title不能为空'];
                            }
                            break;
                    }
                }
                $ids=$article->allowField(true)->details()->saveAll($data);//批量更新
            }else{
                $ids=$article->allowField(true)->details()->save($data);
            }

            if ($ids){
                return ['code'=>200,'article_id'=>$article_id,'msg'=>'编辑成功'];
            }else{
                return ['code'=>201,'msg'=>'编辑失败'];
            }
        }else{
            return ['code'=>201,'msg'=>'未查询到帖子'];
        }


    }*/


    //获取帖子
    public function get_article($type=1,$value=[]){
        //TODO :: 筛选，最新 最热 关注
        $data=[];
        if ($type ==1){//通过id获取帖子
            if (!isset($value['id']) ||empty($value['id'])){
                return '';
            }
            $article=$this->where('id',$value['id'])->find();
            if ($article){
                $data=$article->toArray();
                $data['member_name']=get_model_value('member',$article->member_id,'name');
                $data['member_icon']=Publics::get_icon(get_model_value('member',$article->member_id,'icon'));//会员头像
                $data['date']=format_date($article->create_time);//时间记录
                $data['comment_count']=Db::name('comment')->where('article_id',$article->id)->count();//评论
                $data['article_fabulous']=Db::name('fabulous')->where('type',1)->where('pid',$article->id)->where('status',1)->count();//赞
                $data['article_fabuon']=Db::name('fabulous')->where('type',1)->where('pid',$article->id)->where('status',2)->count();//踩
                $data['article_collection']=Db::name('fabulous')->where('type',3)->where('pid',$article->id)->where('status',3)->count();//收藏

            }
            //$data['details']=$article->details()->select()->toArray();
        }else{//获取所有帖子


            switch ($value['type']){
                case 1://最新
                    $article=$this->where('status',1)->order('create_time','desc')->select();
                    break;
                case 2://最热
                    $comment_count=db('set')->where('id',1)->value('comment_count');

                    //查询满足条件的评论
                    $coumment=db('comment')->field('count(*) as counts,article_id')->group('article_id')->having('counts>'.$comment_count)->select();

                    //获取评论的帖子id
                    $article_id=array_column($coumment,'article_id');//获取数组中的article_id;
                    $map['status']=array('eq',1);
                    $map['id']=array('in',$article_id);
                    $article=$this->where($map)->order('create_time','desc')->select();
                    break;
                case 3://关注
                    if (!isset($data['token']) || empty($data['token'])){
                        $article=[];
                    }else{
                        //查询会员关注的
                        $member_id=db('member')->where('token',$data['token'])->value('id');
                        if ($member_id){
                            $follow_member=db('follow')->where('member_id',$member_id)->column('pid');
                            $map['status']=array('eq',1);
                            $map['member_id']=array('in',$follow_member);
                            $article=$this->where($map)->order('create_time','desc')->select();
                        }else{
                            $article=[];
                        }
                    }
                    break;
            }
           if ($article){
               foreach ($article as $k=>$v){
                   $data['article'][$k]=$v->toArray();
                   $data['article'][$k]['member_name']=get_model_value('member',$v->member_id,'name');
                   $data['article'][$k]['member_icon']=Publics::get_icon(get_model_value('member',$v->member_id,'icon'));

                    $data['article'][$k]['comment_count']=Db::name('comment')->where('article_id',$v['id'])->count();//评论
                   $data['article'][$k]['date']=format_date($v->create_time);

                   //查看举报状态
                   $wh['type']=array('eq',1);
                   $wh['ac_id']=array('eq',$v->id);
                   $wh['status']=array('eq',1);//未处理
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

        }

        return $data;
    }

    //获取帖子
   /* public function get_article($type=1,$value=[]){
        //TODO :: 筛选，最新 最热 关注
        $data=[];
        if ($type ==1){//通过id获取帖子
            if (!isset($value['id']) ||empty($value['id'])){
                return '';
            }
            $article=$this->where('id',$value['id'])->find();
            if ($article){
                $data=$article->toArray();
                $data['member_name']=get_model_value('member',$article->member_id,'name');
                $data['member_icon']=Publics::get_icon(get_model_value('member',$article->member_id,'icon'));//会员头像
                $data['date']=format_date($article->create_time);//时间记录
                $data['details']=$article->details()->select()->toArray();//详情
                $data['comment_count']=Db::name('comment')->where('article_id',$article->id)->count();//评论
                $data['article_fabulous']=Db::name('fabulous')->where('type',1)->where('pid',$article->id)->where('status',1)->count();//赞
                $data['article_fabuon']=Db::name('fabulous')->where('type',1)->where('pid',$article->id)->where('status',2)->count();//踩
                $data['article_collection']=Db::name('fabulous')->where('type',3)->where('pid',$article->id)->where('status',3)->count();//收藏

                if (is_array($data['details']) && !empty($data['details'])){
                    foreach ($data['details'] as $k=>$v){
                        if ($v['icon'] !=0){
                            $data['details'][$k]['icon_path']=Publics::get_icon($v['icon']);
                        }
                    }
                }
            }
            //$data['details']=$article->details()->select()->toArray();
        }else{//获取所有帖子


            switch ($value['type']){
                case 1://最新
                    $article=$this->where('status',1)->order('create_time','desc')->select();
                    break;
                case 2://最热
                    $comment_count=db('set')->where('id',1)->value('comment_count');

                    //查询满足条件的评论
                    $coumment=db('comment')->field('count(*) as counts,article_id')->group('article_id')->having('counts>'.$comment_count)->select();

                    //获取评论的帖子id
                    $article_id=array_column($coumment,'article_id');//获取数组中的article_id;
                    $map['status']=array('eq',1);
                    $map['id']=array('in',$article_id);
                    $article=$this->where($map)->order('create_time','desc')->select();
                    break;
                case 3://关注
                    if (!isset($data['token']) || empty($data['token'])){
                        $article=[];
                    }else{
                        //查询会员关注的
                        $member_id=db('member')->where('token',$data['token'])->value('id');
                        if ($member_id){
                            $follow_member=db('follow')->where('member_id',$member_id)->column('pid');
                            $map['status']=array('eq',1);
                            $map['member_id']=array('in',$follow_member);
                            $article=$this->where($map)->order('create_time','desc')->select();
                        }else{
                            $article=[];
                        }
                    }
                    break;
            }
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
                    $wh['status']=array('eq',1);//未处理
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

        }

        return $data;
    }*/

    //拼凑数据
    public function piece_article($article){
        if ($article){
            foreach ($article as $k=>$v){
                $data['article'][$k]=$v->toArray();
                $data['article'][$k]['member_name']=get_model_value('member',$v->member_id,'name');
                $data['article'][$k]['member_icon']=Publics::get_icon(get_model_value('member',$v->member_id,'icon'));
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
    }
   /* //拼凑数据
    public function piece_article($article){
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

    //定义模型一对多关系
    public function details(){
        return $this->hasMany('ArticleDetails','article_id','id');
    }
}