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

class Index extends Base
{

    /**
     * @param Request $request
     * 首页接口
     */
    public function index(Request $request)
    {
        if ($request->isPost()) {
            $data=$this->post;

            if (!isset($data['type']) ||empty($data['type'])){
                exit(Publics::ApiJson('', $this->token, 201, '缺少参数type'));
            }
            if ($data['type'] ==2){//查询某商家的展绘
                $map['member_id']=array('eq',$this->uid);
            }

            if (isset($data['key']) || !empty($data['key'])){
                $map['title|describe']=array('like','%'.$data['key'].'%');
                $map['status']=array('eq',1);
            }else{
                $map['status']=array('eq',1);
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
            $count=db('plotting')->where($map)->count();//总记录数
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
            $plotting = db('plotting')->where($map)->limit($startpag,$sumpage)->order('create_time','desc')->select();

            if ($plotting){
                foreach ($plotting as $k=>$v){
                    $plotting[$k]['icon_path']=Publics::get_icon($v['icon']);
                }
                $da['page']=$page;
                $da['sumpage']=$sumpage;
                $da['list']=$plotting;

                exit(Publics::ApiJson($da, $this->token, 200, '获取数据成功'));
            }else{
                exit(Publics::ApiJson('', $this->token, 201, '未获取到数据'));
            }
        }
    }
    //首页广告
    public function index_ad(Request $request){
        if ($request->isPost()){
            $ad=db('ad')->where('status',1)->select();
            if ($ad){
                foreach ($ad as $k=>$v){
                    $ad[$k]['icon_path']=Publics::get_icon($v['icon']);
                }
                exit(Publics::ApiJson($ad, $this->token, 200, '获取数据成功'));
            }else{
                exit(Publics::ApiJson('', $this->token, 201, '未获取到数据'));
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
