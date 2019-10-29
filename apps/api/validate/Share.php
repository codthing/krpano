<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\api\validate;
class Share extends \think\Validate
{
    protected $rule = [
        'plotting_id|展绘id'  =>  'require',
        //'details_id|展绘详情id' =>  'require',
        'name|分享人姓名' =>  'require',
        'icon_path|分享人头像' =>  'require',
      //  'tel|手机号' =>  'require|max:11|/^1[3-8]{1}[0-9]{9}$/|unique:member',
      //  'comment|评论'=>'require',

    ];

    //场景验证
    protected $scene = [
        'add'  =>  ['article_id','comment'],
    ];


}