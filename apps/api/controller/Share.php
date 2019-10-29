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

class Share extends Controller
{
    public $post;

    public function __construct(Request $request = null)
    {
        error_reporting(E_ERROR | E_PARSE );//关闭tp5严格模式
        header("Access-Control-Allow-Origin: *");//允许跨域
        $list = file_get_contents('php://input');
        $this->post = json_decode($list, true);
        parent::__construct($request);
    }

    //门展绘全景
    public function index(Request $request){
        //接收id
        $plotting_id=input('plotting_id');
        $details_id=input('details_id');

       /* if (!isset($details_id) ||empty($details_id)){
            exit(Publics::ApiJson('', '', 201, '缺少参数details_id'));
        }*/
        if (!isset($plotting_id) ||empty($plotting_id)){
            $plotting_id=db('plotting_details')->where('id',$details_id)->value('plotting_id');
        }


        //查询详情
        $plotting=model('plotting')->where('id',$plotting_id)->find();
        if ($plotting){
            if (isset($details_id) || !empty($details_id)){
                $map['status']=array('eq',1);
                $map['id']=array('eq',$details_id);
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
            if ($list['details']){
                $list['details']['xml_path']=str_replace("\\",'/',$list['details']['xml_path']);
                $dir=dirname($list['details']['xml_path']);//返回目录
                $js=$dir.'/tour.js';
            }
            $list['details']['mp3_path']=Publics::get_icon($one->file_icon);
            $list['details']['details_id']=$one->id;
            if ($list['details']['watermark_icon']){
                $path= Db::table('eacoo_attachment')->where('id', $list['details']['watermark_icon'])->value('url');//默认图片
                $path= str_replace("\\",'/',$path);
                $list['details']['watermark_path']=$path;
            }else{
                $list['details']['watermark_path']='';
            }


            //查询分类
            $category=db('category')->where('status',1)->field('id,icon,title')->select();
            if ($category){
                foreach ($category as $k=>$v){
                    $category[$k]['icon_path']=Publics::get_icon($v['icon']);
                }
            }


            $this->view->assign('category',$category);//分类
           $this->view->assign('list',$list);//展绘
           $this->view->assign('details', $list['details']);//展绘全景
           $this->view->assign('xml_path', $list['details']['xml_path']);//全景xml
           $this->view->assign('js', $js);//全景js
           return $this->view->fetch();
        }else{
            exit(Publics::ApiJson('', '', 201, '参数id有误，未获取到内容'));
        }



    }

    //统计分享数量
    public function share(Request $request){
       if($request->isPost()){
           $data=$this->post;
           $validate = Loader::validate('Share');

           if(!$validate->check($data)){
                exit(Publics::ApiJson('', '', 201, $validate->getError()));
           }
           $map['plotting_id']=array('eq',$data['plotting_id']);
           $map['name']=array('eq',$data['name']);
           $shar=db('share')->where($map)->find();
           if ($shar){//存在就不更新数量
               exit(Publics::ApiJson('', '', 200, '记录成功'));
           }


           $data['create_time']=time();
           $data['update_time']=time();
           $res=db('share')->insertGetId($data);
            if ($res){
                //查询展绘,更新分享数量
                db('plotting')->where('id',$data['plotting_id'])->setInc('share',1);
                exit(Publics::ApiJson('', '', 200, '记录成功'));
            }else{
                exit(Publics::ApiJson('', '', 200, '记录失败'));
            }
       }


    }

    //查询分类数据
    public function plotting(Request $request){
        if ($request->isPost()){
            $category_id=input('category_id');
            $plotting_id=input('plotting_id');
            //查询全景详情
            $map['category_id']=array('eq',$category_id);
            $map['plotting_id']=array('eq',$plotting_id);
            $map['status']=array('eq',1);
            $details=db('plotting_details')->where($map)->select();
            if ($details){
                foreach ($details as $k=>$v){
                    $details[$k]['icon_path']=Publics::get_icon($v['icon']);
                }
                return array('code'=>200,'msg'=>'成功','data'=>$details);
            }else{
                return array('code'=>201,'msg'=>'未获取到数据','data'=>'');
            }
        }
    }

    //查询标注热点
    public function standard(Request $request){
        if ($request->isPost()){
            $id=input('id');
            $pdtails=db('plotting_details')->where('id',$id)->find();
            if ($pdtails){
                //查询箭头或者标注
                $map['details_id']=array('eq',$id);
                $map['plotting_id']=array('eq',$pdtails['plotting_id']);
                $map['status']=array('eq',1);
                $standard=db('standard')->where($map)->select();
                if ($standard){
                    foreach ($standard as $k=>$v){
                        if ($v['type'] ==3){//图片
                            if (is_numeric($v['content'])){
                                $standard[$k]['icon_path']=Publics::get_icon($v['content']);
                            }else{
                                $standard[$k]['icon_path']='/static/assets/img/noimage.gif';
                            }
                        }

                    }
                    return array('code'=>200,'msg'=>'获取数据成功','data'=>$standard);
                }else{
                    return array('code'=>201,'msg'=>'未获取到数据');
                }

            }else{
                return array('code'=>201,'msg'=>'未获取到数据');
            }
        }
    }

    //查询密码
    public function check_password(Request $request){
        if ($request->isPost()){
            $data=$this->post;
            if (!isset($data['password']) ||empty($data['password'])){
                exit(Publics::ApiJson('', '', 201, '请输入密码'));
            }
            if (!isset($data['plotting_id']) ||empty($data['plotting_id'])){
                exit(Publics::ApiJson('', '', 201, '缺少参数plotting_id'));
            }
            //查询展绘
            $plotting=db('plotting')->where('id',$data['plotting_id'])->find();
            if ($plotting){
                if ($data['password'] !=$plotting['password']){
                    exit(Publics::ApiJson('', '', 201, '密码错误'));
                }else{
                    exit(Publics::ApiJson('', '', 200, '密码正确'));
                }
            }else{
                exit(Publics::ApiJson('', '', 201, '未查询到展绘'));
            }
        }
    }

    //获取客户电话
    public function get_customer(Request $request){
        if ($request->isPost()){
            $tel=db('set')->where('id',1)->value('customer_tel');
            exit(Publics::ApiJson(array('customer_tel'=>$tel), '', 200, '获取成功'));
        }
    }

}
