<?php

namespace app\api\controller;

use PHPMailer\PHPMailer\PHPMailer;
use app\api\model\Company;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Pdf\Mpdf;
use think\Cache;
use think\cache\driver\Redis;
use think\Controller;
use think\Db;
use think\Loader;
use think\Request;
class Test extends Controller
{


    public function index1(Request $request){
        // $email = $this->post['email'];
        //echo 111;exit();
        //phpinfo();exit();
        $email='1967963174@qq.com';
        //参生一个随机的验证码
        $code = rand(1000, 9999);

        //查询邮件类容
        // $content=Db::name('set')->where('id',1)->value('email_content');
        $content = '當前郵箱驗證碼為:';
        // Cache::set($email.'email_code', $code, 5 * 60);//设置5分钟
        //$rs = Publics::sendMail($email, '郵箱驗證', $content. $code . '（有效期为5分钟）');
        $this->sendMail($email,'邮箱验证码',$content.$code.'（有效期为5分钟）');
    }

    public function sendMail($to, $title, $content, $fujian='')
    {
        //把 SSL/465 改成 TLS/587
        //实例化PHPMailer核心类
        //$mail = new PHPMailer();

        $mail = new PHPMailer();
        $mail -> CharSet='utf-8'; //设置字符集
        //是否启用smtp的debug进行调试 开发环境建议开启 生产环境注释掉即可 默认关闭debug调试模式
        $mail->SMTPDebug = 1;
        //使用smtp鉴权方式发送邮件
        $mail->isSMTP();
        //smtp需要鉴权 这个必须是true
        $mail->SMTPAuth = true;
        //链接qq域名邮箱的服务器地址smtp.qq.com
        $mail->Host = 'smtp.live.com';
        //设置使用ssl加密方式登录鉴权
        //$mail->SMTPSecure = 'ssl';//ssl
        $mail->SMTPSecure = 'STARTTLS';//ssl
        //设置ssl连接smtp服务器的远程服务器端口号，以前的默认是25，但是现在新的好像已经不可用了 可选465或587
        /*POP3服务器 pop.126.com 110
        SMTP服务器 smtp.126.com 25
        IMAP服务器 imap.126.com 143*/
        // $mail->Port = 465;//465
        // $mail->Port = 587;//465
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
        //$mail->addAddress($to, '我的I将');
        $mail->addAddress($to, '我的I将');
        //添加多个收件人 则多次调用方法即可
        // $mail->addAddress('xxx@qq.com','lsgo在线通知');
        //添加该邮件的主题
        $mail->Subject = $title;
        //添加邮件正文 上方将isHTML设置成了true，则可以是完整的html字符串 如：使用file_get_contents函数读取本地的html文件
        $mail->Body = $content;

        //为该邮件添加附件 该方法也有两个参数 第一个参数为附件存放的目录（相对目录、或绝对目录均可） 第二参数为在邮件附件中该附件的名称
        /* if($fujian !=''){
             $mail->addAttachment($fujian, $title.'.pdf');
         }*/

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

    public function index(){

       /* $salesAmount=round(300/1.05,0);
        $TaxAmount=intval($salesAmount *0.05);
        $UnitPrice=round(300/1.05,2);
        $TotalAmount=$salesAmount+$TaxAmount;
        //$salesAmount=round(300/1.05,0);
        dump($TotalAmount);*/
        //查询carrierid是否有效
       /* $header = array('Content-Type: application/json; charset=utf-8','Ocp-Apim-Subscription-Key:78cce4ebd84b4352af4bfe86f0f461f0');
        $jsondata='{"PhoneBarCode":"/N4U4I7Q"}';
        $url='https://webapi.systemlead.com/EInvService/Provide/PhoneBarCodeCheck';
        $result=Publics::httpPostJson($url,$jsondata,$header);
        $res_data=json_decode($result[1],true);
        dump($res_data);exit();*/

        /* $path='./upload_3dpic/2019-10-21\20191021\18605d720c3974e320d272290dae3abe.png';
         $dir=dirname($path);
         dump($dir);*/
     /* $data=[
          ['order_id'=>1],
          ['order_id'=>2],
          ['order_id'=>3],
          ['order_id'=>4],
      ];

      dump(implode(',',array_column($data,'order_id')));*/
    /* $xml=file_get_contents('./tour.xml');
     $xml2=str_replace('<include url="skin/vtourskin.xml" />',"",$xml);
     file_put_contents('./tour2.xml',$xml2);*/


       // $works_string=implode(',',array(2,3));
      //  var_dump($works_string);
       // phpinfo();
    }


    public function get_pdf(Request $request)
    {
        var_dump(1111);exit();
        //require 'PHPExcel/Classes/PHPExcel.php';


       // require 'PHPExcel/Classes/PHPExcel/Writer/Excel5.php'; //非07格式的写出类 ##基础属性设定


        $objPHPExcel = \PHPExcel_IOFactory::load('./static/api/test.xlsx'); //读入指定excel文件

        $objPHPExcel->setActiveSheetIndex(0); //指定活动工作表

        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('宋体');

       // $objPHPExcel->getProperties()->setTitle('xxx'); //单元格编辑

        //$objPHPExcel->getActiveSheet()->setCellValue('A3', 'xxx');

        //设定A3单元格值为xxx ##单元格绘图 

        //$objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing = new \PHPExcel_Worksheet_Drawing();

        //$objDrawing->setPath('a.jpg');

        //指定图片路径。若要远程图片需PHPExcel/Classes/PHPExcel/Worksheet/Drawing.php:106处file_exists换成file_get_contents

        $objDrawing->setCoordinates('A4'); //指定在A4单元格绘图

        $objDrawing->setName('Photo');

        $objDrawing->setDescription('Photo');

        $objDrawing->setHeight(120);

        $objDrawing->setWidth(100);

        $objDrawing->setOffsetX(7);

        $objDrawing->setOffsetY(7);

        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet());

        $filename = './static/a.pdf';

        $encoded_filename = rawurlencode($filename);

        //$rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
        $rendererName = \PHPExcel_Settings::PDF_RENDERER_MPDF;



        //指定通过mpdf类库导出pdf文件 

        //$rendererLibraryPath = VENDOR_PATH.'/mpdf/mpdf/src';
        $rendererLibraryPath = 'PHPExcel/MPDF60';
        //$rendererLibraryPath = 'Mpdf';

            //指定你下载的mpdf类库路径 
        if (!\PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
            die('Please set the $rendererName and $rendererLibraryPath values' . PHP_EOL . 'as appropriate for your     directory structure');
        }

        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'PDF');
        $objWriter->setSheetIndex(0);
        $objWriter->save($filename);


    }

    public function test(){
       // phpinfo();
       /* $reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
        $spreadsheet = $reader->load("./static/api/test.xlsx");
        //$spreadsheet->removeSheetByIndex(0);
        $writer = new \PhpOffice\PhpSpreadsheet\Writer\Html($spreadsheet);
        $writer->writeAllSheets();
        $writer->setPreCalculateFormulas(true);//计算公式
        //$writer->setOffice2003Compatibility(true);//兼容老版本
       // $writer->setSheetIndex(1);
        $writer->save("./static/05featuredemo.html");*/
        $data=file_get_contents('./static/yulan.html');
        $this->pdf($data,'测试','cheshi');

    }

    public function test2(){
        $reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
        $spreadsheet = $reader->load("./static/api/test.xlsx");
        $writer = new \PhpOffice\PhpSpreadsheet\Writer\Pdf\Dompdf($spreadsheet);
        $writer->writeAllSheets();
        $writer->save("./static/05featuredemo.pdf");

    }

    public function pdf($html=array(),$title="标题",$fileName=""){
        //$fileName = time();
        //vendor('tcpdf.tcpdf'); //导入TCPDF类
        /* $pdf = new \Tcpdf(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);*/
        $pdf =new \TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
        // 设置打印模式
        //设置文件信息，头部的信息设置
        $pdf->SetCreator(PDF_CREATOR);
        $pdf->SetAuthor("作者");
        $pdf->SetTitle($title);
        $pdf->SetSubject('TCPDF Tutorial');
        $pdf->SetKeywords('TCPDF, PDF, example, test, guide');//设置关键字
        // 是否显示页眉
        $pdf->setPrintHeader(false);
        // 设置页眉显示的内容
        $pdf->SetHeaderData('logo.png', 60, 'baijunyao.com', '', array(0,64,255), array(0,64,128));
        // 设置页眉字体
        $pdf->setHeaderFont(Array('deja2vusans', '', '12'));
        // 页眉距离顶部的距离
        $pdf->SetHeaderMargin('5');
        // 是否显示页脚
        $pdf->setPrintFooter(true);
        // 设置页脚显示的内容
        $pdf->setFooterData(array(0,64,0), array(0,64,128));
        // 设置页脚的字体
        $pdf->setFooterFont(Array('dejavusans', '', '10'));
        // 设置页脚距离底部的距离
        $pdf->SetFooterMargin('10');
        // 设置默认等宽字体
        $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        // 设置行高
        $pdf->setCellHeightRatio(1);
        // 设置左、上、右的间距
        $pdf->SetMargins('10', '10', '10');
        // 设置是否自动分页  距离底部多少距离时分页
        $pdf->SetAutoPageBreak(TRUE, '15');
        // 设置图像比例因子
        /* $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
         if (@file_exists(dirname(__FILE__).'/lang/eng.php')) {
             require_once(dirname(__FILE__).'/lang/eng.php');
             $pdf->setLanguageArray($l);
         }*/
        $pdf->setFontSubsetting(true);
        $pdf->AddPage("A4","Landscape",true,true);
        // 设置字体
        $pdf->SetFont('stsongstdlight', '', 14, '', true);

        $pdf->writeHTML($html);//HTML生成PDF
        //$pdf->writeHTMLCell(0, 0, '', '', $html, 0, 1, 0, true, '', true);
        $showType= 'D';//PDF输出的方式。I，在浏览器中打开；D，以文件形式下载；F，保存到服务器中；S，以字符串形式输出；E：以邮件的附件输出。
        $pdf->Output("{$fileName}.pdf", $showType);

    }

    public function printPdf(){
        header("Content-type: text/html; charset=utf-8");

        $this->assign('title','下载文件');
        //$id = I('id');
       /* if(!$id || !is_numeric($id)){
            $this->error('参数丢失');
        }else{*/

            //产品详情
           // $list = M("product")->where('status in(1,-1,-2) and id='.intval($id))->find();
          /*  if($list){
                //获取行程安排
                $xcap = M('product_plan')->where('pro_id='.intval($id))->select();

                //html解码
                $list['pic'] = 'http://'.$_SERVER['HTTP_HOST'].'/'.$list['pic'];
                $list['detail'] = htmlspecialchars_decode($list['detail']);
                $list['fee_desc'] = htmlspecialchars_decode($list['fee_desc']);
                $list['notice'] = htmlspecialchars_decode($list['notice']);
                $list['shopping_notice'] = htmlspecialchars_decode($list['shopping_notice']);
                $list['before_buy'] = htmlspecialchars_decode($list['before_buy']);
            }else{
                $list = array();
                $xcap = array(array());
            }
            $this->assign('_list',$list);
            $this->assign('_xcap',$xcap);*/


            //执行pdf文件生成
          //  include_once  C('S_ROOT').'/../MPDF/MPDF60/mpdf.php'; //实际路径 /www/项目名/Application/../MPDF/MPDF60/mpdf.php
            //实例化mpdf
            //vendor('mpdf.mpdf.src.Mpdf');
            $mpdf=new \Mpdf\Mpdf();

            //设置字体,解决中文乱码,前提是：修改MPDF/MPDF60/config.php中autoScriptToLang 和 autoLangToFont 均为true
            $mpdf->useAdobeCJK = true;
            //$mpdf->SetAutoFont(AUTOFONT_ALL);//使用6.0以上版本不需要

//             $mpdf=new \mPDF('+aCJK','A4','','',32,25,27,25,16,13);
//             $mpdf->autoLangToFont = true;
//             $mpdf->useAdobeCJK = true;
            //获取要生成的静态文件
            $html=$this->fetch('Test/testss');
            //$html = '中国';

            //echo $html;exit;


            //设置PDF页眉内容
           /* $header='<table width="95%" style="margin:0 auto;border-bottom: 1px solid #4F81BD; vertical-align: middle; font-family:
serif; font-size: 9pt; color: #000088;"><tr>
<td width="10%"></td>
<td width="80%" align="center" style="font-size:16px;color:#A0A0A0"></td>
<td width="10%" style="text-align: right;"></td>
</tr></table>';*/

            //设置PDF页脚内容
            $footer='<table width="100%" style=" vertical-align: bottom; font-family:
serif; font-size: 9pt; color: #000088;"><tr style="height:30px"></tr><tr>
<td width="10%"></td>
<td width="80%" align="center" style="font-size:14px;color:#A0A0A0"></td>
<td width="10%" style="text-align: left;">页码：1/1</td>
</tr></table>';

            //添加页眉和页脚到pdf中
            //$mpdf->SetHTMLHeader($header);
            $mpdf->SetHTMLFooter($footer);

            //设置pdf显示方式
            //$mpdf->SetDisplayMode('fullpage');
            $mpdf->SetDisplayMode('fullpage');

            //设置pdf的尺寸为270mm*397mm
            //$mpdf->WriteHTML('<pagebreak sheet-size="270mm 397mm" />');

            //创建pdf文件
            //$mpdf->WriteHTML($html);
            $mpdf->WriteHTML($html);

           // $mpdf->AddPage();
            //删除pdf第一页(由于设置pdf尺寸导致多出了一页)
            //$mpdf->DeletePages(1,1);

            //输出pdf
            $mpdf->Output('./static/tests.pdf','F');//可以写成下载此pdf   $mpdf->Output('文件名','D');

            exit;

        }
   /* }*/

   public function texthtml(){
       $offer_id=input('offer_id');
       $model=new \app\api\model\Offer();
       $res = $model->get_data($offer_id);//获取excel数据
       //获取要生成的静态文件
       //$this->assign('res',$res);
      return $this->fetch('Offer/get_pdf',compact('res'));

   }

   public function textxml(){

        $data=[
            'appid'=>'wx41346e9474c86b91',
            'attach'=>'测试',
            'body'=>'测试2',
            'mch_id'=>'1501658541',
            'nonce_str'=>'09mm1a03ux5knvix3m7sexvnw8s6gdzc',
            'notify_url'=>'http://hhjq.zz300.cn/Web/Pay/notify',
            'openid'=>'oyWXC1DgZT1sxR1llYJJkNPrvmYk',
            'out_trade_no'=>'688414432',
            'spbill_create_ip'=>'123.147.246.113',
            'time_expire'=>'20190620182706',
            'time_start'=>'20190620181706',
            'total_fee'=>0,
            'trade_type'=>'JSAPI',
            'sign'=>'46C45DAEE4831FBD0F60679D325E5DC7',
        ];
           $xml = '<xml>';
           foreach ($data as $key=>$val)
           {
               if (is_numeric($val)){
                   $xml.="<".$key.">".$val."</".$key.">";
               }else{
                   $xml.="<".$key."><![CDATA[".$val."]]></".$key.">";
               }
           }
           $xml.='</xml>';
           var_dump($xml);exit();

   }


   public function addrs(Request $request){
       $a = '{"台北市":["100中正區","103大同區","104中山區","105松山區","106大安區","108萬華區","110信義區","111士林區","112北投區","114內湖區","115南港區","116文山區"],"基隆市":["200仁愛區","201信義區","202中正區","203中山區","204安樂區","205暖暖區","206七堵區"],"新北市":["207萬里區","208金山區","220板橋區","221汐止區","222深坑區","223石碇區","224瑞芳區","226平溪區","227雙溪區","228貢寮區","231新店區","232坪林區","233烏來區","234永和區","235中和區","236土城區","237三峽區","238樹林區","239鶯歌區","241三重區","242新莊區","243泰山區","244林口區","247蘆洲區","248五股區","248新莊區","249八里區","251淡水區","252三芝區","253石門區"],"連江縣":["209南竿鄉","210北竿鄉","211莒光鄉","212東引鄉"],"宜蘭縣":["260宜蘭市","260壯圍鄉","261頭城鎮","262礁溪鄉","263壯圍鄉","264員山鄉","265羅東鎮","266三星鄉","267大同鄉","268五結鄉","269冬山鄉","270蘇澳鎮","272南澳鄉"],"新竹市":["300東區","300北區","300香山區"],"新竹縣":["300寶山鄉","302竹北市","303湖口鄉","304新豐鄉","305新埔鎮","306關西鎮","307芎林鄉","308寶山鄉","310竹東鎮","311五峰鄉","312橫山鄉","313尖石鄉","314北埔鄉","315峨眉鄉"],"桃園縣":["320中壢市","324平鎮市","325龍潭鄉","326楊梅市","327新屋鄉","328觀音鄉","330桃園市","333龜山鄉","334八德市","335大溪鎮","336復興鄉","337大園鄉","338蘆竹鄉"],"苗栗縣":["350竹南鎮","351頭份鎮","352三灣鄉","353南庄鄉","354獅潭鄉","356後龍鎮","357通霄鎮","358苑裡鎮","360苗栗市","361造橋鄉","362頭屋鄉","363公館鄉","364大湖鄉","365泰安鄉","366銅鑼鄉","367三義鄉","368西湖鄉","369卓蘭鎮"],"台中市":["400中區","401東區","402南區","403西區","404北區","406北屯區","407西屯區","408南屯區","411太平區","412大里區","413霧峰區","414烏日區","420豐原區","421后里區","422石岡區","423東勢區","424和平區","426新社區","427潭子區","428大雅區","429神岡區","432大肚區","433沙鹿區","433龍井區","434龍井區","435梧棲區","436清水區","437大甲區","438外埔區","439大安區"],"彰化縣":["500彰化市","502芬園鄉","503花壇鄉","504秀水鄉","505鹿港鎮","506福興鄉","507線西鄉","508和美鎮","509伸港鄉","510員林鎮","511社頭鄉","512永靖鄉","513埔心鄉","514溪湖鎮","515大村鄉","516埔鹽鄉","520田中鎮","521北斗鎮","522田尾鄉","523埤頭鄉","524溪州鄉","525竹塘鄉","526二林鎮","527大城鄉","528芳苑鄉","530二水鄉"],"南投縣":["540南投市","541中寮鄉","542草屯鎮","544國姓鄉","545埔里鎮","546仁愛鄉","551名間鄉","552集集鎮","553水里鄉","555魚池鄉","556信義鄉","557竹山鎮","558鹿谷鄉"],"嘉義市":["600西區","600東區"],"嘉義縣":["602番路鄉","603梅山鄉","604竹崎鄉","605阿里山鄉","606中埔鄉","607大埔鄉","608水上鄉","611鹿草鄉","612太保市","613朴子市","614東石鄉","615六腳鄉","616新港鄉","621民雄鄉","622大林鎮","623溪口鄉","624義竹鄉","625布袋鎮"],"雲林縣":["630斗南鎮","631大埤鄉","632虎尾鎮","633土庫鎮","634褒忠鄉","635東勢鄉","636台西鄉","637崙背鄉","638麥寮鄉","640斗六市","643林內鄉","646古坑鄉","647莿桐鄉","648西螺鎮","649二崙鄉","651北港鎮","652水林鄉","653口湖鄉","654四湖鄉","655元長鄉"],"台南市":["700中西區","701東區","702南區","704北區","708安平區","709安南區","710永康區","711歸仁區","712新化區","713左鎮區","714玉井區","715楠西區","716南化區","717仁德區","718關廟區","719龍崎區","720官田區","721麻豆區","722佳里區","723西港區","724七股區","725將軍區","726學甲區","727北門區","730新營區","731後壁區","732白河區","733東山區","734六甲區","735下營區","736柳營區","737鹽水區","741善化區","741新市區","742大內區","743山上區","744新市區","745安定區"],"高雄市":["800新興區","801前金區","802苓雅區","803鹽埕區","804鼓山區","805旗津區","806前鎮區","807三民區","811楠梓區","812小港區","813左營區","814仁武區","815大社區","817東沙群島","819南沙群島","820岡山區","821路竹區","822阿蓮區","823田寮區","824燕巢區","825橋頭區","826梓官區","827彌陀區","828永安區","829湖內區","830鳳山區","831大寮區","832林園區","833鳥松區","840大樹區","842旗山區","843美濃區","844六龜區","845內門區","846杉林區","847甲仙區","848桃源區","849那瑪夏區","851茂林區","852茄萣區"],"南海島":["817東沙群島","819南沙群島"],"澎湖縣":["880馬公市","881西嶼鄉","882望安鄉","883七美鄉","884白沙鄉","885湖西鄉"],"金門縣":["890金沙鎮","891金湖鎮","892金寧鄉","893金城鎮","894烈嶼鄉","896烏坵鄉"],"屏東縣":["900屏東市","901三地門鄉","902霧台鄉","903瑪家鄉","904九如鄉","905里港鄉","906高樹鄉","907鹽埔鄉","908長治鄉","909麟洛鄉","911竹田鄉","912內埔鄉","913萬丹鄉","920潮州鎮","921泰武鄉","922來義鄉","923萬巒鄉","924崁頂鄉","925新埤鄉","926南州鄉","927林邊鄉","928東港鎮","929琉球鄉","931佳冬鄉","932新園鄉","940枋寮鄉","941枋山鄉","942春日鄉","943獅子鄉","944車城鄉","945牡丹鄉","946恆春鎮","947滿州鄉"],"台東縣":["950台東市","951綠島鄉","952蘭嶼鄉","953延平鄉","954卑南鄉","955鹿野鄉","956關山鎮","957海端鄉","958池上鄉","959東河鄉","961成功鎮","962長濱鄉","963太麻里鄉","964金峰鄉","965大武鄉","966達仁鄉"],"花蓮縣":["970花蓮市","971新城鄉","972秀林鄉","973吉安鄉","974壽豐鄉","975鳳林鎮","976光復鄉","977豐濱鄉","978瑞穗鄉","979萬榮鄉","981玉里鎮","982卓溪鄉","983富里鄉"]}';

        $a=preg_replace("/\\d+/",'', $a);
        $a=json_decode($a);
        $i=0;
        foreach ($a as $kk=>$vv){
            $data[$i]['name']=$kk;
            $i++;
        }
        Db::name('taiwan')->insertAll($data);
        $addrs=Db::table('eacoo_taiwan')->select();
        foreach ($addrs as $k1=>$v1){
           foreach ($a as $k2=>$v2){
               if($v1['name'] == $k2){
                   foreach ($v2 as $k3=>$v3){
                       //$s[$k3]=array('pid'=>$v1['id'],'name'=>$v3);
                       Db::table('eacoo_taiwan')->insert(array('pid'=>$v1['id'],'name'=>$v3));
                   }
                   //var_dump($s);
                   //Db::name('taiwan')->insertAll($s);
               }
           }
        }

   }

   public function tes(){
       /*$data='18160,76212,103215,39369,10591,10236,101844,73952,11959,92272,63049,81969,13311,80881,60485,60795,61910,93346,56716,93575,103385,42506,3727,41835,103257,83251,41100,62225,62919,103609,64197,95827,92773,35753';
       $array=explode(',',$data);

       if (count($array) != count(array_unique($array))) {
           echo '该数组有重复值';
       }else{
           echo count($array);
       }*/
       $test=new Pinyin();
        $data=$test->tradition2simple('伐崩癳眀腹盞絏
');
        var_dump($data);



   }


   //测试redis
   public function rediss(){


      // phpinfo();
       $redis=new Redis();
       $redis->set('name','小王');


   }
   public function rr(){
       $redis=new Redis();
       echo $redis->get('name');
   }
   public function suo(){

       $file = fopen(__DIR__.'/adorder.txt','w+');
       //加锁
       if(flock($file,LOCK_EX|LOCK_NB)){
           echo 111;
           sleep(3);
           //TODO 执行业务代码
         //  flock($file,LOCK_UN);//解锁
       }else{
           echo 22;
           //TODO 执行业务代码 返回系统繁忙等错误提示
       }
       //关闭文件
      // fclose($file);


   }



}
