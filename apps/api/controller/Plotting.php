<?php

namespace app\api\controller;


use app\admin\logic\Config;
use app\api\model\Member;
use app\api\model\Search;
use FontLib\Table\Type\name;
use PhpOffice\PhpSpreadsheet\Reader\Xls\MD5;
use think\Cache;
use think\Controller;
use think\Db;
use think\Loader;
use think\Request;
use think\Validate;

class Plotting extends Base
{


    /**
     * @param Request $request
     * 修改展绘密码
     */
    public function edit_password(Request $request)
    {
        if ($request->isPost()){
            $data=$this->post;
            if (!isset($data['type']) ||empty($data['type'])){
                exit(Publics::ApiJson('', $this->token, 201, '缺少参数type'));
            }
            if (!isset($data['password']) || empty($data['password'])){
                exit(Publics::ApiJson('', $this->token, 201, '缺少参数password'));
            }
            if ($data['type']==1){//修改所有
                $res=db('plotting')->where('member_id',$this->uid)->update(['password'=>$data['password']]);
            }else{//修改单个
                if (!isset($data['plotting_id']) || empty($data['plotting_id'])){
                    exit(Publics::ApiJson('', $this->token, 201, '缺少参数plotting_id'));
                }
                $res=db('plotting')->where('id',$data['plotting_id'])->update(['password'=>$data['password']]);
            }
            if (false !=$res){
                exit(Publics::ApiJson('', $this->token, 200, '修改成功'));
            }else{
                exit(Publics::ApiJson('', $this->token, 201, '修改失败'));
            }
        }
    }


    //展绘详情
    public function details(Request $request){
        if ($request->isPost()){
            $data=$this->post;
            if (!isset($data['plotting_id']) ||empty($data['plotting_id'])){
                exit(Publics::ApiJson('', $this->token, 201, '缺少参数plotting_id'));
            }
            //查询详情
            $plotting=model('plotting')->where('id',$data['plotting_id'])->find();
            if ($plotting){
                if (isset($data['details_id']) || !empty($data['details_id'])){
                    $map['status']=array('eq',1);
                    $map['id']=array('eq',$data['details_id']);
                }else{
                    $map['status']=array('eq',1);
                }

                //查询子集
                $one=$plotting->details()->where($map)->find();
                if (!$one){
                    exit(Publics::ApiJson('', $this->token, 201, '后台未生成展绘全景'));
                }

                $list=$plotting->toArray();
                $list['details']=$one->toArray();
                $list['details']['mp3_path']=Publics::get_icon($one->file_icon);
                $list['details']['details_id']=$one->id;

                exit(Publics::ApiJson($list, $this->token, 200, '获取数据成功'));
            }else{
                exit(Publics::ApiJson('', $this->token, 201, '参数id有误，未获取到内容'));
            }
        }
    }

    //展绘规格
    public function plotting_st(Request $request){
        if ($request->isPost()){
            $list=db("category")->where('status',1)->field('id,title,icon,type')->select();
            if ($list){
                foreach ($list as $k=>$v){
                    $list[$k]['icon_path']=Publics::get_icon($v['icon']);
                }
                exit(Publics::ApiJson($list, $this->token, 200, '获取数据成功'));
            }else{
                exit(Publics::ApiJson('', $this->token, 201, '未获取到数据'));
            }
        }
    }

    //展绘子规格详情
    public function style(Request $request){
        if ($request->isPost()){
            $data=$this->post;
            if (!isset($data['type']) ||empty($data['type'])){
                exit(Publics::ApiJson('', $this->token, 201, '缺少参数type'));
            }
            if (!isset($data['plotting_id']) ||empty($data['plotting_id'])){
                exit(Publics::ApiJson('', $this->token, 201, '缺少参数id'));
            }
            //查询分类全景
            $plotting=db('plotting_details')->where('category_id',$data['type'])->where('plotting_id',$data['plotting_id'])->where('status',1)->select();


            if ($plotting){
                foreach ($plotting as $k=>$v){
                    $plotting[$k]['icon_path']=Publics::get_icon($v['icon']);
                    $plotting[$k]['details_id']=$v['id'];
                }
                exit(Publics::ApiJson($plotting, $this->token, 200, '获取数据成功'));
            }else{
                exit(Publics::ApiJson('', $this->token, 201, '未获取到内容'));
            }
        }
    }

    //获取展绘分享人信息
    public function share_info(Request $request){
        if ($request->isPost()){
            $data=$this->post;
            if (!isset($data['plotting_id']) ||empty($data['plotting_id'])){
                exit(Publics::ApiJson('', $this->token, 201, '缺少参数plotting_id'));
            }
            if (!isset($data['page']) ||empty($data['page'])){
                $page=1;//默认为1页
            }else{
                $page=$data['page'];
            }
            if (!isset($data['sumpage']) || empty($data['sumpage'])){
                $sumpage=20;//默认每页显示20条数据
            }else{
                $sumpage =$data['sumpage'];
            }
            //分页
            $count=db('share')->where('plotting_id',$data['plotting_id'])->count();//总记录数
            // $sumpage=$this->post['sumpage'] ?$this->post['sumpage'] :5;//每页显示记录数
            $tou_page=ceil($count/$sumpage);//总页码
            if(($page-1)*$sumpage >$count){
                $page =$tou_page;//最大页码
            }
            if(($page-1)*$sumpage <0){
                $page =1;//最小页码
            }
            $startpag=($page-1)*$sumpage;

            //查询展绘
            $list = db('share')->where('plotting_id',$data['plotting_id'])->limit($startpag,$sumpage)->order('create_time','desc')->select();

            if ($list){
                foreach ($list as $kk=>$vv){
                    $list[$kk]['create_time']=date('Y-m-d H:i:s',$vv['create_time']);
                    $list[$kk]['update_time']=date('Y-m-d H:i:s',$vv['update_time']);
                }
            }

            $plotting_icon=db('plotting')->where('id',$data['plotting_id'])->value('icon');
            $da['plotting_path']=Publics::get_icon($plotting_icon);
            $da['page']=$page;
            $da['sumpage']=$sumpage;
            $da['list']=$list;
            $da['count']=$count;
           // $list=db('share')->where('plotting_id',$data['plotting_id'])->select();
            if ($list){
                exit(Publics::ApiJson($da, $this->token, 200, '获取数据成功'));
            }else{
                exit(Publics::ApiJson($da, $this->token, 201, '未获取到数据'));
            }
        }
    }






    public function test(Request $request){
/*
        $data=['code'=>200,'data'=>[
           ['title'=>'小王',"age"=>18],
           ['title'=>'小名',"age"=>19],
           ['title'=>'小花',"age"=>20],
        ]];

        echo json_encode($data);*/
        //echo date('m');
       // phpinfo();
        $strs="QWERTYUIOPASDFGHJKLZXCVBNM1234567890qwertyuiopasdfghjklzxcvbnm";
        $name=substr(str_shuffle($strs),mt_rand(0,strlen($strs)-11),10);
        echo $name;

    }




}
