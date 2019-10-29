var vsersion_code = 3;
//var ajaxUrl="http://192.168.0.191:802";
var ajaxUrl="http://gongxiang.59156.cn";
var Interface={
    index:"/app/appindex/index",//首页
    productType:'/app/product/productType',//分类
    product:'/app/product/product',//获取商品
    yzm:'/app/account/yzm',//获取验证码
    register:'/app/account/register',//注册
    login:'/app/account/login',//登录
    three_login:'/app/account/three_login',//三方登录
    forget_pass:'/app/account/forgetPass',//找回/修改密码
    member:'/app/member/index',//个人中心
    edit_mobile:'/app/member/edit_mobile',//修改手机号
    edit_user:'/app/member/edit_user',//修改用户资料
    project_info:'/app/Houser/project_info',//管家服务介绍
    product_details:'/app/product/product_details',//商品详情
    collect:'/app/Product/collect',//添加收藏
    del_collect:'/app/Product/del_collect',//取消收藏
    collect_list:'/app/Product/collect_list',//收藏列表
    car_list:'/app/car/car_list',//购物车列表
    add_car:'/app/car/add_car',//添加购物车
    delete_car:'/app/car/delete_car',//删除购物车
    order_info:'/app/order/order_info',//提交订单
    add_order:'/app/order/add_order',//提交普通订单
    getCoupon_list:'/app/Coupon/coupon_list',//获取能领取的优惠券
    get_coupon:'/app/Coupon/get_coupon',//领取优惠券
    my_coupon:'/app/Coupon/my_coupon',//我的优惠券
    address_list:'/app/address/lists',//收货地址列表
    add_address:'/app/address/add_address',//添加、编辑收货地址
    delete_address:'/app/address/delete_address',//添加、编辑收货地址
    zone_list:'/app/address/zone_list',//省、市、区接口
    zone_details:'/app/address/zone_details',//收货地址详情
    send_price:'/app/order/send_price',//获取运费接口
    pay_orderInfo:'/app/pay/orderInfo',//订单信息
    pay:'/app/pay/pay',//订单支付
    order_list:'/app/order/order_list',//订单列表
    orderDetails:'/app/order/orderDetails',//普通订单详情
    deleteOrder:'/app/order/deleteOrder',//取消普通订单
    sure_accept:'/app/order/sure_accept',//订单确认收货接口
    price_package:'/app/member/price_package',//  我的钱包 和 我的积分明细
    message:'/app/member/message',//我的消息
    addServiceOrder:'/app/Houser/addServiceOrder',//添加管家服务订单
    HouserOrder_list:'/app/Houser/order_list',//管家服务订单列表
    houser_pay:'/app/pay/houser_pay',//管家服务订单 发起支付
    Houser_deleteOrder:'/app/Houser/deleteOrder',//取消管家服务订单
    Houser_sure_accept:'/app/Houser/sure_accept',//管家服务订单 确认收货
    Houser_orderDetails:'/app/Houser/orderDetails',//管家服务订单详情
    order_product:'/app/order/order_product',//根据订单id查询商品详情
    add_comment:'/app/Comment/add_comment',//添加评价
    Scoreproduct:'/app/Score/product',// 积分商品列表
    addScoreOrder:'/app/Score/addScoreOrder',//积分商品兑换 提交订单
    upload:'/app/upload/upload',//上传文件
    default_address:'/app/score/default_address',//默认地址
    apply_reason:'/app/Buyafter/apply_reason',//售后申请原因列表
    add_apply:'/app/Buyafter/add_apply',//添加售后申请
    add_kuaidi:'/app/Buyafter/add_kuaidi',//添加退货快递
    weixin_alipay_payup:'/app/Payup/weixin_alipay_payup',//充值发起支付
    add_payup:'/app/Payup/add_payup',//提交充值订单
    logistics_info:'/app/order/logistics_info',//  订单物流信息
    comment_list:'/app/member/my_comment',//评价列表
    joinTeamOrder:'/app/Teamorder/join_team',//提交平台订单
    spike_list:'/app/product/spike_list',//秒杀活动场次接口
    spike_product:'/app/product/spike_product',//秒杀活动对应的商品
    tab_arr:'/app/Product/tab_arr',//商品标签
    fankui_type:'/app/member/fankui_type',//fankui_type
    fankui_add:'/app/member/fankui_add',//添加意见反馈
    hot_search:'/app/Appindex/hot_search',//热门搜索列表
    edit_three:'/app/member/bang_three',//  绑定QQ、微信
    auth_info:'/app/account/auth_info',//协议
    check_version:'/app/appindex/check_version',//版本更新

};
var uid = $api.getStorage('uid') || "";
//var uid = $api.setStorage('uid',null);
$(function () {
    window['adaptive'].desinWidth = 750;
    window['adaptive'].baseFont = 28;
    window['adaptive'].maxWidth = 750;
    window['adaptive'].init();
    //console.log(window.screen.availWidth);
     $.fn.autoHeight = function(){
        function autoHeight(elem){
            elem.style.height = 'auto';
            elem.scrollTop = 0; //防抖动
            elem.style.height = elem.scrollHeight + 'px';
        }
        this.each(function(){
            autoHeight(this);
            $(this).on('keyup', function(){
                autoHeight(this);
            });
        });
    }
});

