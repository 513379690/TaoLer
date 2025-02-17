<?php
namespace app\admin\controller;

use app\common\controller\AdminController;
use think\facade\View;
use think\facade\Db;
use think\facade\Session;
use think\facade\Request;
use think\facade\Cache;
use app\admin\model\Admin;
use app\admin\model\Article;
use app\admin\model\Cunsult;
use think\facade\Config;
use taoler\com\Api;

class Index extends AdminController
{
/*	
	protected function initialize()
    {
        parent::initialize();
    }
*/	
	public function __construct()
	{
        //控制器初始化显示左侧导航菜单
        parent::initialize();

		$this->sys_version = Config::get('taoler.version');
		$this->pn = Config::get('taoler.appname');
		$this->sys = $this->getSystem();
		$this->domain = $this->getHttpUrl($this->sys['domain']);
		$this->api = $this->sys['api_url'];
		if(empty($this->api)){
			$baseUrl = $this->sys['base_url'];
			$this->api = strstr($baseUrl,'/v',true);
		}

	}
    

    public function index()
	{
        return View::fetch('index');
    }
	

    public function set()
	{
        return view();
    }

    public function message()
	{
        return view();
    }

    public function home()
	{
		//版本检测
		$url = $this->sys['upcheck_url'].'?pn='.$this->pn.'&ver='.$this->sys_version;
		$versions = Api::urlGet($url);
		if($versions->code == 1){
			if($versions->up_num > 0){
				$versions = "当前有{$versions->up_num}个版本需更新,当前可更新至{$versions->version}";
			}
		} else {
			$versions ='当前无可更新版本';
		}
		//评论、帖子状态
		$comm = Db::name('comment')->field('id')->where(['delete_time'=>0,'status'=>0])->select();
		$forum = Db::name('article')->field('id')->where(['delete_time'=>0,'status'=>0])->select();
		$comms = count($comm);
		$forums = count($forum);
		//运行时间
		$now = time();
		$count = $now-$this->sys['create_time'];
		$days = floor($count/86400);
		$hos = floor(($count%86400)/3600);
		$mins = floor(($count%3600)/60);
		$years = floor($days/365);
		if($years >= 1){
			$days = floor($days%365);
		}
		$runTime = $years ? "{$years}年{$days}天{$hos}时{$mins}分" : "{$days}天{$hos}时{$mins}分";
	
		View::assign(['runTime'=>$runTime,'versions'=>$versions,'comms'=>$comms,'forums'=>$forums]);
        return View::fetch();
    }
	
	//本周发帖
	public function forums()
	{
		$forumList = Db::name('article')
			->alias('a')
			->join('user u','a.user_id = u.id')
			->join('cate c','a.cate_id = c.id')
			->field('a.id as aid,title,name,catename,pv')
			->whereWeek('a.create_time')
			->order('a.create_time', 'desc')
			->paginate(10);
			$res = [];
			$count = $forumList->total();
			if($count){
				$res['code'] = 0;
				$res['msg'] = '';
				$res['count'] = $count;
				foreach($forumList as $k=>$v){
				    $url = (string) str_replace("admin","index",$this->domain.url('article/detail',['id'=>$v['aid']]));
				$res['data'][]= ['id'=>$url,'title'=>$v['title'],'name'=>$v['name'],'catename'=>$v['catename'],'pv'=>$v['pv']];
				}
			} else {
				$res = ['code'=>-1,'msg'=>'本周还没有发帖！'];
			}
			return json($res);
	}
	
	//本周评论
	public function replys()
	{
		if(Request::isAjax()) {
		
			$replys = Db::name('comment')
				->alias('a')
				->join('user u','a.user_id = u.id')
				->join('article c','a.article_id = c.id')
				->field('a.content as content,title,c.id as cid,name')
				->whereWeek('a.create_time')
				->order('a.create_time', 'desc')
				->paginate(10);
			
			$count = $replys->total();
			$res = [];
			if ($count) {
				$res = ['code'=>0,'msg'=>'','count'=>$count];
				foreach($replys as $k => $v){
					$res['data'][] = ['content'=>$v['content'],'title'=>$v['title'],'cid'=>str_replace("admin","index",$this->domain.(string) url('article/detail',['id'=>$v['cid']])),'name'=>$v['name']];
				}
			} else {
				$res = ['code'=>-1,'msg'=>'本周还没评论'];
			}
			return json($res);
			}
	}
	
	//动态信息
	public function news()
	{
		$page = Request::param('page');
		$url = $this->api.'/v1/news?'.Request::query();
		$news = Cache::get('news'.$page);
		if(is_null($news)){
			$news = Api::urlGet($url);
			Cache::set('news'.$page,$news,600);
		}
		
		if($news){
			return $news;
		}else{
			return json(['code'=>-1,'msg'=>'稍后获取内容...']);
		}
		
	}
	
	//提交反馈
	public function cunsult()
	{
		$url = $this->api.'/v1/reply';
		//$mail = Db::name('system')->where('id',1)->value('auth_mail');	//	bug邮件发送
		if(Request::isAjax()){
			$data = Request::only(['type','title','content','post']);
			//halt($data);
			$apiRes = Api::urlPost($url,$data);
			$data['poster'] = Session::get('admin_id');
			unset($data['post']);
			if($apiRes){
				$res = Cunsult::create($data);
				if($res->id){
					//$result = mailto($mail,$data['title'],'我的问题类型是'.$data['type'].$data['content']);
					$res = ['code'=>0,'msg'=>$apiRes->msg];
				} else {
					$res = ['code'=>0,'msg'=>$apiRes->msg];
				}
			} else {
				$res = ['code'=>-1,'msg'=>'失败，请稍后再试提交...'];
			}
			return json($res);
		}
		
	}
	
	//问题和反馈
	public function reply()
	{
		if(Request::isAjax()) {
		
			$replys = Db::name('cunsult')
				->whereWeek('create_time')
				->order('create_time', 'desc')
				->paginate(10);
			
			$count = $replys->total();
			$res = [];
			if ($count) {
				$res = ['code'=>0,'msg'=>'','count'=>$count];
				foreach($replys as $k => $v){
					$res['data'][] = ['id'=>$v['id'],'content'=>$v['content'],'title'=>$v['title'],'time'=>Date('Y-m-d',$v['create_time'])];
				}
			} else {
				$res = ['code'=>-1,'msg'=>'本周还没问题'];
			}
			return json($res);
			}
	}
	
	//删除反馈
	public function delReply()
	{
		if(Request::isAjax()){
			$res = Db::name('cunsult')->delete(input('id'));
			 
			if($res){
				$res = ['code'=>0,'msg'=>'删除成功！'];
			}else{
				$res = ['code'=>-1,'msg'=>'删除失败！'];
			}
			return json($res);
		}
	}
	
	
	
	  public function layout(){
		
        return view();
    }
}