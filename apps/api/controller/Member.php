<?php

namespace app\api\controller;


use think\Cache;
use think\Controller;
use think\Db;
use think\Loader;
use think\Request;

class Member extends Base
{

    //修改密码
    public function edit_password(Request $request){
        if ($request->isPost()){
            $data=$this->post;
            if (!isset($data['old_password']) || empty($data['old_password'])){
                exit(Publics::ApiJson('', $this->token, 201, '原密码不能为空'));
            }
            if (!isset($data['password']) ||empty($data['password'])){
                exit(Publics::ApiJson('', $this->token, 201, '新密码不能为空'));
            }
            if (!isset($data['check_password']) ||empty($data['check_password'])){
                exit(Publics::ApiJson('', $this->token, 201, '确认密码不能为空'));
            }
            if ($this->member['password'] != md5($data['old_password'])){
                exit(Publics::ApiJson('', $this->token, 201, '旧密码错误'));
            }
            if ($data['password'] != $data['check_password']){
                exit(Publics::ApiJson('', $this->token, 201, '两次密码不一致'));
            }
            //修改密码
           $res= db('member')->where('id',$this->uid)->update(['password'=>md5($data['password']),'password_plaintext'=>$data['password'],'update_time'=>time()]);
            if ($res){
                exit(Publics::ApiJson('', $this->token, 200, '修改成功'));
            }else{
                exit(Publics::ApiJson('', $this->token, 201, '修改失败'));
            }

        }


    }

    //获取用户信息,会员中心
    public function index(Request $request){
        if ($request->isPost()){
            $data['id']=$this->uid;
            $member=db('member')->where('id',$this->uid)->find();
            if ($member){
                //TODO :: 图片统计，分享统计

                $member['plotting_number']=db('plotting')->where('member_id',$this->uid)->where('status',1)->count();//展绘图片

                $member['icon_path']=Publics::get_icon($member['icon']);
                $member['customer_tel']=db('set')->where('id',1)->value('customer_tel');//获取联系客户的电话

                //查询会员的所有展绘id
                $plotting_ids=db('plotting')->where('member_id',$this->uid)->where('status',1)->column('id');
                $map['plotting_id']=array('in',$plotting_ids);

                $member['share']=db('share')->where($map)->count();//统计分享

                $map['status']=array('eq',1);
                $member['icon_number']=db('plotting_details')->where($map)->count();

                exit(Publics::ApiJson($member, $this->token, 200, '获取数据成功'));
            }else{
                exit(Publics::ApiJson('', $this->token, 201, '获取数据失败'));
            }
        }
    }

    //修改用户资料
    public function member_edit(Request $request){
        if ($request->isPost()){
            $data=$this->post;
            //验证数据
            if (isset($data['name']) && empty($data['name'])){
                exit(Publics::ApiJson('', $this->token, 201, '昵称不能为空'));
            }
            if (isset($data['icon']) && empty($data['icon'])){
                exit(Publics::ApiJson('', $this->token, 201, '头像不能为空'));
            }
            if (isset($data['sex']) && empty($data['sex'])){
                exit(Publics::ApiJson('', $this->token, 201, '性别不能为空'));
            }
            if (isset($data['autograph']) && empty($data['autograph'])){
                exit(Publics::ApiJson('', $this->token, 201, '个性签名不能为空'));
            }
            if (isset($data['tel']) && empty($data['tel'])){
                exit(Publics::ApiJson('', $this->token, 201, '手机号不能为空'));
            }
            if (isset($data['email']) && empty($data['email'])){
                exit(Publics::ApiJson('', $this->token, 201, '邮箱不能为空'));
            }
            $member=model('member')->allowField(true)->save($data,['id'=>$this->uid]);
            if ($member){
                exit(Publics::ApiJson($member, $this->token, 200, '修改成功'));
            }else{
                exit(Publics::ApiJson($member, $this->token, 201, '修改失败'));
            }


        }
    }



    //绑定手机号或邮箱
    public function bind_number(Request $request){
        if ($request->isPost()){
            $data=$this->post;

            if (!isset($data['type']) || empty($data['type'])){
                exit(Publics::ApiJson('', $this->token, 201, '缺少参数type'));
            }

            if ($data['type'] ==1){//手机号
                if (!isset($data['tel']) || empty($data['tel'])){
                    exit(Publics::ApiJson('', $this->token, 201, '缺少参数tel'));
                }
                if (!isset($data['code']) || empty($data['code'])){
                    exit(Publics::ApiJson('', $this->token, 201, '缺少参数code'));
                }
                if ($data['code'] != Cache::get($data['tel']. 'sms')){
                    exit(Publics::ApiJson('', $this->token, 201, '验证码错误'));
                }

                //修改手机号
                db('member')->where('id',$this->uid)->update(['tel'=>$data['tel'],'update_time'=>time()]);
                exit(Publics::ApiJson('', $this->token, 200, '操作成功'));
            }elseif ($data['type'] ==2){//邮箱
                if (isset($data['email']) || empty($data['email'])){
                    exit(Publics::ApiJson('', $this->token, 201, '缺少参数email'));
                }
                if (isset($data['code']) || empty($data['code'])){
                    exit(Publics::ApiJson('', $this->token, 201, '缺少参数code'));
                }
                if ($data['code'] != Cache::get($data['email'].'email_code')){
                    exit(Publics::ApiJson('', $this->token, 201, '验证码错误'));
                }
                //修改邮箱
                db('member')->where('id',$this->uid)->update(['email'=>$data['email'],'update_time'=>time()]);
                exit(Publics::ApiJson('', $this->token, 200, '操作成功'));
            }
        }
    }





}
