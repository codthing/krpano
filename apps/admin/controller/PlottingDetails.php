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
use think\Request;

/**
 * Class Shop
 * @package app\admin\controller
 * 展绘
 */
class PlottingDetails extends Admin
{
    protected $plottingDetailsModel;

    //protected $groupIds;

    function _initialize()
    {
        parent::_initialize();

        $this->plottingDetailsModel = model('PlottingDetails');
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
        $type=db('category')->where('type',1)->where('status',1)->column('id,title');
        return (new Iframe())
            ->setMetaTitle('展绘全景列表')
             ->search([
             ['name' => 'category_id', 'type' => 'select', 'title' => '展绘分类', 'options' => $type],
             /*['name' => 'create_time', 'type' => 'daterange', 'extra_attr' => 'placeholder="添加时间"'],

             ['name' => 'title', 'type' => 'text', 'extra_attr' => 'placeholder="请输入广告标题"'],*/
     ])
            ->content($this->grid());

    }

    public function grid()
    {
        $search_setting = $this->buildModelSearchSetting();
        // 获取数据
        $condition['status'] = ['egt', '0']; // 禁用和正常状态
        list($data_list, $total) = $this->plottingDetailsModel->search($search_setting)->getListByPage($condition, true, 'create_time asc');

        /*  $reset_password = [
              'icon'         => 'fa fa-recycle',
              'title'        => '重置原始密码',
              'class'        => 'btn btn-default ajax-table-btn confirm btn-sm',
              'confirm-info' => '该操作会重置用户密码为123456，请谨慎操作',
              'href'         => url('reset',['id' => '__data_id__'])
          ];*/

        //查询分类
        $type=db('category')->where('type',1)->where('status',1)->column('id,title');
        return builder('list')
            ->setMetaTitle('展绘场景列表')// 设置页面标题
            //->addTopButton('addnew')// 添加新增按钮
            ->addTopButton('self', array('title' => '返回', 'class' => 'btn btn-success btn-sm', 'href' => url(MODULE_NAME . '/plotting/index')))// 添加返回按钮
            ->addTopButton('delete')// 添加删除按钮
            //->addTopButton('self',$reset_password)  // 添加重置按钮
            //->setSearch('custom','请输入ID/用户名/昵称')
            //->setActionUrl(url('grid'))//设置请求地址
            ->keyListItem('id', 'UID')
            ->keyListItem('plotting_name', '所属展绘')
            ->keyListItem('category_id', '所属分类', 'array', $type)
            ->keyListItem('icon', '全景图','picture',['width'=>40])
            //->keyListItem('status_text', '状态')
            ->keyListItem('right_button', '操作', 'btn')
            ->setListPrimaryKey('id')
            ->setListData($data_list)// 数据列表
            ->setListPage($total)// 数据列表分页
            //->addRightButton('edit')
            ->addRightButton('delete', array('title' => '删除场景', 'confirm-info' => '你确定要删除场景吗？', 'href' => url(MODULE_NAME . '/' . CONTROLLER_NAME . '/delete', ['id' => '__data_id__'])))
            ->addRightButton('self', array('title' => '编辑图片', 'class' => 'btn btn-info btn-xs', 'href' => url(MODULE_NAME . '/plotting_details/edit', ['id' => '__data_id__'])))
            ->addRightButton('self', array('title' => '编辑场景', 'class' => 'btn btn-info btn-xs', 'href' => url(MODULE_NAME . '/plotting_details/panor', ['id' => '__data_id__'])))
           /* ->addRightButton('self', array('title' => '新增全景', 'class' => 'btn btn-success btn-xs', 'href' => url(MODULE_NAME . '/ad/details', ['id' => '__data_id__'])))*/
            // ->addRightButton('self',$reset_password)
           // ->addRightButton('forbid')
            //->addRightButton('forbid')  // 添加编辑按钮
            ->fetch();
    }

