<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/18
 * Time: 17:06
 */

namespace app\api\model;

use app\api\controller\Publics;

class Login extends \think\Model
{

    /**
     * @param $token
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * 添加登录记录
     */
   public function login_record($token){
       //添加登录记录
       $date=date('Y-m-d',time());
       $date_strtotime=strtotime($date);
       //查询前一天
       $yesterday_strtotime=strtotime(date("Y-m-d",strtotime("-1 day")));
       //查询会员
       $member=db('member')->where('token',$token)->find();

       if ($member){
           //登录签到积分
           $integral=db('set_integral')->where('type',6)->find();
           $integral2=db('set_integral')->where('type',4)->find(); //查询设置漏签的积分

           $day_time=strtotime(date('Y-m-d',time()));
           $wh['day_time']=array('eq',$day_time);
           $wh['member_id']=array('eq',$member['id']);
           $wh['type_integral']=array('eq',6);//签到
           $member_integral=db('member_integral')->where($wh)->find();
           if (!$member_integral){//先查看漏签，再查看签到，不存在就添加积分记录，并添加积分
               //漏签减积分
               //1.查询最后一次签到的时间
               $wh2['member_id']=array('eq',$member['id']);
               $wh2['type_integral']=array('eq',6);//签到
               $member_old_integral=db('member_integral')->where($wh2)->order('create_time','desc')->find();
                if ($member_old_integral){
                    //最后一次登录时间，计算相差天数
                    $day =timediff($member_old_integral['day_time'],$day_time);

                    if ($day >0){
                        //会员扣积分，不能扣到负数
                        $inte= db('member')->where('id',$member['id'])->value('integral');
                        $intall = $day * $integral2['integral'];

                        if ($inte < $intall){
                            db('member')->where('id',$member['id'])->update(['integral'=>0]);//直接为零
                        }else{
                            db('member')->where('id',$member['id'])->setDec('integral',$intall);
                        }


                        $value=[];//漏签数据
                        $itime=$member_old_integral['day_time'];//最后一次签到 天时间搓
                        for ($i=0;$i<$day;$i++){
                            $itime +=86400;//一天的时间搓
                            $value[$i]=[
                                'member_id'=>$member['id'],
                                'title'=>'漏签',
                                'integral'=>$integral2['integral'],
                                'type'=>2,//减少积分
                                'day_time'=>$itime,
                                'month'=>date('m',$itime),
                                'type_integral'=>4,
                                'create_time'=>$itime,
                                'update_time'=>$itime
                            ];
                        }
                        db('member_integral')->insertAll($value);//批量更新漏签记录
                    }
                }


                //签到加积分
                model('MemberIntegral')->allowField(true)->save([
                   'member_id'=>$member['id'],
                    'title'=>'签到',
                    'integral'=>$integral['integral'],
                    'type'=>1,//添加积分
                    'day_time'=>$day_time,
                    'month'=>date('m'),
                    'type_integral'=>6
                ]);
                //会员添加积分
               db('member')->where('id',$member['id'])->setInc('integral',$integral['integral']);
           }

           //获取权限，新手，普通，管理员
           $this->get_jurisdiction($member['id']);



           //查看当天是否有登录记录
           $map['member_id']=array('eq',$member['id']);
           $map['date_time']=array('eq',$date);
           $record=db('login_record')->where($map)->find();//查询当天是否有登录记录
           if (!$record){//不存在就添加记录
               //查找昨天是否登录
               $map2['member_id']=array('eq',$member['id']);
               $map2['login_time']=array('eq',$yesterday_strtotime);
               $yesterday=db('login_record')->where($map2)->find();
               if ($yesterday){
                   $count=$yesterday['count'] +1;//昨天的加1
               }else{
                   $count=1;
               }
               db('login_record')->insertGetId([
                   'member_id'=>$member['id'],
                   'login_time'=>$date_strtotime,
                   'timestamp'=>time(),
                   'date_time'=>$date,
                   'status'=>0,//表示已经提示过了
                   'count'=>$count,
               ]);
               return $count;
           }else{
               //查看是否提示过
               if($record['status'] ==1){
                   db('login_record')->where($map)->update(['status'=>0]);//更新为已提示
                   return $record['count'];//返回连续签到天数
               }else{
                   return 0;
               }
           }
       }
   }


   //登录用户获得权限
   public function get_jurisdiction($member_id){
       //查询后台积分设置
       $set=db('set')->where('id',1)->find();

       //查询会员是否在黑名单上
       $map['status']=array('eq',1);
       $map['member_id']=array('eq',$member_id);
       $balck=db("black_list")->where($map)->find();
        if ($balck){
            //查询黑名单是否失效
            if ($balck['end_time'] <time()){//已经过期
                db('member')->where('id',$member_id)->update(['integral'=>$set['coefficiet_m']]);//黑名单到期恢复到多少积分
                db("black_list")->where($map)->update(['status'=>0]);//更改状态为失效
            }
        }
       //查询会员积分
       $member_integral=db('member')->where('id',$member_id)->value('integral');
       if ($member_integral >$set['admin_integral'] || $member_integral ==$set['admin_integral']){
           db('member')->where('id',$member_id)->update(['vip'=>3]);//管理员
       }elseif ($member_integral >$set['plain_integral'] && $member_integral <$set['admin_integral']){
           db('member')->where('id',$member_id)->update(['vip'=>2]);//普通会员
       }elseif ($member_integral >$set['new_integral'] && $member_integral <$set['plain_integral']){
           db('member')->where('id',$member_id)->update(['vip'=>1]);//新手
       }elseif ($member_integral <0){

           //查询黑名单是否存在未过期的信息，不存在就添加
           $balck2=db("black_list")->where($map)->find();
           if (!$balck2){
               db('member')->where('id',$member_id)->update(['vip'=>-1]);//黑名单
               //添加会员上黑名单
               $count= db("black_list")->where('member_id',$member_id)->count();//上黑名单次数
               if ($count ==0){
                   $count=1;
               }
               $end_time=time() +($set['coefficiet_n'] *$count*24*60*60);
               db('black_list')->insert([
                   'member_id'=>$member_id,
                   'number'=>$count,
                   'end_time'=>$end_time,
                   'status'=>1,
                   'create_time'=>time(),
                   'update_time'=>time()
               ]);//添加黑名单
           }
       }
        return true;
   }





}