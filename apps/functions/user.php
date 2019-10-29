<?php
// 用户
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 https://www.eacoophp.com, All rights reserved.         
// +----------------------------------------------------------------------
// | [EacooPHP] 并不是自由软件,可免费使用,未经许可不能去掉EacooPHP相关版权。
// | 禁止在EacooPHP整体或任何部分基础上发展任何派生、修改或第三方版本用于重新分发
// +----------------------------------------------------------------------
// | Author:  心云间、凝听 <981248356@qq.com>
// +----------------------------------------------------------------------
use app\common\logic\User as UserLogic;
use app\common\logic\Action as ActionLogic;

/**
 * 检测用户是否登录
 * @return integer 0-未登录，大于0-当前登录用户ID
 * @author 心云间、凝听 <981248356@qq.com>
 */
function is_login() {
	return UserLogic::isLogin();
}

/**
 * 根据用户ID获取用户信息
 * @param  integer $id 用户ID
 * @return array  用户信息
 */
function get_user_info($uid) {
    if ($uid>0) {
        return UserLogic::info($uid);
    }
    return false;
    
}

/**
 * 获取用户名
 * @param  integer $uid [description]
 * @return [type] [description]
 * @date   2017-09-25
 * @author 心云间、凝听 <981248356@qq.com>
 */
function get_nickname($uid=0)
{
    if ($uid>0) {
        return UserLogic::where('uid',$uid)->value('nickname');
    }
    return false;
}

/**
 * @param $url
 * @return mixed
 * get请求其他接口
 */