//调用接口
function getAjax(url, jsonData,fn,fnError) {
    // console.log(JSON.stringify(jsonData));
    api.ajax({
        url: ajaxUrl + url ,
        method: 'POST',
        data:{body:jsonData},
        headers: {
          "Content-Type": "application/json; charset=utf-8"
        },
    },function(ret, err){
        //console.log(JSON.stringify(ret));
        if (ret) {
            if(ret.code == 200){
                fn(ret);
            }else{
                pop.close();
                //alert(JSON.stringify(ret));
                console.log(ajaxUrl + url);
                console.log(JSON.stringify(jsonData));
                console.log(JSON.stringify(ret));
                if(ret.code==403){  
                    $api.setStorage('token',null);
                    token =null;
                    pop.notice(ret.msg,1.5,function(){
                        historyBack();
                    });
                }else{
                    // alert(ajaxUrl.url + url);
                    // alert(JSON.stringify(err));
                    // alert(JSON.stringify(ret));
                    if(url==Interface.login){//收藏
                        
                    }else{
                        pop.notice(ret.msg);
                    }
                    fnError(ret,err);
                }
            }
        } else {
            pop.close();
            console.log(JSON.stringify(err));
            console.log(JSON.stringify(jsonData));
            console.log(ajaxUrl + url);
            //（err.code0：连接错误、1：超时、2：授权错误、3：数据类型错误、4：不安全的数据）
            var isnull = false;
            var layers = "";
            switch(err.code){
                case 0:
                layers = "网络不给力哦！请稍后重试";
                isnull = true;
                break;
                case 1:
                layers = "连接超时，请稍后重试";
                isnull = true;
                break;
                case 2:
                layers = "授权错误";
                isnull = true;
                break;
                case 4:
                layers = "不安全的数据";
                isnull = true;
                break;
            }
            if(isnull){
                pop.notice(layers);
            }else{
                if(err.code==3){
                    if(url==Interface.join_collect){//收藏
                        if(cnen==1){
                            pop.notice("已经收藏了！");
                        }else{
                            pop.notice("It's already collection！");
                        }
                    }
                }else{
                    pop.notice(err.msg);
                }
                //fnError(err);
            }

        }

    });
}

