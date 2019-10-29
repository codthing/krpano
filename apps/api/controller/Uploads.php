<?php

namespace app\api\controller;


use think\Controller;
use think\Db;
use think\Model;
use think\Request;

class Uploads extends Controller
{
    public $post;
    public function __construct(Request $request = null)
    {
        header("Access-Control-Allow-Origin: *");//允许跨域
        $list = file_get_contents('php://input');
        $this->post = json_decode($list, true);
        parent::__construct($request);


    }

    /**
     * @param Request $request
     * 图片上传接口
     */
    public function upload(Request $request){
       if($request->isPost()){
           // 获取表单上传文件 例如上传了001.jpg
          // $file = $this->post;
            $file=$request->file('file');

           // 移动到框架应用根目录/public/uploads/ 目录下
           if($file){
               //保存文件名称及路径
               $path="./static/uploads/".date('Y-m-d',time());
               $dat="/static/uploads/".date('Y-m-d',time());
               $dir = iconv("UTF-8", "GBK",$path);
               if (!file_exists($dir)){
                   mkdir ($dir,0777,true);//创建文件夹
               }
               $info = $file->move($path);
               if($info){
                   //上传成功获取缩略图
                   $image = \think\Image::open('./'.$dat.DS.$info->getSaveName());
                   // 按照原图的比例生成一个最大为300*300的缩略图
                   $min=$dat.DS.'min'.$info->getFilename();
                   $image->thumb(200, 200,\think\Image::THUMB_CENTER)->save('./'.$min);
                   // 成功上传后 获取上传信息
                   $dd=[
                       'path'=>$min,
                       'name'=>'toux',
                       'url'=>$dat.DS.$info->getSaveName(),
                       'path_type'=>'picture',
                       'create_time'=>strtotime('Y-m-d H:i:s',time()),
                   ];
                   //新建图片
                   $data['icon']=Db::table('eacoo_attachment')->insertGetId($dd);
                   $data['path']=str_replace('\\','/',Db::table('eacoo_attachment')->where('id',$data['icon'])->value('path'));//替换反斜线
                   $data['code']=200;
                   $data['msg']='成功';
                  // exit(Publics::ApiJson($data,'','200','成功'));
                    exit(json_encode($data,JSON_UNESCAPED_SLASHES));
               }else{
                   // 上传失败获取错误信息
                   $data=array('code'=>201,'msg'=>$file->getError(),'icon'=>'','path'=>'');
                   exit(json_encode($data,JSON_UNESCAPED_SLASHES));
               }
           }
       }
    }

    //3d图片上传接口
    public function upload3d(Request $request){
        if($request->isPost()){
            // 获取表单上传文件 例如上传了001.jpg
            // $file = $this->post;
            $file=$request->file('file');

            // 移动到框架应用根目录/public/uploads/ 目录下
            if($file){
                //保存文件名称及路径
                $path="./upload_3dpic/".date('Y-m-d',time());
                $dat="/upload_3dpic/".date('Y-m-d',time());
                $dir = iconv("UTF-8", "GBK",$path);
                if (!file_exists($dir)){
                    mkdir ($dir,0777,true);//创建文件夹
                }
                $info = $file->move($path);
                if($info){
                    //上传成功获取缩略图
                    $image = \think\Image::open('./'.$dat.DS.$info->getSaveName());
                    // 按照原图的比例生成一个最大为300*300的缩略图
                    $min=$dat.DS.'min'.$info->getFilename();
                    $image->thumb(200, 200,\think\Image::THUMB_CENTER)->save('./'.$min);
                    // 成功上传后 获取上传信息
                    $dd=[
                        'path'=>$min,
                        'name'=>'toux',
                        'url'=>$dat.DS.$info->getSaveName(),
                        'path_type'=>'picture',
                        'create_time'=>strtotime('Y-m-d H:i:s',time()),
                    ];
                    //新建图片
                    $data['icon']=Db::table('eacoo_attachment')->insertGetId($dd);
                    $data['path']=str_replace('\\','/',Db::table('eacoo_attachment')->where('id',$data['icon'])->value('path'));//替换反斜线
                    $data['code']=200;
                    $data['msg']='成功';
                    // exit(Publics::ApiJson($data,'','200','成功'));
                    exit(json_encode($data,JSON_UNESCAPED_SLASHES));
                }else{
                    // 上传失败获取错误信息
                    $data=array('code'=>201,'msg'=>$file->getError(),'icon'=>'','path'=>'');
                    exit(json_encode($data,JSON_UNESCAPED_SLASHES));
                }
            }
        }
    }


    /**
     * @param Request $request
     * 获取图片接口
     */
    public function get_portrait(Request $request){
        if ($request->isPost()){
           // $icon=input('icon') ?? 125;//TODO :: 头像默认路径要换
            $icon=$this->post['icon'] ?? 125;//TODO :: 头像默认路径要换
            $data['path']=str_replace("\\",'/',Publics::get_icon($icon));
            exit( Publics::ApiJson($data,'','200','图片获取成功'));
        }
    }

}
