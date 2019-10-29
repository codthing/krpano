<?php

namespace app\api\controller;

use app\api\model\Company;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Pdf\Mpdf;
use think\Cache;
use think\cache\driver\Redis;
use think\Controller;
use think\Db;
use think\Loader;
use think\Request;
class ImgTest extends Controller
{

    public function index(){
       // $kr_command = "./krpano/krpanotools64 makepano -config=./krpano/templates/normal.config ./upload_3dpic/2019-10-17/20191017/a38fdd02068ac5de4573566c0d1d8e77.png";
        //$kr_command = "F:\project\mzh\public\krpano/krpanotools64 makepano -config=F:\project\mzh\public\krpano/templates/normal.config F:\project/mzh/public/upload_3dpic/2019-10-17/20191017/a38fdd02068ac5de4573566c0d1d8e77.png";
        $kr_command = "F:\project\mzh\public\krpano/krpanotools64 makepano -config=F:\project\mzh\public\krpano/templates/normal.config ./upload_3dpic/2019-10-17/20191017/a38fdd02068ac5de4573566c0d1d8e77.png";

       // $kr_command='C:\Users\Administrator\Desktop\门展会\Krpano全景图\tbs全景图软件\windows用\krpano\krpanotools64 makepano -config=C:\Users\Administrator\Desktop\门展会\Krpano全景图\tbs全景图软件\windows用\krpano\templates\normal.config C:\Users\Administrator\Desktop\门展会\全景图2\123.png';
        exec($kr_command, $log, $status);
    }
    /***
     * @param string $img_path
     * @return string
     * 将当前传入的图片 渲染成为全景图
     */
    public function test()
    {

        $img_path="./upload_3dpic/2019-10-17/20191017/a38fdd02068ac5de4573566c0d1d8e77.png";

        if(empty($img_path)){
            return $img_path;
        }
        if(!file_exists($img_path)){
            return "图片不存在！";
        }
        //软件注册码
        $r_code ="FXsqTqaGNSZER5dSETEm+VzQEh9sWSa5DZMFsSmMxYV9GcXs8W3R8A/mWXrGNUceXvrihmh28hfRF1ivrW0HMzEychPvNiD8B/4/ZzDaUE9Rh6Ig22aKJGDbja1/kYIqmc/VKfItRE2RTSOIbIroxOtsz626NIpxWksAAifwhpNwuPXqDQpz2sRUMBzoPqZktpkItoSenN2mKd8Klfx7pOuB6CIK3e1CDXgyndqOt2mWybLZcU/wfJVAecfxk15ghiqrzaDsbqrdABDowg==";

        //$pano_path=C("KRPANO_PATH"); //krpano 路径 自己配置
        $pano_path='./krpano/';
        //$pano_tools ="krpanotools";

        //krpano 生成图片的命令
        $dealFlat = ''; // 处理 非球面图
       /* if(PHP_OS == 'WINNT'){
            //$pano_path=$pano_path."Win";
            // $pano_tools ="krpanotools32.exe";
            $pano_tools ="krpanotools64.exe";
        } else {
            // 上传平面图时 直接跳过图片生成 否则会一直等待
            $dealFlat = 'echo -e "0\n" | ';
        }*/

       // $kr_command = $dealFlat . $pano_path . "/".$pano_tools." makepano -config=" . $pano_path . "/templates/normal.config ";


        try{
            //在生成图片之前 先注册一下码，要不生成的全景图会有水印
            //exec( $pano_path . '/'.$pano_tools.' register ' .$r_code);
           // exec( $pano_path . '/krpanotools64 register ' .$r_code);
           // $kr_command =$kr_command.$img_path;
           // $kr_command='./krpano/krpanotools64 makepano -config=./templates/normal.config '.$img_path;
            //执行生成图片命令
           // exec($kr_command, $log, $status);
            // exec('123123', $log, $status);
            //dump($kr_command);


        } catch (\Exception $e){
            exit(json_encode(array('code'=>250,'msg'=>$e->getMessage()),JSON_UNESCAPED_SLASHES));
            // $this->ajaxCallMsg(250,$e->getMessage());
        }
      //  return true;
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
                    //$data['code']=200;
                    // $data['msg']='成功';


                    $md5Code=explode('.',$info->getSaveName())[0];//获取文件名
                    $saveFileName= '.'.$dd['url'];
                    $img_file_name= $info->getSaveName();
                    //判断文件是否存在
                    if(file_exists($saveFileName)){
                        //如果存在 则生成 全景图
                        $this->create_pano_pic($saveFileName);
                        // 如果 此时没有生成图片 需要删除上传图片并报错 平面图可能生成不了图片
                        /*  $dirName = dirname('.'.$dd['url']) . '/pano' . '/' . $md5Code . '.tbs-pano';
                          if ( !file_exists($dirName) ) {
                              unlink($saveFileName); // 删除文件
                              $this->ajaxReturn(array('error_code'=>250,"msg"=>"上传图片不能生成全景图"));
                          }*/

                        //移动全景图到指定的目录 图片在哪里全景图将会生成在那个目录
                        $mvres = $this->mv_to_pano_path($saveFileName,$img_file_name);
                        if ( $mvres === false ) {
                            exit(json_encode(array('error_code'=>250,"msg"=>"移动文件失败"),JSON_UNESCAPED_SLASHES));
                        }
                    }else{

                        //$this->ajaxReturn(array('error_code'=>250,"msg"=>"img not exists!",'img_url'=>$true_img_url));
                        exit(json_encode(array('error_code'=>250,"msg"=>"img not exists!"),JSON_UNESCAPED_SLASHES));
                    }
                    // 移动后的缩略图路径
                    $thumb_url = $dat . '/TreeDPic/' . $md5Code . '/pano/' . $md5Code . '.tbs-pano/3d-pano-thumb.jpg';
                    exit(json_encode(array(
                        'error_code'=>0,
                        'msg'=>"sucess",
                        'img_url'=>$saveFileName,
                        "pano_name"=>$md5Code,
                        'thumb_url'=>$thumb_url),JSON_UNESCAPED_SLASHES));

                    /* $this->ajaxReturn(array(
                             'error_code'=>0,
                             'msg'=>"sucess",
                             'img_url'=>$saveFileName,
                             "pano_name"=>$md5Code,
                             'thumb_url'=>$thumb_url)
                     );*/


                    // exit(Publics::ApiJson($data,'','200','成功'));
                    // exit(json_encode($data,JSON_UNESCAPED_SLASHES));
                }else{
                    // 上传失败获取错误信息
                    $data=array('code'=>201,'msg'=>$file->getError(),'icon'=>'','path'=>'');
                    exit(json_encode($data,JSON_UNESCAPED_SLASHES));
                }
            }
        }
    }

    public function upload_3d_pic()
    {
        $file = $_FILES["imgUpload"];
        $u_name =$file['name'];
        $u_temp_name =$file['tmp_name'];
        $u_size =$file['size'];

        // 生成 一个随机字符串
        $str = null;
        $strPol = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123tbs456789abcdefghijklmnopqrstuvwxyz";
        $max = strlen($strPol)-1;
        for($i=0;$i<$length;$i++){
            $str.=$strPol[rand(0,$max)];//rand($min,$max)生成介于min和max两个数之间的一个随机整数
        }

        //$md5Code 会做为文件夹的名字 跟文件的名字，要保持唯一性
        $md5Code =md5_16bit(hash("sha256",$u_name.time().$rand_char)).$str;
        $datePath =date("Y-m-d",time());

        $root_path ='./upload_3dpic/';
        $url_path ='/upload_3dpic/';    //外部访问url
        $f_up_to_path =$root_path .'/'. $datePath.'/'.$md5Code;
        if(!file_exists($f_up_to_path)){
            mkdir($f_up_to_path, 0777, true);
        }
        $type = strtolower(substr($u_name, strrpos($u_name, '.') + 1));
        $img_file_name =$md5Code."." . $type;

        $saveFileName = $f_up_to_path."." . $type;
        $true_img_url =$url_path . $datePath.'/'.$md5Code."." . $type; //外部访问链接
        if (!move_uploaded_file($u_temp_name, $saveFileName)) {
            $this->ajaxReturn(array("error_code"=>250,"msg"=>"图片上传失败，请稍后重试！","return"=>"move pic fail>>temp_name=".$u_temp_name.">>save file name=".$saveFileName));
        } else {
            @rmdir($f_up_to_path);
        }

        //判断文件是否存在
        if(file_exists($saveFileName)){
            //如果存在 则生成 全景图
            $this->create_pano_pic($saveFileName);
            // 如果 此时没有生成图片 需要删除上传图片并报错 平面图可能生成不了图片
            $dirName = dirname($saveFileName) . '/pano' . '/' . $md5Code . '.tbs-pano';
            if ( !file_exists($dirName) ) {
                unlink($saveFileName); // 删除文件
                $this->ajaxReturn(array('error_code'=>250,"msg"=>"上传图片不能生成全景图"));
            }

            //移动全景图到指定的目录 图片在哪里全景图将会生成在那个目录
            $mvres = $this->mv_to_pano_path($saveFileName,$img_file_name);
            if ( $mvres === false ) {
                $this->ajaxReturn(array('error_code'=>250,"msg"=>"移动文件失败"));
            }
        }else{

            $this->ajaxReturn(array('error_code'=>250,"msg"=>"img not exists!",'img_url'=>$true_img_url));
        }
        // 移动后的缩略图路径
        $thumb_url = $url_path . 'TreeDPic/' . $md5Code . '/pano/' . $md5Code . '.tbs-pano/3d-pano-thumb.jpg';
        $this->ajaxReturn(array(
                'error_code'=>0,
                'msg'=>"sucess",
                'img_url'=>$true_img_url,
                "pano_name"=>$md5Code,
                'thumb_url'=>$thumb_url)
        );
    }

    /***
     * @param string $img_path
     * @return string
     * 将当前传入的图片 渲染成为全景图
     */
    private function create_pano_pic($img_path="./upload_3dpic/2019-10-17/20191017/a38fdd02068ac5de4573566c0d1d8e77.png")
    {



        if(empty($img_path)){
            return $img_path;
        }
        if(!file_exists($img_path)){
            return "图片不存在！";
        }
        //软件注册码
        $r_code ="FXsqTqaGNSZER5dSETEm+VzQEh9sWSa5DZMFsSmMxYV9GcXs8W3R8A/mWXrGNUceXvrihmh28hfRF1ivrW0HMzEychPvNiD8B/4/ZzDaUE9Rh6Ig22aKJGDbja1/kYIqmc/VKfItRE2RTSOIbIroxOtsz626NIpxWksAAifwhpNwuPXqDQpz2sRUMBzoPqZktpkItoSenN2mKd8Klfx7pOuB6CIK3e1CDXgyndqOt2mWybLZcU/wfJVAecfxk15ghiqrzaDsbqrdABDowg==";

        //$pano_path=C("KRPANO_PATH"); //krpano 路径 自己配置
        $pano_path='./krpano/';
        $pano_tools ="krpanotools";

        //krpano 生成图片的命令
        $dealFlat = ''; // 处理 非球面图
        if(PHP_OS == 'WINNT'){
            //$pano_path=$pano_path."Win";
            // $pano_tools ="krpanotools32.exe";
            $pano_tools ="krpanotools64.exe";
        } else {
            // 上传平面图时 直接跳过图片生成 否则会一直等待
            $dealFlat = 'echo -e "0\n" | ';
        }

        $kr_command = $dealFlat . $pano_path . "/".$pano_tools." makepano -config=" . $pano_path . "/templates/normal.config ";

        try{
            //在生成图片之前 先注册一下码，要不生成的全景图会有水印
            exec( $pano_path . '/'.$pano_tools.' register ' .$r_code);
            $kr_command =$kr_command.$img_path;
            //执行生成图片命令
            exec($kr_command, $log, $status);
           // exec('123123', $log, $status);
            dump($kr_command);


        } catch (\Exception $e){
            exit(json_encode(array('code'=>250,'msg'=>$e->getMessage()),JSON_UNESCAPED_SLASHES));
            // $this->ajaxCallMsg(250,$e->getMessage());
        }
        return true;
    }

    /**
     * @param $pano_img_path
     * @return string
     * 全景图生成后再调用这个方法，把全景图移到对应的目录供 xml 文件获取内容
     */
    private function mv_to_pano_path($pano_img_path,$img_name){
        $ig_name =explode(".",$img_name)[0];
        $root_path = './upload_3dpic/';

        if(!file_exists($pano_img_path) ||empty($pano_img_path)){
            // $this->up_error_log($pano_img_path.'》》图片路径文件不存在');
            exit(json_encode(array('code'=>250,'msg'=>$pano_img_path.'》》图片路径文件不存在'),JSON_UNESCAPED_SLASHES));
            //return '';
        }

        $now_path =dirname($pano_img_path);//获取当前文件目录

        if ($dh = @opendir($now_path)){
            //打开目录
            while (($file = readdir($dh)) !== false){
                //循环获取目录的 文件
                if (($file != '.') && ($file != '..')) {
                    //如果文件不是.. 或 . 则就是真实的文件
                    if($file=="pano"){
                        //全景图切片目录
                        $t_d_path =$root_path .'TreeDPic/'. $ig_name;

                        if(!file_exists($t_d_path)){
                            //不存在就创建
                            @mkdir($t_d_path, 0777, true);
                        }
                        if(file_exists($t_d_path.'/'.$file)){
                            //判断是否已经存在 当前名字的  全景图 文件
                            return false;
                        }else{
                            //否则就 把 当前上传的生成 的全景文件切片，移动到指定的目录
                            rename($now_path.'/'.$file,$t_d_path.'/'.$file);
                        }
                    }else if ($file !==$img_name){
                        //删除不是 原图片的文件
                        if(is_dir($file)){
                            $this->deleteDir($now_path.'/'.$file);
                        }else{
                            @unlink($now_path.'/'.$file);
                        }
                    }else{
                        return false;
                    }
                }
            }
            closedir($dh);
        }else{
            return false;
        }

    }
    /**
     * @param $dir
     * @return bool
     * 删除文件夹及文件
     */
    private  function deleteDir($dir)
    {
        if (!$handle = @opendir($dir)) {
            return false;
        }
        while (false !== ($file = readdir($handle))) {
            if ($file !== "." && $file !== "..") {       //排除当前目录与父级目录
                $file = $dir . '/' . $file;
                if (is_dir($file)) {
                    $this->deleteDir($file);
                } else {
                    @unlink($file);
                }
            }
        }
        @rmdir($dir);
    }



}
