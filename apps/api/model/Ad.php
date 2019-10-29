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

class Ad extends \think\Model
{
    protected $table='eacoo_ad';
    protected $autoWriteTimestamp = true;

    //通过会员id查询拨打记录数
    public function get_ad($member_id=0){
        if (empty($member_id)){
            return 0;
        }
        $map['status']=array('eq',1);
        $map['member_id']=array('eq',$member_id);
        $browse=Db::name('browse')->where($map)->count();
        //查看记录状态
        $status=Db::name('browse')->where($map)->column('sta');
        if(in_array(1,$status)){
            $status=1;
        }else{
            $status=0;
        }
        $data=['browse'=>$browse,'status'=>$status];
        return $data;
    }

    /**
     * @param $datas
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * 广告生成订单
     */
    public function set_order($datas){
        $token=$datas['token'];
        $id=$datas['id'];
        if(empty($token)){
            exit(Publics::ApiJson('', '', '201', '缺少token'));
        }
        $member = Db::table('eacoo_member')->where('token', $token)->find();
        if (!$member) {
            exit(Publics::ApiJson('', $token, '201', 'token验证失败')) ;
        }
        if($member['craftsman_id'] ==0){
            exit(Publics::ApiJson('', $token, '201', '该会员不是工匠')) ;
        }


        if(empty($id)){
            exit(Publics::ApiJson('', $token, '201', '缺少参数id'));
        }

        //防止其他用户购买此广告，采用文件锁来控制并发

        $file = fopen(__DIR__.'/adorder.txt','w+');
        //加锁
        if(flock($file,LOCK_EX|LOCK_NB)){

            //查询工匠最新服务
            $map['status']=array('eq',1);
            $map['craftsman_id']=array('eq',$member['craftsman_id']);
            $service=Db::name('service')->where($map)->order('create_time','desc')->find();
            if(empty($service)){
                flock($file,LOCK_UN);//解锁
                //关闭文件
                fclose($file);
                exit(Publics::ApiJson('', $token, '201', '该工匠没有服务或已过期'));
            }

            $time =time();//当前时间戳
            //查询广告
            $wh['status']=array('eq',1);
            $wh['id']=array('eq',$id);
            $ad=model('Ad')->where($wh)->find();
            if($ad){
                //查询广告订单
                if(count($ad->orders) !=0){
                    foreach ($ad->orders as $kk=>$vv){
                        if($vv['end_time'] >$time){
                            flock($file,LOCK_UN);//解锁
                            //关闭文件
                            fclose($file);
                            exit(Publics::ApiJson('', '', '201', '该广告正在使用'));
                        }

                    }
                }

                //购买广告
                $data['ad_id']=$ad->id;
                $data['position_id']=$ad->position_id;
                $data['size']=$ad->size;
                $data['start_time']=$time;//广告开始时间
                $data['end_time']=strtotime('+'.$ad->time.' month');//广告结束时间
                $data['craftsman_id']=$member['craftsman_id'];
                $data['member_id']=$member['id'];
                $data['code']=Publics::order_code();
                $data['price']=$ad->price;

                //写入订单
                $order=model('AdOrder')->allowField(true)->save($data);
                if (false !=$order){
                    //TODO ::订单支付

                    //更改广告信息
                    $ads=model('Ad
                    ')->save(array('craftsman_id'=>$member['craftsman_id'],'service_id'=>$service['id'],'status'=>0,['id'=>$id]));//status为0不可购买
                    $res=['order_id'=>$order->id,'type'=>2,'code'=>$data['code']];//type 2购买广告

                    $model=new Craftsman();
                    $json = $model->pay_class($datas);
                    $str=json_decode($json,true);
                    $res['str']=$str;//支付信息


                    flock($file,LOCK_UN);//解锁
                    //关闭文件
                    fclose($file);
                    exit(Publics::ApiJson($res, $datas['token'], '200', '订单添加成功'));
                }else{
                    flock($file,LOCK_UN);//解锁
                    //关闭文件
                    fclose($file);
                    exit(Publics::ApiJson('', $datas['token'], '201', '订单添加失败'));
                }
            }else{
                flock($file,LOCK_UN);//解锁
                //关闭文件
                fclose($file);
                exit(Publics::ApiJson('', $datas['token'], '201', '未获取广告或已被购买'));
            }

        }else{

            flock($file,LOCK_UN);//解锁
            //关闭文件
            fclose($file);
            exit(Publics::ApiJson('', $datas['token'], '201', '广告已被购买'));
        }


    }


    //定义模型一对多关系
    public function orders(){
        return $this->hasMany('AdOrder','ad_id','id');
    }
}