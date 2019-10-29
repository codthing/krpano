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

class Works extends \think\Model
{
    protected $table='eacoo_works';
    protected $autoWriteTimestamp = true;

    //获取作品集
    public function get_works($work_id){

        $words=Db::table('eacoo_works')->where('id',$work_id)->find();
        if($words){
            if(is_string($words['icon'])){
                $icon=trim($words['icon'],',');//去除前後兩端逗號
                $icon=explode(',',$icon);//转换为数组
                $words['icon']=Publics::icon_toarray($icon);//图片转换为路径
            }else if (is_numeric($words['icon']) && $words['icon'] !=0){
                $icon=$words['icon'];
                $words['icon']=str_replace("\\",'/',Publics::get_icon($icon));
            }else{
                $icon=125;//默认图像
                $words['icon']=str_replace("\\",'/',Publics::get_icon($icon));
            }
            return $words;
        }else{
           return '';
        }
    }

    //获取作品集的单张图片
    public function get_one($work_id){
        $words=Db::table('eacoo_works')->where('id',$work_id)->find();
        if($words){
            if(is_string($words['icon'])){
                $icon=explode(',',$words['icon']);
                $icon=$icon[0];//第一条数据
            }else if (is_numeric($words['icon']) && $words['icon'] !=0){
                $icon=$words['icon'];
            }else{
                $icon=125;//默认图像
            }
            $words['icon']=str_replace("\\",'/',Publics::get_icon($icon));
            return $words;
        }else{
            return '';
        }

    }

}