function send_get($url){

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
function send_post($url,$array){
    $curl = curl_init();
    //设置提交的url
    curl_setopt($curl, CURLOPT_URL, $url);

    //设置头文件的信息作为数据流输出
    curl_setopt($curl, CURLOPT_HEADER, 0);
    curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
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
 * 2  * 发送邮件方法
 * 3  * @param string $to：接收者邮箱地址
 * 4  * @param string $title：邮件的标题
 * 5  * @param string $content：邮件内容
 * 6  * @return boolean  true:发送成功 false:发送失败
 * 7  * @param  string $fujian :附件地址
 * 8  */
function sendMail($to, $title, $content, $fujian='')
{
    //实例化PHPMailer核心类
    //$mail = new PHPMailer();
    $mail = new \PHPMailer\PHPMailer\PHPMailer();
    $mail -> CharSet='utf-8'; //设置字符集
    //是否启用smtp的debug进行调试 开发环境建议开启 生产环境注释掉即可 默认关闭debug调试模式
    $mail->SMTPDebug = 1;
    //使用smtp鉴权方式发送邮件
    $mail->isSMTP();
    //smtp需要鉴权 这个必须是true
    $mail->SMTPAuth = true;
    //链接qq域名邮箱的服务器地址smtp.qq.com
    $mail->Host = 'smtp.126.com';
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
    $mail->FromName = '我的愛將';
    //smtp登录的账号 这里填入字符串格式的qq号即可
    $mail->Username = 'aaaazx';
    //smtp登录的密码 使用生成的授权码 你的最新的授权码
    $mail->Password = 'tian123456';
    //设置发件人邮箱地址 这里填入上述提到的“发件人邮箱”
    $mail->From = 'aaaazx@126.com';
    //邮件正文是否为html编码 注意此处是一个方法 不再是属性 true或false
    $mail->isHTML(true);
    //设置收件人邮箱地址 该方法有两个参数 第一个参数为收件人邮箱地址 第二参数为给该地址设置的昵称 不同的邮箱系统会自动进行处理变动 这里第二个参数的意义不大
    $mail->addAddress($to, '报价附件');
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

    //简单的判断与提示信息
    if ($status) {
        return array('status'=>true,'msg'=>'');
    } else {
        return array('status'=>false,'msg'=>$mail->ErrorInfo);
    }
}


/**
 * @param string $tel 电话号码
 * @param string $content 内容
 * @return mixed
 * 发送短信
 */
function set_sms($tel='',$content=''){

    $url='http://smsc.ite2.com.tw/ApiSMSC/Sms/SendSms';
    //$password=base64_encode('ezt2019');
    $data=[
        'UID'=>'eztouch',//账号Ez53797337
        'Pwd'=>'ZXp0MjAxOQ==',//密码RXo1Mzc5NzMzNw==
        'DA'=>$tel,//手机号码
        'SM'=>$content,//简讯类容
    ];
    $data=json_encode($data);
    $res=send_post($url,$data);//post请求接口
    return $res;
}


//获取中文的首字母
function getFirstChar($s){
    $s0 = mb_substr($s,0,1,'utf-8');//获取名字的姓
    $s = iconv('UTF-8','GBK', $s0);//将UTF-8转换成GB2312编码
    if(ord($s0)>128){//汉字开头，汉字没有以U、V开头的
        $asc=ord($s{0})*256+ord($s{1})-65536;
        if($asc>=-20319 and $asc<=-20284)return "A";
        if($asc>=-20283 and $asc<=-19776)return "B";
        if($asc>=-19775 and $asc<=-19219)return "C";
        if($asc>=-19218 and $asc<=-18711)return "D";
        if($asc>=-18710 and $asc<=-18527)return "E";
        if($asc>=-18526 and $asc<=-18240)return "F";
        if($asc>=-18239 and $asc<=-17760)return "G";
        if($asc>=-17759 and $asc<=-17248)return "H";
        if($asc>=-17247 and $asc<=-17418)return "I";
        if($asc>=-17417 and $asc<=-16475)return "J";
        if($asc>=-16474 and $asc<=-16213)return "K";
        if($asc>=-16212 and $asc<=-15641)return "L";
        if($asc>=-15640 and $asc<=-15166)return "M";
        if($asc>=-15165 and $asc<=-14923)return "N";
        if($asc>=-14922 and $asc<=-14915)return "O";
        if($asc>=-14914 and $asc<=-14631)return "P";
        if($asc>=-14630 and $asc<=-14150)return "Q";
        if($asc>=-14149 and $asc<=-14091)return "R";
        if($asc>=-14090 and $asc<=-13319)return "S";
        if($asc>=-13318 and $asc<=-12839)return "T";
        if($asc>=-12838 and $asc<=-12557)return "W";
        if($asc>=-12556 and $asc<=-11848)return "X";
        if($asc>=-11847 and $asc<=-11056)return "Y";
        if($asc>=-11055 and $asc<=-10247)return "Z";
    }elseif(ord($s)>=48 and ord($s)<=57){//数字开头
        switch(iconv_substr($s,0,1,'utf-8')){
            case 1:return "Y";
            case 2:return "E";
            case 3:return "S";
            case 4:return "S";
            case 5:return "W";
            case 6:return "L";
            case 7:return "Q";
            case 8:return "B";
            case 9:return "J";
            case 0:return "L";
        }
    }else if(ord($s)>=65 and ord($s)<=90){//大写英文开头
        return substr($s,0,1);
    }else if(ord($s)>=97 and ord($s)<=122){//小写英文开头
        return strtoupper(substr($s,0,1));
    }else{
        return iconv_substr($s0,0,1,'utf-8');//中英混合的词语提取首个字符即可
    }
}



/**
 * 通过时间搓计算天数
 * @param $begin_time @开始时间
 * @param $end_time @结束时间
 * @return array
 */
function timediff($begin_time,$end_time)
{
   /* if($begin_time < $end_time){
        $starttime = $begin_time;
        $endtime = $end_time;
    }else{
        $starttime = $end_time;
        $endtime = $begin_time;
    }*/
    $starttime = $begin_time;
    $endtime = $end_time;
    //计算天数
    $timediff = $endtime-$starttime;
    $days = intval($timediff/86400);
    //计算小时数
    $remain = $timediff%86400;
    $hours = intval($remain/3600);
    //计算分钟数
    $remain = $remain%3600;
    $mins = intval($remain/60);
    //计算秒数
    $secs = $remain%60;
   // $res = array("day" => $days,"hour" => $hours,"min" => $mins,"sec" => $secs);
    return $days;
}

/**
 * @param $model
 * @param int $id
 * @param $key
 * @return string
 * 获取模型的某个值
 */
function get_model_value($model,$id=0,$key){
    if (empty($id)){
        return '';
    }
    $res =\think\Db::name("$model")->where('id',$id)->value("$key");
    if ($res){
        return $res;
    }else{
        return '';
    }
}

/**
 * @param $time
 * @return string
 * 时间计算
 */
function format_date($time){
    $t=time()-$time;
    $f=array(
        '31536000'=>'年',
        '2592000'=>'个月',
        '604800'=>'星期',
        '86400'=>'天',
        '3600'=>'小时',
        '60'=>'分钟',
        '1'=>'秒'
    );
    if (0 == floor($t/60)) {
        return '刚刚';
    }
    foreach ($f as $k=>$v)    {
        if (0 !=$c=floor($t/(int)$k)) {
            return $c.$v.'前';
        }
    }
}

/**
 * @return string
 * 获取客户端ip地址
 */
function get_ip(){
    if(!empty($_SERVER["HTTP_CLIENT_IP"])){
        $cip = $_SERVER["HTTP_CLIENT_IP"];
    }
    elseif(!empty($_SERVER["HTTP_X_FORWARDED_FOR"])){
        $cip = $_SERVER["HTTP_X_FORWARDED_FOR"];
    }
    elseif(!empty($_SERVER["REMOTE_ADDR"])){
        $cip = $_SERVER["REMOTE_ADDR"];
    }
    else{
        $cip = "无法获取！";
    }
    return $cip;
}

/**
 * 查询敏感词库
 */
function library($title){
    //查询敏感词
    $library=db('library')->where('status',1)->column('title');
    if (is_array($title)){
        foreach ($library as $k=>$v){
            foreach ($title as $kk=>$vv){
                if (strpos($vv,$v) !==false){
                    return ['status'=>1,'title'=>$v];
                }
            }
        }
        return false;
    }else{
        foreach ($library as $k=>$v) {
            if (strpos($title, $v) !== false) {
                return ['status' => 1, 'title' => $v];
            }
        }
        return false;
    }
}

/**
 * 检查ip是否被禁用
 */
function see_ip(){
    $ip=get_ip();
    $map['ip']=array('eq',$ip);
    $map['ip_status']=array('eq',0);//禁用
    $article = db('article')->where($map)->find();
    if ($article){
        return true;
    }else{
        return false;
    }


}

/**
 * @param int $id
 * @param int $type
 * @return mixed|string
 * 返回图片路径
 */
function get_icon($id = 0,$type=1)
{
    if ($id != 0) {
        $path= \think\Db::table('eacoo_attachment')->where('id', $id)->value('path');
        $path= str_replace("\\",'/',$path);
    } else {
        if ($type ==1){
            $path= \think\Db::table('eacoo_attachment')->where('id', 139)->value('path');//默认图片
            $path= str_replace("\\",'/',$path);
        }else{
            $path='';
        }

    }

    return $path;

}

//经纬度生成器
function send_lat_log($address){

    //$address = I('post.address');
    $result = file_get_contents('http://restapi.amap.com/v3/geocode/geo?key=8bd55b21a9232dc24e65f66c1cde9148&s=rsv3&city=35&address='.$address);
    $res = json_decode($result,true);

    if($res['status'] == 1 && $res['info'] == 'OK' && !empty($res['geocodes'][0]['location'])){

        $jwd = explode(',',$res['geocodes'][0]['location']);

        $code['code'] = 200;
        $code['log'] = $jwd[0]; //经度
        $code['lat'] = $jwd[1];//纬度
        return $code;
        //exit();
    }else{
        $code['code'] = 500;
        $code['content'] = '经纬度解析失败，请检查接口！';
        return $code;
        //exit();
        //exit(json_encode($code));
    }
}

//产生随机用户名
function member_name($length) {
    // 密码字符集，可任意添加你需要的字符
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    $str = '';
    for($i = 0; $i < $length; $i++)
    {
        // 这里提供两种字符获取方式
        // 第一种是使用 substr 截取$chars中的任意一位字符；
        // 第二种是取字符数组 $chars 的任意元素
        $str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
//            $str .= $chars[mt_rand(0, strlen($chars) - 1)];
    }
    return $str;
}

//删除一个路径下的所有目录，和文件
function deldir($path){
    //如果是目录则继续
    if(is_dir($path)){
        //扫描一个文件夹内的所有文件夹和文件并返回数组
        $p = scandir($path);
        foreach($p as $val){
            //排除目录中的.和..
            if($val !="." && $val !=".."){
                //如果是目录则递归子目录，继续操作
                if(is_dir($path.$val)){
                    //子目录中操作删除文件夹和文件
                    deldir($path.$val.'/');
                    //目录清空后删除空文件夹
                    @rmdir($path.$val.'/');
                }else{
                    //如果是文件直接删除
                    unlink($path.$val);
                }
            }
        }
    }
}

//生成xml标注名称，唯一
function set_standard($details_id,$platting_id,$id=1){

    $name='spotname_';

    $standard_name=$name.$id;
    //查询数据库是否有这个名字
    $map['details_id']=array('eq',$details_id);
    $map['plotting_id']=array('eq',$platting_id);
    $map['spotname']=array('eq',$standard_name);
    $standard =db('standard')->where($map)->count();

    if ($standard){
        $id +=$id;
        $standard_name=set_standard($details_id,$platting_id,$id);
    }

    return $standard_name;

}