/*ajax函数调用*/
function getAjax2(url, jsonData,fn,fnError) {
    console.log(ajaxUrl + url);
    $.ajax({
        url:ajaxUrl + url,
        type:"POST",
        data:jsonData,
        dataType:"json",
        async:true,
        timeOut:2000,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Access-Control-Allow-Headers":"Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild",
        },
        success:function(ret){
            if(ret.code == 200){
                fn(ret);
            }else{
                //pop.close();
                //alert(JSON.stringify(ret));
                if(ret.code==403){
                    win.setStorage('token',null);
                    token =null;
                    pop.notice(ret.msg,1.5,function(){
                        historyBack();
                    });
                }else{
                    // alert(ajaxUrl.url + url);
                    console.log(JSON.stringify(err));
                    console.log(JSON.stringify(ret));
                    if(url==Interface.login){//收藏
                        
                    }else{
                        pop.notice(ret.msg);
                    }
                    var err = "";
                    fnError(ret,err);
                }
            }
        },
        error:function(err){
            //pop.close();
            console.log(JSON.stringify(err));
            //（err.code0：连接错误、1：超时、2：授权错误、3：数据类型错误、4：不安全的数据）
            var isnull = false;
            var layers = "";
            switch(err.status){
                case 0:
                layers = "网络不给力哦！请稍后重试";
                isnull = true;
                break;
                case 1:
                layers = "连接超时，请稍后重试";
                isnull = true;
                break;
                case 2:
                layers = "授权错误";
                isnull = true;
                break;
                case 4:
                layers = "不安全的数据";
                isnull = true;
                break;
            }
            if(isnull){
                //pop.notice(layers);
            }else{
                if(err.code==3){
                    if(url==Interface.join_collect){//收藏
                        if(cnen==1){
                            pop.notice("已经收藏了！");
                        }else{
                            pop.notice("It's already collection！");
                        }
                    }
                }else{
                    pop.notice(err.msg);
                }
                //fnError(err);
            }
        },
        complete:function(){
            
        }
    });
}
function getImg(url){
    return ajaxUrl+url;
}
//验证判断
function reg(type,val){
    var regTel=/^[1][3,4,5,7,8][0-9]{9}$/;
    var reEmail = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
    if(type=="regTel"){
        return regTel.test(val);
    }
    if(type=="reEmail"){
        return reEmail.test(val);
    }

}
function isDefine(para) {
    if ( typeof para == "undefined" || para == "" || para == "[]" || para == null || para == undefined) {
        return false;
    } else if(typeof para == "number" || para=="number" ||  para == "null"){
        return true;
    }else if(para==null || para==undefined){
        return true;
    }else{
        for (var o in para) {
            return true;
        }
        return false;
    }
}

function timestampToTime(timestamp,type) {
    //时间戳为10位需*1000，时间戳为13位的话不需乘1000
    //console.log((""+timestamp).length);
    if((""+timestamp).length == 10){
        timestamp *= 1000;
    }
    var date = new Date(timestamp);
    Y = date.getFullYear() + '-';
    M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
    D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
    h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours())+ ':';
    m = (date.getMinutes()< 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
    s = date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds();
    if(type=='yyyy-MM-dd hh:mm:ss'){
        return Y+M+D+h+m+s;
    } else if(type=='yyyy-MM-dd'){
        return Y+M+D;
    } else if(type=='hh:mm:ss'){
        return h+m+s;
    } else if(type=='yyyy-MM-dd hh:mm'){
        m = (date.getMinutes()< 10 ? '0'+date.getMinutes() : date.getMinutes()) ;
        return Y+M+D+h+m;
    }
    return Y+M+D+h+m+s;
}

var pop={
    notice:function(content,time,fn){//content 内容 time 时间 单位秒 fn 消息弹出后执行的方法
        //uexWindow.toast('0', '5', content, time*1000);
        var timeVal=2000;
        if(isDefine(time)){
            timeVal=time*1000;
        }
         //提示
         api.toast({
            msg : content,
            duration:timeVal
        });
        if(fn){
            setTimeout(function(){
                fn();
            },timeVal);
        }

    },
    loading:function(text){
        var title="加载中...";
        var txt ="请稍后...";
        if(isDefine(text)){
            title=text;
        }
        api.showProgress({
            style : 'default',
            animationType : 'fade',
            title: title,
            text:txt,
            modal: true
        });
    },
    close:function(){
        api.hideProgress();
    }
}

function getWare2(item){
    var html = '';
    var waretype = ''
    if(item.tab_title == "热门"){waretype="hot"}else if(item.tab_title == "新品"){waretype="new"}else if(item.tab_title == "精选"){waretype="work"}
    html+='<li onclick="goWare('+item.id+')">';
         html+='<img class="ware_img" src="'+item.imgurl+'" />';
         html+='<div class="ware_details">';
             html+='<div class="ware_name f24"><div class="'+waretype+'">'+item.title+'</div></div>';
             html+='<div class="line_end ware_money">';
                if(item.new_price >= item.old_price){
                    html+='<div class="f24 c-primary">￥<span class="f32 b">'+item.new_price+'</span></div>';
                }else{
                    html+='<div class="f24 c-primary">￥<span class="f32 b">'+item.new_price+'</span></div><del class="f24 c-999 ml10">￥'+item.old_price+'</del>';
                }
             html+='</div>';
             html+='<div class="mt10 between line_center">';
                 html+='<div class="c-999 f24"><span>销量 '+item.sale_num+'</span><span class="ml20">'+item.good_scale+'好评</span></div>';
                 html+='<div class="ware_shop"></div>';
             html+='</div>';
         html+='</div>';
     html+='</li>';
     return html;
}

