<?php

namespace app\api\controller;

use Mrgoon\AliSms\AliSms;
use PHPMailer\PHPMailer\PHPMailer;
use think\Cache;
use think\Controller;
use think\Db;
use think\Request;

class Publics extends Controller
{
    public function _initialize()
    {
        parent::_initialize();
    }

    //返回给前端
    public static function ApiJson($data, $token = '', $status = 200, $msg = '成功')
    {
        return json_encode([
            'status' => $status,
            'token' => $token,
            'data' => $data,
            'msg' => $msg
        ],JSON_UNESCAPED_SLASHES);

    }


    /**
     * @param Request $request
     * 获取手机号验证码
     */
    public static function getcode($tel, $type = 1)
    {
        if ($type == 1) {//注册
            $template_code = 'SMS_173252577';
        }
        if ($type == 2) {//修改手机号
            $template_code = 'SMS_173247870';
        }
        if ($type ==3){//修改密码
            $template_code = 'SMS_173252833';
        }
        $num = rand(10000, 99999);
        Cache::set($tel . 'sms', $num, 3600);//存取缓存
        //发送验证码
        $config = [
            'access_key' => 'LTAIL0tKYbWUBTwv',
            'access_secret' => 'WteVtKBsMFn7IsZVdnkXqoJjHirylF',
            'sign_name' => '八卦来了',//阿里云签名
        ];

        // $aliSms = new Mrgoon\AliSms\AliSms();
        $aliSms = new AliSms();
        $response = $aliSms->sendSms($tel, $template_code, ['code' => $num], $config);
        if ($response->Code == 'OK') {
          return 1;
        } else {
           return 0;
        }
    }


    /**
     * @return string
     * 获取token
     */
    public static function getToken()
    {
        $str = md5(uniqid(md5(microtime(true)), true));  //生成一个不会重复的字符串
        $str = sha1($str);  //加密
        //查询数据库看是否有这个token
        $rss = Db::table('eacoo_member')->where('token', $str)->find();
        if ($rss) {
            self::getToken();
        }
        return $str;
    }



    /**
     * @return string
     * 生成唯一的字符串
     */
    public static function get_rand()
    {
        $data = $_SERVER['HTTP_USER_AGENT'] . $_SERVER['REMOTE_ADDR']
            . time() . rand();
        return sha1($data);
    }


    /**
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * 生成订单号
     */
    public static function order_code()
    {
        $rand = date('YmdHis') . rand(100000, 999999);
        $res = Db::table('eacoo_ad_order')->where('code', $rand)->find();
        if (!empty($res)) {
            Publics::order_code();
        } else {
            return $rand;
        }
    }


    /**
     * @param int $id
     * @return mixed
     * 返回图片路径
     */
    public static function get_icon($id = 0,$type=1)
    {
        if ($id != 0) {
            $path= Db::table('eacoo_attachment')->where('id', $id)->value('path');
            $path= str_replace("\\",'/',$path);
        } else {
            if ($type ==1){
                $path= Db::table('eacoo_attachment')->where('id', 139)->value('path');//默认图片
                $path= str_replace("\\",'/',$path);
            }else{
                $path='';
            }

        }

        return $path;

    }