    //编辑全景
    public function panor(Request $request){
        $id=input('id');
        $pdtails=db('plotting_details')->where('id',$id)->find();
        if ($pdtails){

            //查询其他场景
            $map['plotting_id']=array('eq',$pdtails['plotting_id']);
            $map['status']=array('eq',1);
            $details=db('plotting_details')->where($map)->select();
            if ($details){
                foreach ($details as $k=>$v){
                    $details[$k]['icon_path']=Publics::get_icon($v['icon']);
                }
            }
            $this->view->assign('list',$details);//场景列表



            //查询路径
           // $xml_path=$pdtails['xml_path'];
            $xml_path=str_replace("\\",'/',$pdtails['xml_path']);
            $dir=dirname($xml_path);//返回目录
            $js=$dir.'/tour.js';
            $this->view->assign('xml_path',$xml_path);
            $this->view->assign('details',$pdtails);
            $this->view->assign('js',$js);
            return $this->view->fetch();
        }else{
            return array('code'=>201,'msg'=>'未获取到数据');
        }

    }




    //新增场景图片
    public function add(Request $request){
        if ($request->isPost()){
            $data = input('param.');
            if (!isset($data['category_id']) ||empty($data['category_id'])){
                $this->error('请选择分类');
            }
            if (!isset($data['title']) ||empty($data['title'])){
                $this->error('请填写展绘名称');
            }

            if (isset($data['icon']) && !empty($data['icon'])){
                $result=$this->set_xml($data['icon']);
                if ($result['code']==200){
                    $data['xml_path']=$result['xml'];
                    $data['html_path']=$result['index'];
                }else{
                    $this->error('生成场景失败');
                }
            }else{
                $this->error('缺少icon');
            }

            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->plottingDetailsModel->editData($data);
            if ($result) {
                $this->success('新增成功', url('plotting/index'));
            } else {
                $this->error($this->plottingDetailsModel->getError());
            }
        }else{

            $plotting_id=input('plotting_id');
            $this->view->assign('plotting_id',$plotting_id);
            //查询分类
            $category=db('category')->where('status',1)->select();

            $this->view->assign('category',$category);
            return $this->fetch();
        }
    }

    //编辑场景图片
    public function edit(Request $request){
        if ($request->isPost()){
            $data = input('param.');

            if (!isset($data['category_id']) ||empty($data['category_id'])){
                $this->error('请选择分类');
            }
            if (!isset($data['title']) ||empty($data['title'])){
                $this->error('请填写展绘名称');
            }

            if (isset($data['icon']) && !empty($data['icon'])){
                //查询新的全景跟以前的全景是否一样
                $plo=db('plotting_details')->where('id',$data['id'])->find();
                if ($plo['icon'] !=$data['icon']){
                    $result=$this->set_xml($data['icon']);
                    if ($result['code']==200){
                        $data['xml_path']=$result['xml'];
                        $data['html_path']=$result['index'];
                        //删除以前生成的全景文件
                        $url=db('attachment')->where('id',$plo['icon'])->value('url');
                        $path=explode('.',$url);
                        @unlink('.'.$url);
                        deldir('./'.$path[0].'/');
                    }else{
                        $this->error('生成场景失败');
                    }
                }
            }else{
                $this->error('缺少icon');
            }

            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->plottingDetailsModel->editData($data);
            if ($result) {
                $this->success('编辑成功', url('plotting/index'));
            } else {
                $this->error($this->plottingDetailsModel->getError());
            }
        }else{
            $id=input('id');

            //查询全景
            $plotting=db('plotting_details')->where('id',$id)->find();
            if ($plotting['icon']){
                $plotting['icon_path']=Publics::get_icon($plotting['icon']);
            }else{
                $plotting['icon_path']='/static/assets/img/noimage.gif';
            }

            if ($plotting['watermark_icon']){
                $plotting['watermark_path']=Publics::get_icon($plotting['watermark_icon']);
            }else{
                $plotting['watermark_path']='/static/assets/img/noimage.gif';
            }

            //$plotting_id=input('plotting_id');
            //$this->view->assign('plotting_id',$plotting_id);
            //查询分类
            $category=db('category')->where('status',1)->select();

            $this->view->assign('category',$category);
            $this->view->assign('plotting',$plotting);
            return $this->fetch();
        }
    }


