<?php

namespace app\api\controller;



use app\admin\logic\Config;
use app\api\model\Member;
use FontLib\Table\Type\name;
use PhpOffice\PhpSpreadsheet\Reader\Xls\MD5;
use think\Cache;
use think\Controller;
use think\Db;
use think\Loader;
use think\Request;
use think\Validate;

class Login extends Controller
{
    public $token;
    public $post;

    public function __construct()
    {
        header("Access-Control-Allow-Origin: *");
        $list = file_get_contents('php://input');
        $this->post = json_decode($list, true);
        error_reporting(E_ERROR | E_PARSE );//关闭tp5严格模式

    }

    /**
     * @param Request $request
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * 登录
     */
    public function login(Request $request)
    {
        if ($request->isPost()) {
            //$data = input();

            $data = $this->post;
            if (!isset($data['tel']) || empty($data['tel'])){
                exit(Publics::ApiJson('', '', 201, '缺少参数tel'));
            }
            if (!isset($data['password']) || empty($data['password'])){
                exit(Publics::ApiJson('', '', 201, '缺少参数password'));
            }

            $m=model('member')->where('tel',$data['tel'])->find();
            if ($m) {
                if ($m->password = md5($data['password'])) {
                    $this->token = Publics::getToken();//获取token
                   // Db::table('eacoo_member')->where($va)->update(array('token'=>$this->token));
                    $m->token=$this->token;
                    $m->save();//保存token
                    $member=db('member')->where('tel',$data['tel'])->find();
                    exit(Publics::ApiJson($member, $this->token, 200, '登录成功'));
                } else {
                    exit(Publics::ApiJson('', '', 201, '密码错误'));
                }
            } else {
                exit(Publics::ApiJson('', '', 201, '用戶不存在'));
            }
        }
    }


    /**
     * @param Request $request
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     * 快捷登录 type等于1qq登录，type2 微信登录
     */
    public function other_login(Request $request){
        if ($request->isPost()) {
           // $data = input();
            $data = $this->post;
            if(!isset($data['type']) || empty($data['type'])){
                exit(Publics::ApiJson('', '', 201, '缺少参数type'));
            }
            //type等于1facebook登录，type2 line登录
            if ($data['type'] ==1){
                if (!isset($data['facebook_id']) || empty($data['facebook_id'])){
                    exit(Publics::ApiJson('', '', 201, '缺少参数facebook_id'));
                }

                $member=Db::table('eacoo_member')->where('facebook_id',$data['facebook_id'])->find();
                if($member){
                    $this->token = Publics::getToken();//获取token
                    Db::table('eacoo_member')->where('facebook_id',$data['facebook_id'])->update(array('token'=>$this->token));
                    $res=[//type等于二不需要绑定手机号
                        'type'=>2,
                    ];
                    exit(Publics::ApiJson($res, $this->token, 200, '登錄成功'));
                }else{
                    //创建账号
                    $value=[
                        'token'=>Publics::getToken(),
                        'facebook_id'=>$data['facebook_id'],
                    ];
                    $member_id=Db::table('eacoo_member')->insertGetId($value);
                    if ($member_id){
                        $res=[//type等于1需要绑定手机号
                            'type'=>1,
                        ];
                        exit(Publics::ApiJson($res, $this->token, 200, '登錄成功'));
                    }else{
                        exit(Publics::ApiJson('', $this->token, 201, '登錄失败'));
                    }
                }
            }

            //type等于1facebook登录，type2 line登录
            if ($data['type'] ==2){

                if (!isset($data['line_id']) || empty($data['line_id'])){
                    exit(Publics::ApiJson('', $this->token, 201, '缺少参数line_id'));
                }
                $member=Db::table('eacoo_member')->where('line_id',$data['line_id'])->find();
                if($member){
                    $this->token = Publics::getToken();//获取token
                    Db::table('eacoo_member')->where('line_id',$data['line_id'])->update(array('token'=>$this->token));

                    $res=[//type等于二不需要绑定手机号
                        'type'=>2,
                    ];
                    exit(Publics::ApiJson($res, $this->token, 200, '登錄成功'));
                }else{
                    //创建账号
                    //查看是否上传了头像
                    if (isset($data['icon_path']) || !empty($data['icon_path'])){
                        $icon=Publics::create_img($data['icon_path']);
                    }else{
                        $icon=125;
                    }
                    $value=[
                        'name'=>$data['name'],
                        'icon'=>$icon,
                        'line_id'=>$data['line_id'],
                    ];
                    $member_id=Db::table('eacoo_member')->insertGetId($value);
                    if ($member_id){
                        $res=[//type等于1需要绑定手机号
                            'type'=>1,
                        ];
                        exit(Publics::ApiJson($res, $this->token, 200, '登錄成功'));
                    }else{
                        exit(Publics::ApiJson('', $this->token, 201, '登錄失败'));
                    }



                }


            }


        }
    }