//弹窗
function maskOpen(){
    $(".mask_pop").addClass("on");
    $(".mask").show();
}

function maskClose(){
    $(".mask_pop").removeClass("on");
    $(".mask").hide();
}

function call(tel){
    console.log(tel);
    api.call({type:'tel_prompt',number:tel});
}

/*功能*/
//获取分类

function ajaxGetClass(id,fun){
    getAjax(Interface.productType,{pid:id},function(res){
        fun(res.data);
    },function(res,err){})

}
//转换json
function jsonp(param){
    return JSON.stringify(param);
}
//验证码倒计时
var zym;
var yzmtime=60;
function yzmsetInterval(){
    yzmtime = Number(yzmtime) - 1;
    var html = "";
    if(yzmtime == 0){
        var html = "获取验证码";
        yzmtime = 60;
        $(".yzm").removeClass("on");
        clearInterval(zym);
    }else{
        var html = yzmtime + "秒后重试";
    }
    $(".yzm").html(html);
}

//获取登录
function getLogin(){
    if($api.getStorage('uid')){
        return true;
    }else{
        return false;
    }
}
//获取优惠券
function coupon_list(item){
    var html ='';
    html+='<li id="cou_'+item.id+'" class="bb pl30 pr30 pt40 pb40 line_center between">';
        html+='<div>';
            html+='<div class="c-primary f44">￥<span class="f60">100</span></div>';
            html+='<p class="mt10 c-999 f24">使用期限至'+timestampToTime(item.end_time,"yyyy-MM-dd")+'</p>';
            html+='<p class="mt15 c-999 f24">'+item.title+'</p>';
            html+='<p class="mt15 c-999 f24">【'+item.type_title+'】</p>';
        html+='</div>';
        html+='<div onclick="getOn('+item.id+')" class="btn btn6 f24 line_center flex_center">领优惠券</div>';
    html+='</li>';
    return html;
}

function getConHtml(item,goList,price){
    console.log(item.manzu);
    var html = '';
    html+='<li class="flex_Box">';
         html+='<div class="cp_left line_center">';
             html+='<div class="">';
                 html+='<div class="c-primary f44 t-c">￥<span class="f60">'+item.val+'</span></div>';
                 html+='<div class="c-999 mt10 f24 t-c">满￥'+item.manzu+'使用</div>';
             html+='</div>';
             html+='<div class="ml30 mr30 cp_dash"></div>';
             html+='<div>';
                html+='<div class="f28">'+item.title+'</div>';
                html+='<div class="f24">【'+item.type_title+'】</div>';
                html+='<div class="f24 c-999 mt15">'+timestampToTime(item.start_time,"yyyy-MM-dd")+' ~ '+timestampToTime(item.end_time,"yyyy-MM-dd")+'</div>';
             html+='</div>';
         html+='</div>';
         if(item.status == 1){
            if(price){
                if(price < item.manzu){
                    html+='<div class="cp_right cp_2 f30 b">未<br/>满<br/>足</div>';  
                }else{
                    html+='<div '+goList+' class="cp_right cp_1 f30 b">立刻<br/>使用</div>';
                }
            }else{
                html+='<div '+goList+' class="cp_right cp_2 f30 b">立刻<br/>使用</div>';                
            }
            
         }else if(item.status == 2){
            html+='<div class="cp_right cp_2 f30 b">已<br/>使<br/>用</div>';
         }else{
            html+='<div class="cp_right cp_2 f30 b">已<br/>过<br/>期</div>';
         }
     html+='</li>';
    return html;
}

//领取优惠券
function get_coupon(id,fn){
    pop.loading();
    getAjax(Interface.get_coupon,{uid:uid,coupon_id:id},function(res){
        pop.close();
        pop.notice(res.msg);
        fn(res);
    },function(res,err){})
}

//支付宝
 function alipay(orderno,gopays){
    var aliPayPlus = api.require('aliPayPlus');
        console.log(orderno);
        aliPayPlus.payOrder({
            orderInfo:orderno
        }, function(ret, err) {
            console.log(jsonp(err));
            console.log(jsonp(ret));
            if (ret.code == 9000) {
                    pop.notice('支付成功');
                    gopays(ret);
                } else {
                    if (ret.code == 6001) {
                        pop.notice('支付已取消');
                    } else {
                        pop.notice('支付失败');
                        console.log('支付失败 code:' + err.code + err.msg);
                    }
                }
        });
}



