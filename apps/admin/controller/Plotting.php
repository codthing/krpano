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
 * 展绘
 */
class Plotting extends Admin
{
    protected $plottingModel;

    //protected $groupIds;

    function _initialize()
    {
        parent::_initialize();

        $this->plottingModel = model('Plotting');
    }

    /**
     * 展绘列表
     * @return [type] [description]
     * @date   2018-02-05
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function index()
    {
        //$gap = explode('—', '2019-5-30 09:49:20');
        //查询banner分类
       // $type=db('category')->where('type',1)->where('status',1)->column('id,title');
        return (new Iframe())
            ->setMetaTitle('展绘列表')
            /* ->search([
             /name' => 'position_id', 'type' => 'select', 'title' => '展绘位置', 'options' => $type],
          /*['name' => 'create_time', 'type' => 'daterange', 'extra_attr' => 'placeholder="添加时间"'],

             ['name' => 'title', 'type' => 'text', 'extra_attr' => 'placeholder="请输入广告标题"'],
     ])*/
            ->content($this->grid());

    }

    public function grid()
    {
        $search_setting = $this->buildModelSearchSetting();
        // 获取数据
        $condition['status'] = ['egt', '0']; // 禁用和正常状态
        list($data_list, $total) = $this->plottingModel->search($search_setting)->getListByPage($condition, true, 'create_time asc');

        /*  $reset_password = [
              'icon'         => 'fa fa-recycle',
              'title'        => '重置原始密码',
              'class'        => 'btn btn-default ajax-table-btn confirm btn-sm',
              'confirm-info' => '该操作会重置用户密码为123456，请谨慎操作',
              'href'         => url('reset',['id' => '__data_id__'])
          ];*/
        //解决全选bug
        $html=<<<EOF

        <script type="text/javascript">
            $(function() {              
                 $(".fixed-table-body").on('click','input[name="btSelectAll"]',function() {
                     var _this = $(this);
                     if(_this.hasClass('on')){
                         _this.removeClass('on');
                         $("#builder-table").bootstrapTable('uncheckAll');
                     }else {
                         _this.addClass('on');
                          $("#builder-table").bootstrapTable('checkAll');
                     }
                     
                })  
            })
        </script>
EOF;
        //查询分类
        //$type=db('category')->where('type',1)->where('status',1)->column('id,title');
        return builder('list')
            ->setMetaTitle('展绘列表')// 设置页面标题
            //->addTopButton('addnew')// 添加新增按钮
            ->addTopButton('delete')// 添加删除按钮
            //->addTopButton('self',$reset_password)  // 添加重置按钮
            //->setSearch('custom','请输入ID/用户名/昵称')
            ->setActionUrl(url('grid'))//设置请求地址
            ->keyListItem('id', 'UID')
            ->keyListItem('title', '标题')
            ->keyListItem('member_name', '所属会员')
            //->keyListItem('pid', '所属分类', 'array', $type)
            ->keyListItem('icon', '首图','picture',['width'=>30])
            ->keyListItem('status_text', '状态')
            ->keyListItem('right_button', '操作', 'btn')
            ->setListPrimaryKey('id')
            ->setListData($data_list)// 数据列表
            ->setListPage($total)// 数据列表分页
            ->setExtraHtml($html)
            ->addRightButton('edit')
            ->addRightButton('delete', array('title' => '删除展绘', 'confirm-info' => '你确定要删除展绘吗？', 'href' => url(MODULE_NAME . '/' . CONTROLLER_NAME . '/delete', ['id' => '__data_id__'])))
            ->addRightButton('self', array('title' => '展绘场景列表', 'class' => 'btn btn-info btn-xs', 'href' => url(MODULE_NAME . '/plotting_details/index', ['plotting_id' => '__data_id__'])))
            ->addRightButton('self', array('title' => '新增场景', 'class' => 'btn btn-success btn-xs', 'href' => url(MODULE_NAME . '/plotting_details/add', ['plotting_id' => '__data_id__'])))
            // ->addRightButton('self',$reset_password)
            ->addRightButton('forbid')
            //->addRightButton('forbid')  // 添加编辑按钮
            ->fetch();
    }

    /**
     * 编辑问题
     */
    public function edit($id = 0)
    {
        $title = $id ? "编辑" : "新增";
        if (IS_POST) {
            $data = input('param.');

            $member_id=input('member_id');
            if (!empty($member_id)){
               $data['member_id']=$member_id;

            }
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->plottingModel->editData($data);
            if ($result) {
                $this->success($title . '成功', url('index'));
            } else {
                $this->error($this->plottingModel->getError());
            }
        } else {
            return (new Iframe())
                ->setMetaTitle($title . '展绘')
                ->content($this->form($id));
        }
    }



    //构建表单
    public function form($id = 0)
    {

        // 获取账号信息
        /* if ($id>0) {
             $info = $this->craftsman->get($id);
         }*/

        $info = $this->plottingModel->get($id);
        if(empty($info)){
            $info=[];
        }

        //查询分类
        //$type=db('category')->where('type',1)->where('status',1)->column('id,title');
        $form = builder('Form')
            ->addFormItem('id', 'hidden', 'UID', '')
            //->addFormItem('pid', 'select', '类型', '类型',$type)
            ->addFormItem('title', 'text', '展绘标题','请填写标题')
            ->addFormItem('author', 'text', '展绘作者','请填写作者')
            ->addFormItem('describe', 'textarea', '展绘描述')
            ->addFormItem('icon', 'picture', '展绘首图')
           // ->addFormItem('size', 'text', '建议广告图尺寸','建议广告图尺寸')
            ->addFormItem('status', 'select', '状态', '', [0 => '禁用', 1 => '正常'])
            ->setFormData($info)//->setAjaxSubmit(false)
            ->addButton('submit')
            ->addButton('back')// 设置表单按钮
            ->fetch();

        return $form;
    }


    /**
     * 构建模型搜索查询条件
     * @return [type] [description]
     * @date   2018-09-30
     * @author 心云间、凝听 <981248356@qq.com>
     */
    private function buildModelSearchSetting()
    {
        //时间范围
        $timegap = input('create_time');
        $extend_conditions = [];
        if ($timegap) {
            $gap = explode('—', $timegap);
            $reg_begin = $gap[0];
            $reg_end = $gap[1];

            $extend_conditions = [
                'create_time' => ['between', [strtotime($reg_begin . ' 00:00:00'), strtotime($reg_end . ' 23:59:59')]]
            ];
        }
        //自定义查询条件
        $search_setting = [
            'keyword_condition' => 'id|pid',
            //忽略数据库不存在的字段
            //'ignore_keys' => ['reg_time_range'],
            //扩展的查询条件
            'extend_conditions' => $extend_conditions
        ];

        return $search_setting;
    }



    /**
     * @param int $id
     * @throws \think\Exception
     * @throws \think\exception\PDOExceptions
     * 删除场景
     */
    public function delete($id = 0)
    {
        if ($id == 0) {
            $this->error('没有可操作的数据');
            exit();
        }
        //删除场景
        $rest = Db::table('eacoo_plotting')->where('id', $id)->delete();
        if (false != $rest) {
            $icon= $rest = Db::table('eacoo_plotting_details')->where('plotting_id', $id)->value('icon');
            //删除图片，删除文件
            $url=db('attachment')->where('id',$icon)->value('url');
            $path=explode('.',$url);
            @unlink('.'.$url);
            @deldir('./'.$path[0].'/');

            Db::table('eacoo_plotting_details')->where('plotting_id', $id)->delete();

            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 设置用户的状态
     */
    public function setStatus($model = CONTROLLER_NAME, $script = false)
    {
        $ids = input('param.ids/a');
        /*if (is_array($ids)) {
            if(in_array('1', $ids)) {
                $this->error('超级管理员不允许操作');
            }
        }else{
            if($ids === '1') {
                $this->error('超级管理员不允许操作');
            }
        }*/
        parent::setStatus($model);
    }

}