    //生成全景xml
    public function set_xml($icon){
        $icon_path=db('attachment')->where('id',$icon)->value('url');
        //查询图片
        $url='.'.$icon_path;
        if (strtoupper(substr(PHP_OS,0,3))==='WIN'){
            //windwos
            $kr_command = "F:\project\mzh\public\krpano/krpanotools64 makepano -config=F:\project\mzh\public\krpano/templates/vtour-normal.config ".$url;
          //  $kr_command = "F:\project\mzh\public\krpano/krpanotools64 makepano -config=F:\project\mzh\public\krpano/templates/normal.config ".$url;
            exec($kr_command, $log, $status);
            if (!$status){

                $dir=dirname('.'.$icon_path);
                $wenjian=basename('.'.$icon_path);
                $ming=explode('.',$wenjian)[0];
                $xing=$dir.'/'.$ming;//新名字
                //重命名
                rename($dir.'/vtour',$dir.'/'.$ming);


                //成功
                $xml=explode('.',$icon_path)[0].'/tour.xml';
               // $xml2=explode('.',$icon_path)[0].'/tour2.xml';//备份
                $index=explode('.',$icon_path)[0].'/tour.html';

                $xml2=file_get_contents('.'.$xml);
                $xml3=str_replace('<include url="skin/vtourskin.xml" />',"",$xml2);
                @unlink('.'.$xml);//删除以前的文件
                file_put_contents('.'.$xml,$xml3);

                return array('code'=>200,'xml'=>$xml,'index'=>$index,'msg'=>'成功');
            }else{
                //失败
                return array('code'=>201,'msg'=>'失败');
            }

        }else{
            //TODO :: linux版本的使用

            $dealFlat = 'echo -e "0\n" | ';
            //软件注册码
            $r_code ="FXsqTqaGNSZER5dSETEm+VzQEh9sWSa5DZMFsSmMxYV9GcXs8W3R8A/mWXrGNUceXvrihmh28hfRF1ivrW0HMzEychPvNiD8B/4/ZzDaUE9Rh6Ig22aKJGDbja1/kYIqmc/VKfItRE2RTSOIbIroxOtsz626NIpxWksAAifwhpNwuPXqDQpz2sRUMBzoPqZktpkItoSenN2mKd8Klfx7pOuB6CIK3e1CDXgyndqOt2mWybLZcU/wfJVAecfxk15ghiqrzaDsbqrdABDowg==";

            exec( '/home/wwwroot/menzhanhui/public_html/linux/krpano-1.19-pr16/krpanotools'.' register ' .$r_code);


            $kr_command = "/home/wwwroot/menzhanhui/public_html/linux/krpano-1.19-pr16/krpanotools makepano -config=/home/wwwroot/menzhanhui/public_html/linux/krpano-1.19-pr16/templates/vtour-normal.config ".$url;
            //  $kr_command = "F:\project\mzh\public\krpano/krpanotools64 makepano -config=F:\project\mzh\public\krpano/templates/normal.config ".$url;
            exec($kr_command, $log, $status);
            if (!$status){

                $dir=dirname('.'.$icon_path);//返回目录
                $wenjian=basename('.'.$icon_path);//返回文件名
                $ming=explode('.',$wenjian)[0];//取出文件名
                $xing=$dir.'/'.$ming;//新名字
                //重命名
                rename($dir.'/vtour',$dir.'/'.$ming);

                //成功
                $xml=explode('.',$icon_path)[0].'/tour.xml';
                $index=explode('.',$icon_path)[0].'/tour.html';

                //删除xml文件中的include
                $xml2=file_get_contents('.'.$xml);
                $xml3=str_replace('<include url="skin/vtourskin.xml" />',"",$xml2);
                @unlink('.'.$xml);//删除以前的文件
                file_put_contents('.'.$xml,$xml3);
                return array('code'=>200,'xml'=>$xml,'index'=>$index,'msg'=>'成功');
            }else{
                //失败
                return array('code'=>201,'msg'=>'失败');
            }
        }

    }