function wxpay(apiKey,prepay_id,mchId,nonceStr,timeStamp,sign,gopays) {
    console.log('调用微信支付');
    var wxPay = api.require('wxPay');
    var payParam = {
        apiKey: apiKey,
        orderId: prepay_id,
        mchId: mchId,
        nonceStr:nonceStr,
        timeStamp:timeStamp,
        //package: 'Sign=WXPay',
        sign:sign
    };
    console.log(jsonp(payParam));
    wxPay.payOrder(payParam, function(ret, err) {
        //alert(JSON.stringify(ret));
        //alert(JSON.stringify(err));
        if(ret.status) {
            pop.notice('支付成功');
            gopays(ret);
        } else {
            if(err.code == '-2'){
                 pop.notice('取消支付');
            } else {
                pop.notice('支付失败');
            }
        }
    });
}










//上传接口
function upload_file(jsonData,fn,fnError){
        console.log(JSON.stringify(jsonData));
        api.ajax({
            url: ajaxUrl + Interface.upload,
            method: 'post',
            data:{
                values:{type:'picture'},
                files:jsonData         
            },
            // headers: {
            //   "Content-Type": "application/json; charset=utf-8"
            // },
        },function(ret, err){
            console.log(JSON.stringify(ret));
            console.log(JSON.stringify(err));
            if (ret.code==200) {
                fn(ret);
            } else {
                pop.close();
                pop.notice(ret.msg);
            }
        })
    // $.ajax({
    //     url:ajaxUrl + Interface.upload,
    //     data:jsonData,
    //     type:"post",
    //     dataType:'json',
    //     processData:false,
    //     contentType:false,
    //     success:function(res){
    //         console.log(jsonp(res));
    //     },
    //     error:function(err){
    //         console.log(jsonp(err));
    //         alert("未知错误，上传失败");
    //     }
    // })
           
}




//返回首页
function BankIndex() {
    var ci = 0;
    var time1, time2;
    api.addEventListener({
        name : 'keyback'
        }, function(ret, err) {
            if (ci == 0) {
                time1 = new Date().getTime();
                ci = 1;
                api.toast({msg:'再按一次返回键放弃支付'});
            } else if (ci == 1) {
            time2 = new Date().getTime();
            if (time2 - time1 < 3000) {
                openWin('index','index.html')
            } else {
                ci = 0;
                api.toast({msg:'再按一次返回键放弃支付'});
            }
        }
    });
}
//返回首页
var ci = 0;
var time1, time2;
function BankIndexBtn() {
    console.log(ci);
    if (ci == 0) {
        time1 = new Date().getTime();
        ci = 1;
        console.log(ci);
        api.toast({msg:'再按一次返回键放弃支付'});
    } else if (ci == 1) {
        time2 = new Date().getTime();
        if (time2 - time1 < 3000) {
            openWin('index','index.html')
        } else {
            ci = 0;
            api.toast({msg:'再按一次返回键放弃支付'});
        }
    }
}
//退出APP
function ExitApp() {
    var ci = 0;
    var time1, time2;
    api.addEventListener({
        name : 'keyback'
        }, function(ret, err) {
            if (ci == 0) {
                time1 = new Date().getTime();
                ci = 1;
                api.toast({msg:'再按一次返回键退出'});

            } else if (ci == 1) {
            time2 = new Date().getTime();
            if (time2 - time1 < 3000) {
                api.closeWidget({
                    id : api.appId,
                    retData : {
                        name : 'closeWidget'
                    },
                    silent : true
                });
            } else {
                ci = 0;
                api.toast({msg:'再按一次返回键退出'});
            }
        }
    });
}

//获取定位 高德地图
function getGps(){
    var aMap = api.require('aMap');
    aMap.getLocation(function(ret, err) {
        if (ret.status) {
            alert(JSON.stringify(ret));
        } else {
            alert(JSON.stringify(err));
        }
    });
}
//判断是否有权限
function hasPermissions(type){
    var resultList = api.hasPermission({
                list:[type]
            });
    console.log(JSON.stringify(resultList));
    return resultList[0].granted;
}

