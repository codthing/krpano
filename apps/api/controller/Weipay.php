<?php

namespace app\api\controller;

use app\api\model\Commission;
use app\api\model\Company;
use app\api\model\MemberDetailed;
use app\api\model\Point;
use think\Cache;
use think\Controller;
use think\Db;
use think\Exception;
use think\Loader;
use think\Request;

class Weipay extends Controller
{


    /**
     * @param $price @价格
     * @param $openid @微信openid
     * @param $code @订单编号
     * @param $notify_url @回调地址
     * @return mixed @返回信息
     * 微信支付
     */
    public  function weixin($price,$openid,$code,$notify_url)
    {
        $appid = "wx7bd6aaa05d934b88";//如果是公众号 就是公众号的appid
        $mch_id = "1537765831";//商户号

      //  $notify_url = 'https://xiaofang.59156.cn/api/pay/notiy';//回调地址

        $body = '天御消防';
        $nonce_str = $this->nonce_str();//随机字符串
        $out_trade_no = $code;//充值订单号
        $spbill_create_ip = get_client_ip();//获取客户端ip
        $total_fee = $price * 100;//因为充值金额最小是1 而且单位为分 如果是充值1元所以这里需要*100
        //$total_fee = 1*10;
        $trade_type = 'JSAPI';//交易类型 默认

        //这里是按照顺序的 因为下面的签名是按照顺序 排序错误 肯定出错
        $postData['appid'] = $appid;
        $postData['body'] = $body;
        $postData['mch_id'] = $mch_id;
        $postData['nonce_str'] = $nonce_str;//随机字符串
        $postData['notify_url'] = $notify_url;
        $postData['openid'] = $openid;
        $postData['out_trade_no'] = $out_trade_no;
        $postData['spbill_create_ip'] = $spbill_create_ip;//终端的ip
        $postData['total_fee'] = $total_fee;//总金额 最低为一块钱 必须是整数
        $postData['trade_type'] = $trade_type;
        $sign = $this->sign($postData);//签名
        $post_xml = '<xml>
                     <appid>' . $appid . '</appid>
                     <body>' . $body . '</body>
                     <mch_id>' . $mch_id . '</mch_id>
                     <nonce_str>' . $nonce_str . '</nonce_str>
                     <notify_url>' . $notify_url . '</notify_url>
                     <openid>' . $openid . '</openid>
                     <out_trade_no>' . $out_trade_no . '</out_trade_no>
                     <spbill_create_ip>' . $spbill_create_ip . '</spbill_create_ip>
                     <total_fee>' . $total_fee . '</total_fee>
                     <trade_type>' . $trade_type . '</trade_type>
                     <sign>' . $sign . '</sign>
                  </xml> ';


        //统一接口prepay_id
        $url = 'https://api.mch.weixin.qq.com/pay/unifiedorder';
        $xml = $this->http_request($url, $post_xml);
        $array = $this->xml($xml);//全要大写


        if ($array['RETURN_CODE'] == 'SUCCESS' && $array['RESULT_CODE'] == 'SUCCESS') {
            $time = time();
            $tmp = '';//临时数组用于签名
            $tmp['appId'] = $appid;
            $tmp['nonceStr'] = $nonce_str;
            $tmp['package'] = 'prepay_id=' . $array['PREPAY_ID'];
            $tmp['signType'] = 'MD5';
            $tmp['timeStamp'] = "$time";

            $data['code'] = 200;
            $data['timeStamp'] = "$time";//时间戳
            $data['nonceStr'] = $nonce_str;//随机字符串
            $data['signType'] = 'MD5';//签名算法，暂支持 MD5
            $data['package'] = 'prepay_id=' . $array['PREPAY_ID'];//统一下单接口返回的 prepay_id 参数值，提交格式如：prepay_id=*
            $data['paySign'] = $this->sign($tmp);//签名,具体签名方案参见微信公众号支付帮助文档;
            $data['out_trade_no'] = $out_trade_no;

        } else {
            $data['code'] = 201;
            $data['text'] = "错误";
            $data['RETURN_MSG'] = $array;
        }
       //json_encode($data);
        return $data;

    }

    /**
     * @param $data
     * @return string
     * 生成签名
     */
    public function sign($data)
    {
        $stringA = '';
        foreach ($data as $key => $value) {
            if (!$value) continue;
            if ($stringA) $stringA .= '&' . $key . "=" . $value;
            else $stringA = $key . "=" . $value;
        }
        $wx_key = 'grYBqZsA47PiQ8c2iEN64u2LmnUeGd24';//申请支付后有给予一个商户账号和密码，登陆后自己设置key

        $stringSignTemp = $stringA . '&key=' . $wx_key;//申请支付后有给予一个商户账号和密码，登陆后自己设置key

        return strtoupper(md5($stringSignTemp));
    }


    //随机32位字符串
    public function nonce_str()
    {
        $result = '';
        $str = 'QWERTYUIOPASDFGHJKLZXVBNMqwertyuioplkjhgfdsamnbvcxz';
        for ($i = 0; $i < 32; $i++) {
            $result .= $str[rand(0, 48)];
        }
        return $result;
    }


