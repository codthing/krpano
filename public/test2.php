<?php
// 設定台北時區
date_default_timezone_set("Asia/Taipei");

if (isset($_POST['timestamp']) && isset($_POST['salt']) && isset($_POST['json']) ) {

    if ( $_POST['timestamp'] == '' || $_POST['salt'] == '' || $_POST['json'] == '') {
        // 錯誤處理
        echo '參數不得空白';exit;
    }

    // curl
    function curlfunction($url, $data = NULL, $json = false){
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);

        if (!empty($data)) {

            if($json && is_array($data)){

                $data = json_encode( $data );
            }
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);

            if($json){ //發送JSON數據
                curl_setopt($curl, CURLOPT_HEADER, 0);
                curl_setopt($curl, CURLOPT_HTTPHEADER,
                    array('Content-Type: application/json; charset=utf-8', 'Content-Length:' . strlen($data)));
            }
        }

        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $res = curl_exec($curl);
        $errorno = curl_errno($curl);

        if ($errorno) {

            return array('errorno' => false, 'errmsg' => $errorno);
        }
        curl_close($curl);
        return json_decode($res, true);
    }
    // 取得post timestamp
    $timestamp = $_POST['timestamp'];
    // 取得post salt
    $salt = $_POST['salt'];
    // 計算簽章
    $signature = hash('sha256', $timestamp.$salt);
    // 取得json
    $jsonData = $_POST['json'];
    // json decode
    $jsonDecodeData = json_decode($jsonData);

    $data["CompanyID"]= "56607367";
    $data["Timestamp"]= $timestamp;
    $data["Signature"]= $signature;
    $data["Data"]= $jsonDecodeData;

    $data = json_encode($data);

   //$url = "https://teinv.systemlead.com/api/Append/Order";
    $url = "https://webapi.systemlead.com/terpapi/Append/Order";
    //$url = "https://webapi.systemlead.com/terpapi";

    $result = curlfunction($url, $data, true);
} else {
    // 預設值
    $timestamp = time();
    $salt = 'F55F87606C2D4D9EA5AA9AD25350FB80';
    $jsonData = '{"CompanyID":"56607367","InvoiceFor":"C","BuyerID":"0000000000","BuyerName":"BuyerName","BuyerAddress":"TestAddress","BuyerTelNo":"0912345678","BuyerEmail":"1196549990@qq.com","RelateNumber":"","PrintMark":"N","RandomNumber":6740,"SalesAmount":300,"TaxType":"1","TaxAmount":0,"TotalAmount":300,"Details":[{"DetailID":"888","ProductID":"351cecbbcb2177e8aa5a","ProductName":"autocad teaching","Quantity":1,"UnitPrice":300,"SubTotal":300}]}';
}
?>

    <form method="post">
        Timestamp <input type="text" name="timestamp" value="<?php echo $timestamp;?>" style="width:90px;"> <?php echo date("Y-m-d H:i:s", $timestamp);?><br>
        Salt <input type="text" name="salt" value="<?php echo $salt;?>" style="width:260px;"><br><br>
        <textarea name="json" style="width:500px;height:150px;"><?php echo $jsonData;?></textarea><br><br>
        <input type="submit" value="送出"> <a href="/">預設值</a>
    </form>


<?php if(isset($result)) {?>
    回傳資料
    <?php echo '<pre>';print_r($result);echo '</pre>';?>
<?php } ?>