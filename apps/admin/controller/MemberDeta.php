<?php
// 用户管理控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 https://www.eacoophp.com, All rights reserved.         
// +----------------------------------------------------------------------
// | [EacooPHP] 并不是自由软件,可免费使用,未经许可不能去掉EacooPHP相关版权。
// | 禁止在EacooPHP整体或任何部分基础上发展任何派生、修改或第三方版本用于重新分发
// +----------------------------------------------------------------------
// | Author:  心云间、凝听 <981248356@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\api\controller\Publics;
use app\common\layout\Iframe;
use app\admin\model\Member as MemberModel;
use think\Db;
use think\Loader;

/**
 * Class Shop
 * @package app\admin\controller
 * 余额管理
 */
class MemberDeta extends Admin
{

    protected $member_deta;
    protected $groupIds;
    protected $id = 2;

    function _initialize()
    {
        parent::_initialize();
        $this->member_deta = model('MemberDeta');

    }

    /**
     * 余额列表
     * @return [type] [description]
     * @date   2018-02-05
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function index()
    {
        $id = input('member_id');
        return (new Iframe())
            ->setMetaTitle('余额列表')
              ->search([
                   ['name' => 'create_time', 'type' => 'daterange', 'extra_attr' => 'placeholder="生成时间"'],
               ])
            ->content($this->grid($id));

    }

    public function grid($id)
    {
        $search_setting = $this->buildModelSearchSetting();
        // 获取数据
        $condition['status'] = ['egt', '0']; // 禁用和正常状态
        $condition['member_id'] = ['eq', $id]; // 禁用和正常状态

        list($data_list, $total) = $this->member_deta->search($search_setting)->getListByPage($condition, true, 'create_time desc');



       //筛选充值消费状态
      foreach ($data_list as $k=>$v){
            if($v['status']==2 && $v['weipay'] !=1){//充值失败不显示
                unset($data_list[$k]);
            }
        }

        return builder('list')
            ->setMetaTitle('余额明细')// 设置页面标题
            ->addTopButton('self', array('title' => '返回', 'class' => 'btn btn-success btn-xs', 'href' => url(MODULE_NAME . '/member/index')))// 添加新增按钮
            ->setActionUrl()//设置请求地址
            ->keyListItem('id', 'UID')
            // ->keyListItem('integral', '绑定手机送积分')
            ->keyListItem('member_name', '会员名称')
            ->keyListItem('create_time', '时间')
            ->keyListItem('price', '价格')
            ->keyListItem('status', '状态', 'array', [1 => '提现', 2 => '充值',3=>'消费'])
            ->setListPrimaryKey('id')
            ->setListData($data_list)// 数据列表
            ->setListPage($total)// 数据列表分页
            ->fetch();
    }

    /**
     * 构建模型搜索查询条件
     * @return [type] [description]
     * @date   2018-09-30
     * @author 心云间、凝听 <981248356@qq.com>
     */
    private function buildModelSearchSetting()
    {

        //$params = $this->request->param();
        $timegap = input('create_time');

        $extend_conditions = [];
        if ($timegap) {
            $gap = explode('—', $timegap);
            $reg_begin = $gap[0];
            $reg_end = $gap[1];

            $extend_conditions = [
                'create_time' => ['between', [strtotime($reg_begin . ' 00:00:00'), strtotime($reg_end . ' 23:59:59')]],
            ];
        }

        //自定义查询条件
        $search_setting = [
            'keyword_condition' => 'member_id|price',
            //忽略数据库不存在的字段
            //'ignore_keys' => ['reg_time_range'],
            //扩展的查询条件
            'extend_conditions' => $extend_conditions
        ];

        return $search_setting;
    }

    /**
     * 设置用户的状态
     */
    public function setStatus($model = CONTROLLER_NAME, $script = false)
    {
        $ids = input('param.ids/a');

        if (!empty($ids)) {
            foreach ($ids as $key => $uid) {
                //清理缓存
                cache('User_info_' . $uid, null);
            }
        }
        parent::setStatus($model);
    }
}
