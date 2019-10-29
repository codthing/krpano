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
use think\Request;

class Service extends \think\Model
{
    protected $table='eacoo_service';
    protected $autoWriteTimestamp = true;




    public function get_service($service_id){
        $service=Db::name('service')->where('id',$service_id)->find();


        //获取服务区域
        if(!is_numeric($service['taiwan'])){//判断是不是数字
            $addrs=explode(',',$service['taiwan']);
            foreach ($addrs as $k=>$v){
                $addrs1[$k]=get_addrs($v);
            }
        }else{
            $addrs1=get_addrs($service['taiwan']);
        }


        //获取工匠昵称
        $craftsman_title=Db::name('craftsman')->where('id',$service['craftsman_id'])->value('name');
        //获取工匠是否上传专业证书
        $license=Db::name('craftsman')->where('id',$service['craftsman_id'])->value('license');
        if($license !=0){
            $license=1;
        }
        //获取工匠的分类id
        $category_id=Db::name('craftsman')->where('id',$service['craftsman_id'])->value('category_id');


        //统计评论
        $comments=comment($service['id']);
        //统计拨打记录
        $record=record($service['id']);
        //获取工匠分类
        $craftsman_catgory=craftsman_category($category_id);

        //获取图片路径
        if(!is_numeric($service['icon'])){//判断是不是数字
            $img=explode(',',$service['icon']);
            foreach ($img as $k=>$v){
                $img1[$k]=str_replace("\\",'/',Publics::get_icon($v));
            }
        }else{
            $img1[0]=str_replace("\\",'/',Publics::get_icon($service['icon']));
        }

        $data=[
            'title'=>$service['title'],
            'addrs'=>$addrs1,
            'icon'=>$img1,
            'comments'=>$comments,
            'records'=>$record,
            'name'=>$craftsman_title,
            'category'=>$craftsman_catgory,
            'license'=>$license,
            'service_id'=>$service_id,
            'craftsman_id'=>$service['craftsman_id'],
            'xing'=>$service['xing'],
            'status'=>$service['status'],//状态：1正常 2工匠过期 0隐藏
        ];

        return $data;
    }

    //获取服务信息
    public function get_servicear($service){

        if (empty($service)){
            return [];
        }

        //获取服务区域
        if(!is_numeric($service['taiwan'])){//判断是不是数字
            $addrs=explode(',',$service['taiwan']);
            foreach ($addrs as $k=>$v){
                $addrs1[$k]=get_addrs($v);
            }
        }else{
            $addrs1=get_addrs($service['taiwan']);
        }


        //获取工匠昵称
        $craftsman_title=Db::name('craftsman')->where('id',$service['craftsman_id'])->value('name');
        //获取工匠是否上传专业证书
        $license=Db::name('craftsman')->where('id',$service['craftsman_id'])->value('license');
        if($license !=0){
            $license=1;
        }
        //获取工匠的分类id
        $category_id=Db::name('craftsman')->where('id',$service['craftsman_id'])->value('category_id');


        //统计评论
        $comments=comment($service['id']);
        //统计拨打记录
        $record=record($service['id']);
        //获取工匠分类
        $craftsman_catgory=craftsman_category($category_id);

        //获取图片路径
        if(!is_numeric($service['icon'])){//判断是不是数字
            $img=explode(',',$service['icon']);
            foreach ($img as $k=>$v){
                $img1[$k]=str_replace("\\",'/',Publics::get_icon($v));
            }
        }else{
            $img1[0]=str_replace("\\",'/',Publics::get_icon($service['icon']));
        }

        $data=[
            'title'=>$service['title'],
            'addrs'=>$addrs1,
            'icon'=>$img1,
            'comments'=>$comments,
            'records'=>$record,
            'name'=>$craftsman_title,
            'category'=>$craftsman_catgory,
            'license'=>$license,
            'service_id'=>$service['id'],
            'craftsman_id'=>$service['craftsman_id'],
            'xing'=>$service['xing'],
            'status'=>$service['status'],//状态：1正常 2工匠过期 0隐藏
        ];

        return $data;
    }


    //获取服务详情里面的服务
    public function service_details($craftsman_id){
        $services=Db::name('service')->where('craftsman_id',$craftsman_id)->field('icon,title,id')->limit(3)->select();
        if(empty($services)){
            return ;
        }
        //查询图片
        foreach ($services as $k=>$v){
            if(is_string($v['icon'])){
                $icon=explode(',',$v['icon']);
                $icon=$icon[0];//第一条数据
            }else if (is_numeric($v['icon']) && $v['icon'] !=0){
                $icon=$v['icon'];
            }else{
                $icon=125;//默认图像
            }
            $services[$k]['icon']=str_replace("\\",'/',Publics::get_icon($icon));
            $services[$k]['comment']=comment($v['id']);//统计评论
        }
        return $services;
    }

}