    /**
     * @param $xml
     * @return string
     * 获取xml
     */
    public function xml($xml)
    {
        $p = xml_parser_create();
        xml_parse_into_struct($p, $xml, $vals, $index);
        xml_parser_free($p);
        $data = "";
        foreach ($index as $key => $value) {
            if ($key == 'xml' || $key == 'XML') continue;
            $tag = $vals[$value[0]]['tag'];
            $value = $vals[$value[0]]['value'];
            $data[$tag] = $value;
        }
        return $data;
    }

    /**
     * @param $url
     * @param null $data
     * @param array $headers
     * @return mixed
     * cul请求     *
     */
    public function http_request($url, $data = null, $headers = array())
    {
        $curl = curl_init();
        if (count($headers) >= 1) {
            curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        }
        curl_setopt($curl, CURLOPT_URL, $url);

        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);

        if (!empty($data)) {
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        }
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($curl);
        curl_close($curl);
        return $output;
    }


    /**
     * @return string
     * @throws Exception
     * @throws \think\exception\PDOException
     * 微信订单支付回调
     */
    public function notiy(){
        $list = file_get_contents('php://input');

        //file_put_contents('wx1234.txt', $list);
        $postObj = simplexml_load_string($list, 'SimpleXMLElement', LIBXML_NOCDATA);
        //file_put_contents('wx1234.txt', $postObj->result_code . '--' . $postObj->out_trade_no);

        if ($postObj->result_code == 'SUCCESS') {
            $code = $postObj->out_trade_no;
            $time = time();
            $res =Db::table('eacoo_offer')->where('code',$code)->update(array('status'=>2));
            //file_put_contents('sql.txt',Db::table('eacoo_offer')->getLastSql());

            if(false !=$res){
                //获取会员id
                $member_id=Db::table('eacoo_offer')->where('code',$code)->value('member_id');
                //获取会员
                $member=Db::table('eacoo_member')->where('id',$member_id)->find();
                if ($member['pid'] !=0){
                    //获取佣金
                    $set = Db::table('eacoo_set')->where('id', 1)->find();//查询价格
                    //拼凑佣金数据
                    $coms['member_id']=$member['pid'];//上级id
                    $coms['lower_id']=$member_id;//下级id
                    $coms['commission']=$set['commission'];//每单佣金
                    $coms['consumption']=$set['price'];//消费多少
                    $coms['nickname']=$member['name'];//消费会员名称
                    $commisi=new Commission();
                    $commisi->allowField(true)->save($coms);
                }
                return 'success';
            }else{
                return 'false';
            }
        }
    }

    /**
     * @return string
     * @throws Exception
     * @throws \think\exception\PDOException
     * 余额充值回调
     */
    public function recharge(){
        $list = file_get_contents('php://input');
       // file_put_contents('wx1234.txt', $list);
        $postObj = simplexml_load_string($list, 'SimpleXMLElement', LIBXML_NOCDATA);
       // file_put_contents('wx1234.txt', $postObj->result_code . '--' . $postObj->out_trade_no);

        if ($postObj->result_code == 'SUCCESS') {
            $code = $postObj->out_trade_no;
           // $time = time();
            //$res =Db::table('eacoo_member_detailed')->where('id',$code)->update(array('weipay'=>1));
           // $db2=new MemberDetailed();
            //$med=$db2->where('id',$code)->find();
            $med=Db::table('eacoo_member_detailed')->where('code',$code)->find();
            if($med){
                //会员余额增加
                //$db=new \app\api\model\Member();
                //$member=$db->where('id',$med->member_id)->find();
                $member=Db::table('eacoo_member')->where('id',$med['member_id'])->find();
                Db::table('eacoo_member')->where('id',$med['member_id'])->update(['balance'=>$med['price']+$member['balance']]);

                Db::table('eacoo_member_detailed')->where('code',$code)->update(['weipay'=>1]);
                //$member->balance = $member->balance + $med->price;

              /*  $med->weipay=1;//修改微信支付状态
                $med->save();
                $member->save();*/
                return 'success';
            }else{
                return 'false';
            }
        }
    }

    /**
     * @return string
     * @throws Exception
     * @throws \think\exception\PDOException
     * 积分充值回调
     */
    public function point(){
        $list = file_get_contents('php://input');
        // file_put_contents('wx1234.txt', $list);
        $postObj = simplexml_load_string($list, 'SimpleXMLElement', LIBXML_NOCDATA);
        // file_put_contents('wx1234.txt', $postObj->result_code . '--' . $postObj->out_trade_no);

        if ($postObj->result_code == 'SUCCESS') {
            $code = $postObj->out_trade_no;
            // $time = time();
            //$res =Db::table('eacoo_member_detailed')->where('id',$code)->update(array('weipay'=>1));
            // $db2=new MemberDetailed();
            //$med=$db2->where('id',$code)->find();
            $med=Db::table('eacoo_point')->where('code',$code)->find();
            if($med){
                //会员余额增加
                //$db=new \app\api\model\Member();
                //$member=$db->where('id',$med->member_id)->find();
                $member=Db::table('eacoo_member')->where('id',$med['member_id'])->find();
                Db::table('eacoo_member')->where('id',$med['member_id'])->update(['integral'=>$med['integral']+$member['integral']]);

                Db::table('eacoo_point')->where('code',$code)->update(['weipay'=>1]);
                //$member->balance = $member->balance + $med->price;

                /*  $med->weipay=1;//修改微信支付状态
                  $med->save();
                  $member->save();*/
                return 'success';
            }else{
                return 'false';
            }
        }
    }
}
