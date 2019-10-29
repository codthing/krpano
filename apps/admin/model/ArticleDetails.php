<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/18
 * Time: 17:06
 */

namespace app\admin\model;

use app\api\controller\Publics;
use app\common\model\Base;
use think\Db;

class ArticleDetails extends Base
{
    protected $table='eacoo_article_details';
    protected $autoWriteTimestamp = true;



}