    /**
     * 2  * 发送邮件方法
     * 3  * @param string $to：接收者邮箱地址
     * 4  * @param string $title：邮件的标题
     * 5  * @param string $content：邮件内容
     * 6  * @return boolean  true:发送成功 false:发送失败
     * 7  * @param  string $fujian :附件地址
     * 8  */
    public static function sendMail2($to, $title, $content, $fujian='')
    {
        //把 SSL/465 改成 TLS/587
        //实例化PHPMailer核心类
        $mail = new PHPMailer();
        $mail -> CharSet='utf-8'; //设置字符集
        //是否启用smtp的debug进行调试 开发环境建议开启 生产环境注释掉即可 默认关闭debug调试模式
        $mail->SMTPDebug = 0;
        //使用smtp鉴权方式发送邮件
        $mail->isSMTP();
        //smtp需要鉴权 这个必须是true
        $mail->SMTPAuth = true;
        //链接qq域名邮箱的服务器地址smtp.qq.com
        $mail->Host = 'smtp.live.com';
        //设置使用ssl加密方式登录鉴权
       //$mail->SMTPSecure = 'ssl';//ssl
        $mail->SMTPSecure = 'tls';//ssl
        //设置ssl连接smtp服务器的远程服务器端口号，以前的默认是25，但是现在新的好像已经不可用了 可选465或587
        /*POP3服务器 pop.126.com 110
        SMTP服务器 smtp.126.com 25
        IMAP服务器 imap.126.com 143*/
       // $mail->Port = 465;//465
        $mail->Port = 587;//465
        //设置smtp的helo消息头 这个可有可无 内容任意
        //$mail->Helo = 'Hello smtp.qq.com Server';
        //设置发件人的主机域 可有可无 默认为localhost 内容任意，建议使用你的域名
        //$mail->Hostname = 'localhost';
        //设置发送的邮件的编码 可选GB2312 我喜欢utf-8 据说utf8在某些客户端收信下会乱码
        $mail->CharSet = 'UTF-8';
        //设置发件人姓名（昵称） 任意内容，显示在收件人邮件的发件人邮箱地址前的发件人姓名
        $mail->FromName = '我的I將';
        //smtp登录的账号 这里填入字符串格式的qq号即可
        $mail->Username = 'denny0710@hotmail.com';
        //smtp登录的密码 使用生成的授权码 你的最新的授权码
        $mail->Password = 'Jasonwei888';
        //设置发件人邮箱地址 这里填入上述提到的“发件人邮箱”
        $mail->From = 'denny0710@hotmail.com';
        //邮件正文是否为html编码 注意此处是一个方法 不再是属性 true或false
        $mail->isHTML(true);
        //设置收件人邮箱地址 该方法有两个参数 第一个参数为收件人邮箱地址 第二参数为给该地址设置的昵称 不同的邮箱系统会自动进行处理变动 这里第二个参数的意义不大
        $mail->addAddress($to, '我的I将');
        //添加多个收件人 则多次调用方法即可
        // $mail->addAddress('xxx@qq.com','lsgo在线通知');
        //添加该邮件的主题
        $mail->Subject = $title;
        //添加邮件正文 上方将isHTML设置成了true，则可以是完整的html字符串 如：使用file_get_contents函数读取本地的html文件
        $mail->Body = $content;

        //为该邮件添加附件 该方法也有两个参数 第一个参数为附件存放的目录（相对目录、或绝对目录均可） 第二参数为在邮件附件中该附件的名称
        if($fujian !=''){
            $mail->addAttachment($fujian, $title.'.pdf');
        }

        //同样该方法可以多次调用 上传多个附件
        // $mail->addAttachment('./Jlib-1.1.0.js','Jlib.js');

        $status = $mail->send();
       // var_dump($status);exit();

        //简单的判断与提示信息
        if ($status) {
            return array('status'=>true,'msg'=>'');
        } else {
            return array('status'=>false,'msg'=>$mail->ErrorInfo);
        }
    }