    //查询标注
    public function get_standard(Request $request){
        if ($request->isPost()){
            $id=input('id');
            $pdtails=db('plotting_details')->where('id',$id)->find();
            if ($pdtails){
                //查询箭头或者标注
                $map['details_id']=array('eq',$id);
                $map['plotting_id']=array('eq',$pdtails['plotting_id']);
                $map['status']=array('eq',1);
                $standard=db('standard')->where($map)->select();
                if ($standard){
                    foreach ($standard as $k=>$v){
                        if ($v['type'] ==3){//图片
                            if (is_numeric($v['content'])){
                                $standard[$k]['icon_path']=Publics::get_icon($v['content']);
                            }else{
                                $standard[$k]['icon_path']='/static/assets/img/noimage.gif';
                            }
                        }
                    }

                    return array('code'=>200,'msg'=>'获取数据成功','data'=>$standard);
                }else{
                    return array('code'=>201,'msg'=>'未获取到数据');
                }

            }else{
                return array('code'=>201,'msg'=>'未获取到数据');
            }
        }
    }



    //新增标注
    public function standard(Request $request){
        if ($request->isPost()){
            $data=input();
            //验证数据
            $validate = Loader::validate('Standard');
            if (!$validate->scene('add1')->check($data)){
                //$this->error($validate->getError());exit();
                return array('code'=>'201','msg'=>$validate->getError());
            }


            //查询全景图片
            $details=db('plotting_details')->where('id',$data['details_id'])->find();
            if ($details){
                $data['plotting_id']=$details['plotting_id'];
            }else{
                $data['plotting_id']=0;
            }
            $data['spotname']=set_standard($data['details_id'],$data['plotting_id']);


            $res=model('standard')->allowField(true)->save($data);
            if ($res){
                return array('code'=>'200','msg'=>'添加成功');
            }else{
                return array('code'=>'201','msg'=>'添加失败');
            }
        }
    }


    //清除标注
    public function standard_del(Request $request){
        if ($request->isPost()){
            $data=input();
            if (!isset($data['details_id']) ||empty($data['details_id'])){
                return array('code'=>'201','msg'=>'缺少参数details_id');
            }
            $res=db('standard')->where('details_id',$data['details_id'])->delete();
            if (false !=$res){
                return array('code'=>'200','msg'=>'删除成功');
            }else{
                return array('code'=>'201','msg'=>'删除失败');
            }
        }
    }



    /**
     * 编辑问题
     */
    public function edit2($id = 0)
    {
        $title = $id ? "编辑" : "新增";
        if (IS_POST) {
            $data = input('param.');

            $plotting_id=input('plotting_id');
            if (!empty($plotting_id)){
               $data['plotting_id']=$plotting_id;

            }
            // 提交数据
            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            $result = $this->plottingDetailsModel->editData($data);
            if ($result) {
                //创建全景图




                $this->success($title . '成功', url('plotting/index'));
            } else {
                $this->error($this->plottingDetailsModel->getError());
            }
        } else {
            return (new Iframe())
                ->setMetaTitle($title . '全景图')
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

        $info = $this->plottingDetailsModel->get($id);
        if(empty($info)){
            $info=[];
        }

        //查询分类
        $type=db('category')->where('type',1)->where('status',1)->column('id,title');
        $form = builder('Form')
            ->addFormItem('id', 'hidden', 'UID', '')
            ->addFormItem('category_id', 'select', '类型', '类型',$type)
           // ->addFormItem('title', 'text', '展绘标题','请填写标题')
          //  ->addFormItem('describe', 'textarea', '展绘描述')
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
            'keyword_condition' => 'id|plotting_id',
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
     * 删除问题类型
     */
    public function delete($id = 0)
    {
        if ($id == 0) {
            $this->error('没有可操作的数据');
            exit();
        }

        $icon= $rest = Db::table('eacoo_plotting_details')->where('id', $id)->value('icon');
        //删除问题
        $rest = Db::table('eacoo_plotting_details')->where('id', $id)->delete();
        if (false != $rest) {
            //删除图片，删除文件
            $url=db('attachment')->where('id',$icon)->value('url');
            $path=explode('.',$url);
            @unlink('.'.$url);
            @deldir('./'.$path[0].'/');

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