//相机
function hasPermissions_camas(){
    var has = hasPermissions('camera');
    var has2 = hasPermissions('storage');
    if(has == false){
        api.requestPermission({
            list: ['camera'],
            code: 100001
        }, function(ret, err){
            console.log(JSON.stringify(ret));
            var result = ret.list[0].granted;
            var never = ret.never;
            if (never == true && result == false){
                api.toast({
                        msg:'请在设置中打开相机的使用权限',
                    });
                return false;
            }
            if(result == false){
                return false;
            }
            if(has2 == false){
                api.requestPermission({
                    list: ['storage'],
                    code: 100001
                }, function(ret, err){
                    console.log(JSON.stringify(ret));
                    var result = ret.list[0].granted;
                    var never = ret.never;
                    if (never == true && result == false){
                        api.toast({
                                msg:'请在设置中打开读取存储空间的权限',
                            });
                        return false;
                    }
                    if(result == false){
                         return false;
                    }
                     return true;
                });
            }
        });
    }else{
        if(has2 == false){
            api.requestPermission({
                list: ['storage'],
                code: 100001
            }, function(ret, err){
                console.log(JSON.stringify(ret));
                var result = ret.list[0].granted;
                var never = ret.never;
                if (never == true && result == false){
                    api.toast({
                        msg:'请在设置中打开读取存储空间的权限',
                    });
                    return false;
                }
                if(result == false){
                     return false;
                }
                return true;
            });
        }
    }
    if(has && has2){
        return true;
    }
}

//相机
function hasPermissions_hasPermissions(){
    var has2 = hasPermissions('storage');
    if(has2 == false){
        api.requestPermission({
            list: ['storage'],
            code: 100001
        }, function(ret, err){
            console.log(JSON.stringify(ret));
            var result = ret.list[0].granted;
            var never = ret.never;
            if (never == true && result == false){
                api.toast({
                    msg:'请在设置中打开读取存储空间的权限',
                });
                return false;
            }
            if(result == false){
                 return false;
            }
            return true;
        });
    }
    if(has2){
        return true;
    }
}

function getXiangji(fn){
    //获取一张图片
    api.getPicture({
        sourceType: 'camera',
        encodingType: 'png',
        mediaValue: 'pic',
        allowEdit: false,
        quality: 90,
        saveToPhotoAlbum: true
    }, function(ret, err) {
        if(ret.data==''){return;}
        if (ret) {
            var imgSrc = ret.data;
            if (imgSrc != "") {
                //$api.attr(ele, 'src', imgSrc);
            }
            console.log(imgSrc);
            pop.loading();
            upload_file({image:ret.data},function(res){
                pop.close();
                console.log(jsonp(res));
                fn(res.data);
            });
        }
    });
}

function getStorage(fn){
    //获取一张图片
    api.getPicture({
        sourceType: 'library',
        encodingType: 'png',
        mediaValue: 'pic',
        allowEdit: false,
        quality: 90,
        saveToPhotoAlbum: true
    }, function(ret, err) {
        if(ret.data==''){return;}
        if (ret) {
            var imgSrc = ret.data;
            if (imgSrc != "") {
                //$api.attr(ele, 'src', imgSrc);
            }
            console.log(imgSrc);
            pop.loading();
            upload_file({image:ret.data},function(res){
                pop.close();
                console.log(jsonp(res));
                fn(res.data);
            });
        }
    });
}


//获取版本号
function getversion(fn){
    var platform = 1;
    var sysType = api.systemType;
    if(sysType == 'ios'){
        platform = 2;
    }else if(sysType == 'android'){
        platform = 1;  
    }
    getAjax(Interface.check_version,{platform:platform},function(res){
        //console.log(jsonp(res));
        fn(res);
    },function(res,err){})
}

function anroidDown(url){
    api.download({
        url: url,
        report: true
    }, function(ret, err) {
        if (ret && 0 == ret.state) { /* 下载进度 */
            api.toast({
                msg: Apptypetext8 + ret.percent + "%",
                duration: 2000
            });
        }
        if (ret && 1 == ret.state) { /* 下载完成 */
            var savePath = ret.savePath;
            api.installApp({
                appUri: savePath
            });
        }
    });
}

function iosDown(url){
    api.installApp({
        appUri:url
    });
}