    /**
     * 2  * 发送邮件方法
     * 3  * @param string $to：接收者邮箱地址
     * 4  * @param string $title：邮件的标题
     * 5  * @param string $content：邮件内容
     * 6  * @return boolean  true:发送成功 false:发送失败
     * 7  * @param  string $fujian :附件地址
     * 8  */
    public static function sendMail($to, $title, $content, $fujian)
    {
        //实例化PHPMailer核心类
        $mail = new PHPMailer();
        $mail -> CharSet='utf-8'; //设置字符集
        //是否启用smtp的debug进行调试 开发环境建议开启 生产环境注释掉即可 默认关闭debug调试模式
        $mail->SMTPDebug = false;
        //使用smtp鉴权方式发送邮件
        $mail->isSMTP();
        //smtp需要鉴权 这个必须是true
        $mail->SMTPAuth = true;
        //链接qq域名邮箱的服务器地址smtp.qq.com
        $mail->Host = 'smtp.qq.com';
        //$mail->Host = 'smtp.126.com';
        //设置使用ssl加密方式登录鉴权
        $mail->SMTPSecure = 'ssl';
        //设置ssl连接smtp服务器的远程服务器端口号，以前的默认是25，但是现在新的好像已经不可用了 可选465或587
        /*POP3服务器 pop.126.com 110
        SMTP服务器 smtp.126.com 25
        IMAP服务器 imap.126.com 143*/
        $mail->Port = 465;
        //设置smtp的helo消息头 这个可有可无 内容任意
        //$mail->Helo = 'Hello smtp.qq.com Server';
        //设置发件人的主机域 可有可无 默认为localhost 内容任意，建议使用你的域名
        //$mail->Hostname = 'localhost';
        //设置发送的邮件的编码 可选GB2312 我喜欢utf-8 据说utf8在某些客户端收信下会乱码
        $mail->CharSet = 'UTF-8';
        //设置发件人姓名（昵称） 任意内容，显示在收件人邮件的发件人邮箱地址前的发件人姓名
        $mail->FromName = '八卦来了';
        //smtp登录的账号 这里填入字符串格式的qq号即可
        $mail->Username = '2969854390';
        //smtp登录的密码 使用生成的授权码 你的最新的授权码
        $mail->Password = 'wfepftcvnhkadfjh';
        //设置发件人邮箱地址 这里填入上述提到的“发件人邮箱”
        $mail->From = '2969854390@qq.com ';
        //邮件正文是否为html编码 注意此处是一个方法 不再是属性 true或false
        $mail->isHTML(true);
        //设置收件人邮箱地址 该方法有两个参数 第一个参数为收件人邮箱地址 第二参数为给该地址设置的昵称 不同的邮箱系统会自动进行处理变动 这里第二个参数的意义不大
        $mail->addAddress($to, '八卦来了');
        //添加多个收件人 则多次调用方法即可
        // $mail->addAddress('xxx@qq.com','lsgo在线通知');
        //添加该邮件的主题
        $mail->Subject = $title;
        //添加邮件正文 上方将isHTML设置成了true，则可以是完整的html字符串 如：使用file_get_contents函数读取本地的html文件
        $mail->Body = $content;

        //为该邮件添加附件 该方法也有两个参数 第一个参数为附件存放的目录（相对目录、或绝对目录均可） 第二参数为在邮件附件中该附件的名称
       // $mail->addAttachment($fujian, $title.'.pdf');
        //同样该方法可以多次调用 上传多个附件
        // $mail->addAttachment('./Jlib-1.1.0.js','Jlib.js');

        $status = $mail->send();

        //简单的判断与提示信息
        if ($status) {
            return array('status'=>true,'msg'=>'');
        } else {
            return array('status'=>false,'msg'=>$mail->ErrorInfo);
        }
    }
    /**
     * @param $date
     * @return string
     * 日期转中文汉字
     */
    public static function toDateChinese($date)
    {

        $date_arr = explode('-', $date);
        $arr = [];
        foreach ($date_arr as $index => &$val) {
            if (mb_strlen($val) == 4) {
                $arr[] = preg_split('/(?<!^)(?!$)/u', $val);
            } else {
                if ($val > 10) {
                    $v[] = 10;
                    $v[] = $val % 10;
                    $arr[] = $v;
                    unset($v);
                } else {
                    $arr[][] = $val;
                }
            }
        }
        $cn = array("一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "零");
        $num = array("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "0");
        $str_time = '';
        for ($i = 0; $i < count($arr); $i++) {
            foreach ($arr[$i] as $index => $item) {
                $str_time .= $cn[array_search($item, $num)];
            }
            if ($i == 0) {
                $str_time .= '年';
            } elseif ($i == 1) {
                $str_time .= '月';
            } elseif ($i == 2) {
                $str_time .= '日';
            }
        }
        return $str_time;
    }


    /**
     * @param $num
     * @return mixed|string
     * 获得大写数字
     */
    public static function numTrmb($num){
       // header("charset=utf-8;");
        $d = array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖");
        $e = array('元', '拾', '佰', '仟', '万', '拾万', '佰万', '仟万', '亿', '拾亿', '佰亿', '仟亿');
        $p = array('分', '角');
        $zheng = "整";
        $final = array();
        $inwan = 0;//是否有万
        $inyi = 0;//是否有亿
        $len = 0;//小数点后的长度
        $y = 0;
        $num = round($num, 2);//精确到分
        if(strlen($num) > 15){
            return "金额太大";
            die();
        }
        if($c = strpos($num, '.')){//有小数点,$c为小数点前有几位
            $len=strlen($num)-strpos($num,'.')-1;//小数点后有几位数
        }else{//无小数点
            $c = strlen($num);
            $zheng = '整';
        }
        $low='';
        for($i = 0; $i < $c; $i++){
            $bit_num = substr($num, $i, 1);
            if ($bit_num != 0 || substr($num, $i + 1, 1) != 0) {
                @$low = $low . $d[$bit_num];
            }
            if ($bit_num || $i == $c - 1) {
                @$low = $low . $e[$c - $i - 1];
            }
        }
        if($len!=1){
            for ($j = $len; $j >= 1; $j--) {
                $point_num = substr($num, strlen($num) - $j, 1);
                @$low = $low . $d[$point_num] . $p[$j - 1];
            }
        }else{
            $point_num = substr($num, strlen($num) - $len, 1);
            $low=$low.$d[$point_num].$p[$len];
        }
        $chinses = str_split($low, 3);//字符串转化为数组
        for ($x = count($chinses) - 1; $x >= 0; $x--) {
            if ($inwan == 0 && $chinses[$x] == $e[4]) {//过滤重复的万
                $final[$y++] = $chinses[$x];
                $inwan = 1;
            }
            if ($inyi == 0 && $chinses[$x] == $e[8]) {//过滤重复的亿
                $final[$y++] = $chinses[$x];
                $inyi = 1;
                $inwan = 0;
            }
            if ($chinses[$x] != $e[4] && $chinses[$x] !== $e[8]) {
                $final[$y++] = $chinses[$x];
            }
        }
        $newstr = (array_reverse($final));
        $nstr = join($newstr);
        if((substr($num, -2, 1) == '0') && (substr($num, -1) <> 0)){
            $nstr = substr($nstr, 0, (strlen($nstr) -6)).'零'. substr($nstr, -6, 6);
        }
        $nstr=(strpos($nstr,'零角')) ? substr_replace($nstr,"",strpos($nstr,'零角'),6) : $nstr;
        return $nstr = (substr($nstr,-3,3)=='元') ? $nstr . $zheng : $nstr;
    }

    /**
     * @param $url
     * @return mixed
     * get请求其他接口
     */
    public static function curl_get($url){

        $testurl = $url;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $testurl);
        //参数为1表示传输数据，为0表示直接输出显示。
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        //参数为0表示不带头文件，为1表示带头文件
        curl_setopt($ch, CURLOPT_HEADER,0);
        $output = curl_exec($ch);
        curl_close($ch);
        return $output;
    }


    /**
     * @param $url
     * @param $array
     * @return mixed
     * post请求其他接口
     */
    public static function curl_post($url,$array){
        $curl = curl_init();
        //设置提交的url
        curl_setopt($curl, CURLOPT_URL, $url);
        //设置头文件的信息作为数据流输出
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //设置获取的信息以文件流的形式返回，而不是直接输出。
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        //设置post方式提交
        curl_setopt($curl, CURLOPT_POST, 1);
        //设置post数据
        $post_data = $array;
        curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
        //执行命令
        $data = curl_exec($curl);
        //关闭URL请求
        curl_close($curl);
        //获得数据并返回
        return $data;
    }

    /**
     * @param array $icon
     * @return array
     * 图片数组转换为图片路径
     */
    public static function icon_toarray($icon=[]){
        if(empty($icon)){
            return [];
        }
        $data=[];
        foreach ($icon as $k=>$v){
            $data[$k]=str_replace("\\",'/',self::get_icon($v));
        }
        return $data;
    }

    /**
     * @param int $id
     * @return mixed|string
     * 获取模型中的某个值
     */
    public static function get_model_value($model,$id=0,$key){
        if (empty($id)){
            return '';
        }
        $res =Db::name("$model")->where('id',$id)->value("$key");
        if ($res){
            return $res;
        }else{
            return '';
        }
    }



    //创建图片
    public static function create_img($img_path){
        //保存文件名称及路径
        $path="./static/uploads/".date('Y-m-d',time());
        $dir = iconv("UTF-8", "GBK",$path);
        if (!file_exists($dir)){
            mkdir ($dir,0777,true);//创建文件夹
        }
       // $img ="http://i2.muimg.com/567571/9b838948a0e2c13f.jpg" ;
        ob_clean();
        ob_start();
        readfile($img_path);		//读取图片
        $img = ob_get_contents();	//得到缓冲区中保存的图片
        ob_end_clean();		//清空缓冲区
        $img=$path.self::get_rand().'.jpg';
        $fp = fopen($img,'w');	//写入图片
        if(fwrite($fp,$img))
        {
            fclose($fp);//关闭文件
            // 成功上传后 获取上传信息
            $dd=[
                'path'=>$img,
                'name'=>'toux',
                'url'=>$img,
                'path_type'=>'picture',
                'create_time'=>strtotime('Y-m-d H:i:s',time()),
            ];
            //新建图片
            $data['icon']=Db::table('eacoo_attachment')->insertGetId($dd);
            return $data;
        }else{
            return false;
        }

    }

    //无限极分类

    /**
     * @param $categorys 数据
     * @param int $catId 父类id
     * @param int $level 等级
     * @return array
     * 找所有所有子集
     */
   public static  function getSubs($categorys,$catId=0,$level=1)
    {
        $subs = array();
        foreach ($categorys as $item) {
            if ($item['pid'] == $catId) {
                $item['level'] = $level;
                $subs[] = $item;
                $subs = array_merge($subs, self::getSubs($categorys, $item['id'], $level + 1));

            }
        }
        return $subs;
    }


    /**
     * @param $categorys
     * @param int $catId
     * @return array
     * 找直接子集
     */
    function getSons($categorys,$catId=0)
    {
        $sons = [];
        foreach ($categorys as $item) {
            if ($item['pid'] == $catId)
                $sons[] = $item;
        }
        return $sons;
    }


    /**
     * @param $categorys
     * @param $catId
     * @return array
     * 找所有父亲
     */
    function getParents2($categorys,$catId)
    {
        $tree = array();
        while ($catId != 0) {
            foreach ($categorys as $item) {
                if ($item['categoryId'] == $catId) {
                    $tree[] = $item;
                    $catId = $item['parentId'];
                    break;
                }
            }
        }
        return $tree;
    }

    //产生一个随机字符串
    public static function rand_code(){
        $strs="QWERTYUIOPASDFGHJKLZXCVBNM1234567890qwertyuiopasdfghjklzxcvbnm";
        $name=substr(str_shuffle($strs),mt_rand(0,strlen($strs)-11),10);
        $name2=db('member')->where('name',$name)->value('name');
        if ($name2){
            self::rand_code();
        }else{
            return $name;
        }
    }

    public static function httpPostJson($url, $data_string,$header) {

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        //curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0); // 对认证证书来源的检查
       // curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 1); // 从证书中检查SSL加密算法是否存在
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);

        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);


        ob_start();
        curl_exec($ch);

        $return_content = ob_get_contents();
        ob_end_clean();
        $return_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        return array($return_code, $return_content);
    }


}
