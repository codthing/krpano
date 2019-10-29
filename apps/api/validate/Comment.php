<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/5/20
 * Time: 14:00
 */
namespace app\api\validate;
class Comment extends \think\Validate
{
    protected $rule = [
        'article_id|文章id'  =>  'require',
        'member_id|会员id' =>  'require',
      //  'tel|手机号' =>  'require|max:11|/^1[3-8]{1}[0-9]{9}$/|unique:member',
        'comment|评论'=>'require',

    ];

    //场景验证
    protected $scene = [
        'add'  =>  ['article_id','comment'],
    ];


}