    /**
     * @param string $email
     * 发送邮箱验证码
     */
    public function setemail(Request $request)
    {
        if ($request->isPost()) {
           // $email = input('email');
            $email = $this->post['email'];
            //参生一个随机的验证码
            $code = rand(1000, 9999);

            //查询邮件类容
            $content=Db::name('set')->where('id',1)->value('email_content');
            $content = $content =!0 ? $content :'当前邮箱验证码为:';
            Cache::set($email.'email_code', $code, 5 * 60);//设置5分钟
            $rs = Publics::sendMail($email, '邮箱验证', $content. $code . '（有效期为5分钟）');

            if ($rs['status']) {
                exit(Publics::ApiJson('', '', 200, '邮件发送成功'));
            } else {
                exit(Publics::ApiJson('', '', 201, $rs['msg']));
            }
        }
    }

    /**
     * @param Request $request
     * 调用阿里云短信接口
     */
    public function set_sms(Request $request){
        if ($request->isPost()){
            if (!isset($this->post['tel'])){
                exit(Publics::ApiJson('', '', 201, '缺少参数tel'));
            }
            $data=$this->post;
            if(!isset($data['type']) || empty($data['type'])){
                exit(Publics::ApiJson('', '', 201, '缺少参数type'));
            }
            $result=Publics::getcode($data['tel'],$data['type']);
            if($result){
                exit(Publics::ApiJson($result, '', 200, '短信發送成功'));
            }else{
                exit(Publics::ApiJson($result, '', 201, '短信發送失败'));
            }

        }

    }


    /**
     * @param Request $request
     * 发送短信接口(访问别人接口)
     */
    public function setsms(Request $request){
        if($request->isPost()){
            //$tel=input('tel');
            if (!isset($this->post['tel'])){
                exit(Publics::ApiJson('', '', 201, '缺少参数tel'));
            }
            $tel=$this->post['tel'];
            $code = rand(1000, 9999);
            $data=$this->post;
            if(isset($data['type']) && !empty($data['type'])){
                $type=$data['type'];
            }else{
                $type=3;
            }
            switch ($type){
                case 1://注册
                    $content='【我的I将】欢迎注册I将，验证码为：'.$code.'，5分钟有效';
                    break;
                case 2://绑定手机号
                    $content='【我的I将】绑定手机号验证码为：'.$code.'，5分钟有效';
                    break;
                case 3://万能
                    $content='【我的I将】短信验证码为：'.$code.'，5分钟有效';
                    break;
            }
            Cache::set($tel.'sms_code',$code, 5 * 60);//设置5分钟
            $res=set_sms($tel,$content);
            $data=json_decode($res);
            if($data->ErrorCode ==0){
                exit(Publics::ApiJson('', '', 200, '短信發送成功'));
            }else{
                exit(Publics::ApiJson('', '', 201, '短信發送失败'));
            }
        }
    }




/**
     * 获取微信小程序APPID和secret
     **/
    public function testpays()
    {
        header("Access-Control-Allow-Origin: *");
        $list = file_get_contents('php://input');
        $post = json_decode($list, true);
        $url = 'https://api.weixin.qq.com/sns/jscode2session?appid=wx7bd6aaa05d934b88&secret=fd849614ad501522d55bf2fa1b94f4bf&js_code=' . $post['code'] . '&grant_type=authorization_code';
        $result = file_get_contents($url);
        //file_put_contents('open11.txt', $result);
        exit($result);
    }


}
