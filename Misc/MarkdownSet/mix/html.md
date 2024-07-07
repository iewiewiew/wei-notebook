<!DOCTYPE html>
<html lang='zh-CN'>
<head>
<title>docs/performance/performance-web-import.md · HarmonyOS-Cases/Cases - Gitee.com</title>
<meta content='on' http-equiv='x-dns-prefetch-control'>
<link href='//e.gitee.com' rel='dns-prefetch'>
<link href='//files.gitee.com' rel='dns-prefetch'>
<link href='//toscode.gitee.com' rel='dns-prefetch'>
<link href='https://cn-assets.gitee.com' rel='dns-prefetch'>
<link href='https://portrait.gitee.com' rel='dns-prefetch'>
<link rel="shortcut icon" type="image/vnd.microsoft.icon" href="https://cn-assets.gitee.com/assets/favicon-9007bd527d8a7851c8330e783151df58.ico" />
<link rel="canonical" href="https://gitee.com/harmonyos-cases/cases" />
<meta content='gitee.com/harmonyos-cases/cases git https://gitee.com/harmonyos-cases/cases.git' name='go-import'>
<meta charset='utf-8'>
<meta content='always' name='referrer'>
<meta content='Gitee' property='og:site_name'>
<meta content='Object' property='og:type'>
<meta content='https://gitee.com/harmonyos-cases/cases/blob/master/docs/performance/performance-web-import.md' property='og:url'>
<meta content='https://gitee.com/static/images/logo_themecolor.png' itemprop='image' property='og:image'>
<meta content='docs/performance/performance-web-import.md · HarmonyOS-Cases/Cases - Gitee.com' itemprop='name' property='og:title'>
<meta content='看置顶Issue，加入HarmonyOS NEXT应用开发案例交流微信群！' property='og:description'>
<meta content='码云,Gitee,代码托管,Git,Git@OSC,Gitee.com,开源,内源,项目管理,版本控制,开源代码,代码分享,项目协作,开源项目托管,免费代码托管,Git代码托管,Git托管服务' name='Keywords'>
<meta content='看置顶Issue，加入HarmonyOS NEXT应用开发案例交流微信群！' itemprop='description' name='Description'>
<meta content='pc,mobile' name='applicable-device'>

<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="NLCpdk3gREILSkFdzp1hm45iu/3d4GhqKJ7nfDWp6etAovH7xeZDqld7hd5HG7TN83yTMYmG1uI3GpXDFu4MIw==" />

<link rel="stylesheet" media="all" href="https://cn-assets.gitee.com/assets/application-92f37f947e65f444e944490fdd28d389.css" />
<script>
//<![CDATA[
window.gon = {};gon.locale="zh-CN";gon.sentry_dsn=null;gon.baidu_register_hm_push=null;gon.sensor={"server_url":"https://haveaniceday.gitee.com:3443/sa?project=production","sdk_url":"https://cn-assets.gitee.com/assets/static/sensors-sdk-2f850fa5b654ad55ac0993fda2f37ba5.js","page_type":"其他"};gon.info={"controller_path":"blob","action_name":"show","current_user":{"id":14744567,"name":"test073001","username":"test073001_admin_admin_admin_admin","official":false,"admin":false,"avatar_url":"no_portrait.png#test073001-test073001_admin_admin_admin_admin"}};gon.tour_env={"current_user":"test073001_admin_admin_admin_admin","action_name":"show","original_url":"https://gitee.com/harmonyos-cases/cases/blob/master/docs/performance/performance-web-import.md","controller_path":"blob"};gon.http_clone="https://gitee.com/harmonyos-cases/cases.git";gon.user_project="harmonyos-cases/cases";gon.manage_branch="管理分支";gon.manage_tag="管理标签";gon.enterprise_id=13067030;gon.create_reaction_path="/harmonyos-cases/cases/reactions";gon.ipipe_base_url="https://go-api.gitee.com";gon.artifact_base_url="https://go-repo.gitee.com";gon.gitee_go_remote_url="https://go.gitee.com/assets";gon.gitee_go_active=false;gon.current_project_is_mirror=false;gon.show_repo_comment=false;gon.diagram_viewer_path="https://diagram-viewer.giteeusercontent.com";gon.ent_host="e.gitee.com";gon.ref="master";
//]]>
</script>
<script src="https://cn-assets.gitee.com/assets/static/sensor-6269b9ad61bbcdaff20078e5dcff62d5.js"></script>
<script src="https://cn-assets.gitee.com/assets/static/sentry-5.1.0-a823fb0be1b61c5d7ca4a89f0536cb0a.js"></script>
<script src="https://cn-assets.gitee.com/assets/application-41226c6a36ee674dcabaa6eb9b9e2a26.js"></script>
<script src="https://cn-assets.gitee.com/assets/lib/jquery.timeago.zh-CN-4a4818e98c1978d2419ab19fabcba740.js"></script>

<link rel="stylesheet" media="all" href="https://cn-assets.gitee.com/assets/projects/application-46b94c31ba11ae8c37eacce2bdb5603e.css" />
<script src="https://cn-assets.gitee.com/assets/projects/app-8079083d213fdaf708bdc617704703b1.js"></script>

<script type='text/x-mathjax-config'>
MathJax.Hub.Config({
  tex2jax: {
    inlineMath: [['$','$'], ['\\(','\\)']],
    displayMath: [["$$","$$"],["\\[","\\]"]],
    processEscapes: true,
    skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code'],
    ignoreClass: "container|files",
    processClass: "markdown-body"
  }
});
</script>
<script src="https://cn-assets.gitee.com/uploads/resources/MathJax-2.7.2/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

<script>
  (function () {
    var messages = {
      'zh-CN': {
        addResult: '增加 <b>{term}</b>',
        count: '已选择 {count}',
        maxSelections: '最多 {maxCount} 个选择',
        noResults: '未找到结果',
        serverError: '连接服务器时发生错误'
      },
      'zh-TW': {
        addResult: '增加 <b>{term}</b>',
        count: '已選擇 {count}',
        maxSelections: '最多 {maxCount} 個選擇',
        noResults: '未找到結果',
        serverError: '連接服務器時發生錯誤'
      }
    }
  
    if (messages[gon.locale]) {
      $.fn.dropdown.settings.message = messages[gon.locale]
    }
  }());
</script>

<script>
  var userAgent = navigator.userAgent;
  var isLessIE11 = userAgent.indexOf('compatible') > -1 && userAgent.indexOf('MSIE') > -1;
  if(isLessIE11){
    var can_access = ""
    if (can_access != "true"){
      window.location.href = "/incompatible.html";
    }
  }
  document.addEventListener("error", function (ev) {
    var elem = ev.target;
    if (elem.tagName.toLowerCase() === 'img') {
      elem.src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAAAAACIM/FCAAACh0lEQVR4Ae3ch5W0OgyG4dt/mQJ2xgQPzJoM1m3AbALrxzrf28FzsoP0HykJEEAAAUQTBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEkKK0789+GK/I2ezfQB522PnS1qc8pGgXvr4tE4aY0XOUWlGImThWgyCk6DleixzE7qwBkg/MGiDPlVVAyp1VQGrPKiACDhFI6VkF5LmzCki+sg7IwDoglnVAil0IMkeG9CyUiwsxLFUVFzJJOQaKCjFCDN9RXMjIX7W6ztZXZDKKCyn8sWJvH+nca7WHDN9lROlAliPH9iRKCPI4cswFJQWxB46toLQgQ9jhn5QYZA9DOkoMUoQde5YapAxDWkoNYsOQR3KQd9CxUnIQF4S49CB9ENKlBxmDEKsFUgMCCCCAAHIrSF61f6153Ajy8nyiPr8L5MXnmm4CyT2fzN4DUvHZ+ntA2tOQBRBAAAEEEEAAAQQQ7ZBaC6TwSiDUaYHQ2yuB0MN+ft+43whyrs4rgVCjBUKTFshLC6TUAjGA3AxSaYFYLZBOC2RUAsk8h5qTg9QcbEoOsoQhQ2qQhsO5xCD5dgB5JQaZ+KBKGtKecvR81Ic0ZDjByKdDx0rSEDZ/djQbH+bkIdvfJFm98BfV8hD2zprfVdlu9PxVeyYAkciREohRAplJCaRSAplJCcQogTjSAdlyHRBvSAekJR0QRzogA+mADJkOiCPSAPEtqYBshlRAXC43hxix2QiOuEZkVERykGyNo9idIZKE0HO7XrG6OiMShlDWjstVzdPgXtUH9v0CEidAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQP4HgjZxTpdEii0AAAAASUVORK5CYII=";
    }
  }, true);
</script>
</head>

<script src="//res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
  var title = document.title.replace(/( - Gitee| - 码云)$/, '')
      imgUrl = '';
  
  document.addEventListener('DOMContentLoaded', function(event) {
    var imgUrlEl = document.querySelector('.readme-box .markdown-body > img, .readme-box .markdown-body :not(a) > img');
    imgUrl = imgUrlEl && imgUrlEl.getAttribute('src');
  
    if (!imgUrl) {
      imgUrlEl = document.querySelector('meta[itemprop=image]');
      imgUrl = imgUrlEl && imgUrlEl.getAttribute('content');
      imgUrl = imgUrl || "https://gitee.com/static/images/logo_themecolor.png";
    }
  
    wx.config({
      debug: false,
      appId: "wxff219d611a159737",
      timestamp: "1725937309",
      nonceStr: "e7d378240973fea97b0814c5249e014e",
      signature: "9ec7503630dcae6718ffcd97f70e2a27089c46a9",
      jsApiList: [
        'onMenuShareTimeline',
        'onMenuShareAppMessage'
      ]
    });
  
    wx.ready(function () {
      wx.onMenuShareTimeline({
        title: title, // 分享标题
        link: "https://gitee.com/harmonyos-cases/cases/blob/master/docs/performance/performance-web-import.md", // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
        imgUrl: imgUrl // 分享图标
      });
      wx.onMenuShareAppMessage({
        title: title, // 分享标题
        link: "https://gitee.com/harmonyos-cases/cases/blob/master/docs/performance/performance-web-import.md", // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
        desc: document.querySelector('meta[name=Description]').getAttribute('content'),
        imgUrl: imgUrl // 分享图标
      });
    });
    wx.error(function(res){
      console.error('err', res)
    });
  })
</script>

<body class='git-project lang-zh-CN'>
<header class='common-header fixed noborder' id='git-header-nav'>
<div class='ui container'>
<div class='ui menu header-menu header-container'>
<div class='git-nav-expand-bar'>
<i class='iconfont icon-mode-table'></i>
</div>
<div class='gitee-nav__sidebar'>
<div class='gitee-nav__sidebar-container'>
<div class='gitee-nav__sidebar-top'>
<div class='gitee-nav__avatar-box'>
<a href="/test073001_admin_admin_admin_admin"><img class="ui avatar image test073001_admin_admin_admin_admin-avatar" avatar="test073001-test073001_admin_admin_admin_admin" />
</a></div>
<div class='gitee-nav__info-box'>
<a href="/test073001_admin_admin_admin_admin">test073001</a>
</div>
</div>
<div class='gitee-nav__sidebar-middle'>
<div class='gitee-nav__sidebar-list'>
<ul>
<li class='gitee-nav__sidebar-item'>
<a href="/test073001_admin_admin_admin_admin"><i class='iconfont icon-ic-dashboard'></i>
<span class='gitee-nav__sidebar-name'>个人主页</span>
</a></li>
<li class='gitee-nav__sidebar-item'>
<a href="/explore"><i class='iconfont icon-ic-discover'></i>
<span class='gitee-nav__sidebar-name'>开源</span>
</a></li>
<li class='gitee-nav__sidebar-item'>
<a href="/enterprises"><i class='iconfont icon-ic-enterprise'></i>
<span class='gitee-nav__sidebar-name'>企业版</span>
</a></li>
<li class='gitee-nav__sidebar-item'>
<a href="/education"><i class='iconfont icon-ic-education'></i>
<span class='gitee-nav__sidebar-name'>高校版</span>
</a></li>
<li class='gitee-nav__sidebar-item split-line'></li>
<li class='gitee-nav__sidebar-item'>
<a href="/search"><i class='iconfont icon-ic-search'></i>
<span class='gitee-nav__sidebar-name'>搜索</span>
</a></li>
<li class='gitee-nav__sidebar-item'>
<a href="/help"><i class='iconfont icon-help-circle'></i>
<span class='gitee-nav__sidebar-name'>帮助中心</span>
</a></li>
<li class='gitee-nav__sidebar-item'>
<a href="/terms"><i class='iconfont icon-file'></i>
<span class='gitee-nav__sidebar-name'>使用条款</span>
</a></li>
<li class='gitee-nav__sidebar-item'>
<a href="/about_us"><i class='iconfont icon-issuepx'></i>
<span class='gitee-nav__sidebar-name'>关于我们</span>
</a></li>
<li class='gitee-nav__sidebar-item'>
<a href="/profile/account_information"><i class='iconfont icon-edit'></i>
<span class='gitee-nav__sidebar-name'>设置</span>
</a></li>
<li class='gitee-nav__sidebar-item'>
<a rel="nofollow" data-method="delete" href="/logout"><i class='iconfont icon-ic-logout'></i>
<span class='gitee-nav__sidebar-name'>
退出
</span>
</a></li>
</ul>
</div>
</div>
<div class='gitee-nav__sidebar-bottom'>
<div class='gitee-nav__sidebar-close-button'>
<i class='fa fa-angle-double-left'></i>
</div>
</div>
</div>
</div>

<!-- /todo 10周年活动结束后 恢复 -->
<div class='item gitosc-logo'>
<a href="https://gitee.com"><img alt='Gitee - 基于 Git 的代码托管和研发协作平台' class='ui inline image' height='28' src='/static/images/logo.svg?t=158106664' title='Gitee - 基于 Git 的代码托管和研发协作平台' width='95'>
<img alt='Gitee - 基于 Git 的代码托管和研发协作平台' class='ui inline black image' height='28' src='/static/images/logo-black.svg?t=158106664' title='Gitee - 基于 Git 的代码托管和研发协作平台' width='95'>
</a></div>
<a title="开源" class="item " href="/explore">开源
</a><a title="企业版" class="item " sa_evt="click_GiteeCommunity_tab_En" href="/enterprises">企业版
</a><a title="高校版" class="item " href="/education">高校版
</a><a title="私有云" class="item" target="_blank" href="https://gitee.cn?utm_source=giteecom">私有云
</a><a title="Gitee AI" class="item mr-3" id="gitee-blog" target="_blank" href="https://ai.gitee.com/?utm_sources=site_nav">Gitee AI
<sup class='ui red label'>
NEW
</sup>
</a><div class='dropdown item ui' id='my-gitee-dropdown'>
<a href="/">我的</a>
<i class='dropdown icon'></i>
<div class='menu'>
<div class='ui active dimmer inverted js-my-gitee-dropdown-loader'>
<div class='ui loader'></div>
</div>
<div class='header user-enterprises'>
<a class="pull-right" target="_blank" href="/test073001_admin_admin_admin_admin/dashboard/enterprises">全部</a>
企业
<span class='count'></span>
</div>
<div class='disabled item tip user-enterprises'>
无企业
</div>
<div class='header user-groups'>
<a class="pull-right" target="_blank" href="/test073001_admin_admin_admin_admin/dashboard/groups">全部</a>
组织
<span class='count'></span>
</div>
<div class='disabled item tip user-groups'>
无组织
</div>
<div class='header user-programs'>
项目
<span class='count'></span>
</div>
<div class='disabled item tip user-programs'>
<span class="translation_missing" title="translation missing: zh-CN.layouts.header.empty_programs">Empty Programs</span>
</div>
<div class='header user-projects'>
<a class="pull-right" target="_blank" href="/test073001_admin_admin_admin_admin/projects">全部</a>
仓库
<span class='count'></span>
</div>
<div class='disabled item tip user-projects'>
无项目
</div>
</div>
</div>
<div class='center responsive-logo'>
<a href="https://gitee.com"><img alt='Gitee - 基于 Git 的代码托管和研发协作平台' class='ui inline image' height='24' src='/static/images/logo.svg?t=158106664' title='Gitee - 基于 Git 的代码托管和研发协作平台' width='85'>
<img alt='Gitee - 基于 Git 的代码托管和研发协作平台' class='ui inline black image' height='24' src='/static/images/logo-black.svg?t=158106664' title='Gitee - 基于 Git 的代码托管和研发协作平台' width='85'>
</a></div>
<div class='right menu userbar right-header' id='git-nav-user-bar'>
<form class="ui item" id="navbar-search-form" data-text-require="搜索关键字不能少于1个" data-text-filter="搜索格式不正确" action="/search" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="&#x2713;" />
<input type="hidden" name="type" id="navbar-search-type" />
<input type="hidden" name="fork_filter" id="fork_filter" value="on" />
<div class='ui search header-search'>
<input type="text" name="q" id="navbar-search-input" value="" class="prompt" placeholder="搜开源" />
</div>
</form>

<script>
  var can_search_in_repo = 1,
      repo = "VFhwSk5VMTZSWGRQUkd4b1RucFplbHBuUFQxaE56WXpaZz09YTc2M2Y=",
      reponame = "harmonyos-cases/cases";
  
  $(function() {
    var $search = $('#navbar-search-form .ui.search');
    $search.search({
      apiSettings: {
        url: '/search/relative_project?q={query}',
        onResponse: function (res) {
          if (res && res.status === 200 && res.data) {
            var query = htmlSafe($search.search('get value'));
  
            res.data.map(function (item) {
              item.path_ns = '/' + item.path_ns;
              item.icon = 'iconfont icon-project-public';
            });
            res.data.unshift({
              name_ns: "在全站搜索 <b class='hl'>" + query +"</b> 相关项目",
              path_ns: '/search?fork_filter=on&q=' + query,
              icon: 'iconfont icon-search'
            });
            return res;
          } else {
            return { data: [] };
          }
        }
      },
      fields: {
        results: 'data',
        description: 'name_ns',
        url: 'path_ns',
        icon: 'icon'
      },
      minCharacters: 1,
      maxResults: 10,
      searchDelay: 250,
      showNoResults: false,
      transition: 'fade'
    });
  });
</script>

<div class='item ui dropdown empty' data-count-path='/notifications/unread_count' data-enable data-mark-notice-path='/notifications/mark' id='notice-dropdown'>
<a class="remind-button" href="/notifications"><i class='iconfont icon-remind'></i>
<div class='notice-count total'></div>
</a><div class='notice-dropdown-panel menu'>
<div class='notice-dropdown-panel-header'>
<div class='tab active' data-data-path='/notifications/notices?scope=referer' data-html-path='/notifications/referer' data-scope='referer'>
<div class='content'>
@ 我
<div class='notice-count referer'></div>
</div>
</div>
<div class='tab' data-data-path='/notifications/notices?scope=infos' data-html-path='/notifications/infos' data-scope='infos'>
<div class='content'>
通知
<div class='notice-count infos'></div>
</div>
</div>
<div class='tab' data-data-path='/notifications/notices?scope=messages' data-html-path='/notifications/messages' data-scope='messages'>
<div class='content'>
私信
<div class='notice-count messages'></div>
</div>
</div>
</div>
<div class='item notice-dropdown-panel-container'>
<div class='ui dimmer over active'>
<div class='ui loader'></div>
</div>
<div class='notice-list'></div>
<div class='notice-dropdown-panel-blank'>
暂没有新消息
</div>
</div>
<div class='notice-dropdown-panel-footer'>
<div class='action'>
<div class='side left'>
<a class="mark-notices" href="javascript: void(0);">当前标记为已读
</a></div>
<div class='side right'>
<a class="load-all" target="_blank" href="javascript: void(0);">查看全部
</a></div>
</div>
</div>
</div>
</div>

<div class='ui item' id='feature-update-notice'>
<div class='notice-update-icon'>
<a class="notice-update-popup click-knowed" title="" href="javascript:void(0)"><img alt="功能更新" title="" class="bubl_icon bubl-off-icon" src="https://cn-assets.gitee.com/assets/bulb_off-24ee940be20998aace89a3f040cbc704.svg" />
<img alt="功能更新" title="" class="bubl_icon bubl-on-icon" src="https://cn-assets.gitee.com/assets/bulb_on-3986b1dc417285398e3d15671bd8f261.svg" />
</a></div>
<div class='feature-update-notice-panel menu'>
<div class='notice-img'>
<img alt="" title="" class="notice-img-show" src="" />
</div>
<div class='notice-update-title'></div>
<div class='notice-update-des'></div>
<div class='notice-btn-list d-flex-between'>
<button name="button" type="button" class="ui basic orange button btn-notice btn-knowed click-knowed" style="margin-right: 0">我知道了</button>
<a class="ui button orange btn-notice btn-details click-knowed" target="_blank" href="">查看详情</a>
</div>
</div>
</div>

<div class='ui dropdown link item' id='git-nav-create'>
<i class='iconfont icon-add-thin'></i>
<div class='right menu'>
<a class="item" href="/projects/new"><i class='add square icon'></i>
新建仓库
</a><a class="item" href="/organizations/new"><i class='group icon'></i>
创建组织
</a><a class="item" sa_evt="click_GiteeCommunity_tab_plus_EnSignup" href="/enterprises/new"><i class='icon iconfont icon-enterprise'></i>
开通企业版
</a><a class="item" href="/projects/import/url"><i class='github icon'></i>
从 GitHub / GitLab 导入仓库
</a><a class="item" href="/test073001_admin_admin_admin_admin/codes/new"><i class='code icon'></i>
发布代码片段
</a></div>
</div>
<div class='ui dropdown item' id='git-nav-user'>
<img class="ui avatar image" avatar="test073001-test073001_admin_admin_admin_admin" />
<i class='dropdown icon'></i>
<div class='right menu'>
<a class="item" href="/test073001_admin_admin_admin_admin"><i class='iconfont icon-ic-home'></i>
个人主页
</a><a class="item" href="/test073001_admin_admin_admin_admin/starred"><i class='iconfont icon-star'></i>
我的星选集
</a><a class="item" sa_evt="recommenderClick" sa_click_location="头像-成为推荐官" href="/profile/cps/overview"><img src="https://cn-assets.gitee.com/assets/cps_icon-9c17338b5d65451ce5190ddb75fce3c7.svg" alt="Cps icon" />
成为推荐官
</a><a class="item" href="/profile/account_information"><div class='mayun-icon my-ic-edit my-ic-edit-dims'></div>
设置
</a><div class='divider'></div>
<a class="item" target="_blank" href="https://help.gitee.com"><div class='mayun-icon my-ic-help my-ic-help-dims'></div>
帮助
</a><div class='divider'></div>
<a class="item destroy-user-session" rel="nofollow" data-method="delete" href="/logout"><div class='mayun-icon my-ic-exit my-ic-exit-dims'></div>
退出
</a></div>
</div>
<script>
  $('.destroy-user-session').on('click', function() {
    $.cookie('access_token', null, { path: '/' });
  })
</script>

</div>
</div>
</div>
</header>
<script>
  Gitee.initNavbar()
  Gitee.initRepoRemoteWay()
  $.cookie('user_locale',null)
</script>

<script>
  var userAgent = navigator.userAgent;
  var isLessIE11 = userAgent.indexOf('compatible') > -1 && userAgent.indexOf('MSIE') > -1;
  if(isLessIE11){
    var can_access = ""
    if (can_access != "true"){
      window.location.href = "/incompatible.html";
    }
  }
</script>

<div class='fixed-notice-infos'>
<div class='all-messages'>
</div>
<div class='ui container'>
<div class='flash-messages' id='messages-container'></div>
</div>
<script>
  (function() {
    $(function() {
      var $error_box, alertTip, notify_content, notify_options, template;
      template = '<div data-notify="container" class="ui {0} message" role="alert">' + '<i data-notify="dismiss" class="close icon"></i>' + '<span data-notify="message">{2}</span>' + '</div>';
      notify_content = null;
      notify_options = {};
      alertTip = '';
      $error_box = $(".flash_error.flash_error_box");
      if (notify_options.type === 'error' && $error_box.length > 0 && !$.isEmptyObject(notify_content.message)) {
        if (notify_content.message === 'captcha_fail') {
          alertTip = "验证码不正确";
        } else if (notify_content.message === 'captcha_expired') {
          alertTip = "验证码已过期，请点击刷新";
        } else if (notify_content.message === 'not_found_in_database') {
          alertTip = "帐号或者密码错误";
        } else if (notify_content.message === 'not_found_and_show_captcha') {
          alertTip = "帐号或者密码错误";
        } else if (notify_content.message === 'phone_captcha_fail') {
          alertTip = "手机验证码不通过";
        } else {
          alertTip = notify_content.message;
        }
        return $error_box.html(alertTip).show();
      } else if (notify_content) {
        if ("show" === 'third_party_binding') {
          return $('#third_party_binding-message').html(notify_content.message).addClass('ui message red');
        }
        notify_options.delay = 3000;
        notify_options.template = template;
        notify_options.offset = {
          x: 10,
          y: 30
        };
        notify_options.element = '#messages-container';
        return $.notify(notify_content, notify_options);
      }
    });

}).call(this);
</script>

</div>
<script>
  (function() {
    $(function() {
      var setCookie;
      setCookie = function(name, value) {
        $.cookie(name, value, {
          path: '/',
          expires: 365
        });
      };
      $('#remove-bulletin, #remove-bulletin-dashboard').on('click', function() {
        setCookie('remove_bulletin', "gitee-maintain-1725849027");
        $('#git-bulletin').hide();
      });
      $('#remove-member-bulletin').on('click', function() {
        setCookie('remove_member_bulletin', "gitee_member_bulletin");
        $(this).parent().hide();
      });
      return $('#remove-gift-bulletin').on('click', function() {
        setCookie('remove_gift_bulletin', "gitee-gift-bulletin");
        $(this).parent().hide();
      });
    });

}).call(this);
</script>
<script>
  function closeMessageBanner(pthis, type, val) {
    var json = {}
  
    val = typeof val === 'undefined' ? null : val
    $(pthis).parent().remove()
    if (type === 'out_of_enterprise_member') {
      json = {type: type, data: val}
    } else if (type === 'enterprise_overdue') {
      json = {type: type, data: val}
    }
    $.post('/profile/close_flash_tip', json)
  }
</script>

<div class='site-content'>
<div class='git-project-header'>
<div class='fixed-notice-infos'>
<div class='ui info icon floating message green' id='fetch-ok' style='display: none'>
<div class='content'>
<div class='header status-title'>
<i class='info icon status-icon'></i>
代码拉取完成，页面将自动刷新
</div>
</div>
</div>
<div class='ui info icon floating message error' id='fetch-error' style='display: none'>
<div class='content'>
<div class='header status-title'>
<i class='info icon status-icon'></i>
<span class='error_msg'></span>
</div>
</div>
</div>
</div>
<div class='ui container'>
<div class='git-project-categories'>
<a href="/explore">开源项目</a>
<span class='symbol'>></span>
<a href="/explore/harmony">OpenHarmony</a>
<span class='symbol'>&gt;</span>
<a href="/explore/harmonyos-guide">OpenHarmony 教程指南</a>
<span class='symbol and-symbol'>&&</span>
</div>

<div class='git-project-header-details'>
<div class='git-project-header-container'>
<div class='git-project-header-actions'>
<div class='ui tiny modal project-donate-modal' id='project-donate-modal'>
<i class='iconfont icon-close close'></i>
<div class='header'>捐赠</div>
<div class='content'>
该仓库未开启捐赠功能，可发送私信通知作者开启
</div>
<div class='actions'>
<a class='ui blank button cancel'>取消</a>
<a class='ui orange ok button' href='/notifications/messages/5416512?donate_project=harmonyos-cases%2Fcases'>发送私信</a>
</div>
</div>
<div class='ui small modal wepay-qrcode'>
<i class='iconfont icon-close close'></i>
<div class='header'>
扫描微信二维码支付
<span class='wepay-cash'></span>
</div>
<div class='content weqcode-center'>
<img id='wepay-qrcode' src=''>
</div>
<div class='actions'>
<div class='ui cancel blank button'>取消</div>
<div class='ui ok orange button'>支付完成</div>
</div>
</div>
<div class='ui mini modal' id='confirm-alipay-modal'>
<div class='header'>支付提示</div>
<div class='content'>
将跳转至支付宝完成支付
</div>
<div class='actions'>
<div class='ui approve orange button'>确定</div>
<div class='ui blank cancel button'>取消</div>
</div>
</div>

<span class='ui buttons basic watch-container'>
<div class='ui dropdown button js-project-watch' data-watch-type='unwatch'>
<input type='hidden' value=''>
<i class='iconfont icon-watch'></i>
<div class='text'>
Watch
</div>
<i class='dropdown icon'></i>
<div class='menu'>
<a data-value="unwatch" class="item" data-remote="true" rel="nofollow" data-method="post" href="/harmonyos-cases/cases/unwatch"><i class='iconfont icon-msg-read'></i>
不关注
</a><a data-value="watching" class="item" data-remote="true" rel="nofollow" data-method="post" href="/harmonyos-cases/cases/watch"><i class='iconfont icon-msg-read'></i>
关注所有动态
</a><a data-value="releases_only" class="disabled item" data-remote="true" rel="nofollow" data-method="post" href="/harmonyos-cases/cases/release_only_watch"><i class='iconfont icon-msg-read'></i>
仅关注版本发行动态
</a><a data-value="ignoring" class="item" data-remote="true" rel="nofollow" data-method="post" href="/harmonyos-cases/cases/ignoring_watch"><i class='iconfont icon-msg-read'></i>
关注但不提醒动态
</a></div>
</div>
<style>
  .js-project-watch .text .iconfont {
    display: none; }
  .js-project-watch a, .js-project-watch a:hover {
    color: #000; }
  .js-project-watch .item > .iconfont {
    visibility: hidden;
    margin-left: -10px; }
  .js-project-watch .selected .iconfont {
    visibility: visible; }
  .js-project-watch .menu {
    margin-top: 4px !important; }
</style>
<script>
  $('.js-project-watch').dropdown({
    action: 'select',
    onChange: function(value, text, $selectedItem) {
      var type = value === 'unwatch' ? 'Watch' : 'Watching';
      $(this).children('.text').text(type);
      $(this).dropdown('set selected', value)
    }
  });
</script>

<a class="ui button action-social-count" title="212" href="/harmonyos-cases/cases/watchers">212
</a></span>
<span class='basic buttons star-container ui'>
<a class="ui button unstar " sa_evt="clickStar" sa_location="其他" sa_url="" sa_repo_id="32931089" data-remote="true" rel="nofollow" data-method="post" href="/harmonyos-cases/cases/unstar"><i class='iconfont icon-star-solid'></i>
Starred
</a><a class="ui button star " sa_evt="clickStar" sa_location="其他" sa_url="" sa_repo_id="32931089" data-remote="true" rel="nofollow" data-method="post" href="/harmonyos-cases/cases/star"><i class='iconfont icon-star'></i>
Star
</a><a class="ui button action-social-count " title="1011" href="/harmonyos-cases/cases/stargazers">1K
</a></span>
<span class='ui basic buttons fork-container' title=''>
<a id="fork-top-button" class="ui button fork " sa_evt="repoFork" sa_repo_id="32931089" sa_is_self="false" sa_is_member="false" href="#"><i class='iconfont icon-fork'></i>
Fork
</a><a class="ui button action-social-count " title="415" href="/harmonyos-cases/cases/members">415
</a></span>
</div>
<h2 class='git-project-title mt-0 mb-0'>
<span class="project-title"><a href='/harmonyos-cases'><i class="iconfont icon-enterprise-badge" title="这是一个企业仓库"></i></a> <i class="project-icon iconfont icon-project-public" title="这是一个公开仓库"></i> <a title="HarmonyOS-Cases" class="author" href="/harmonyos-cases">HarmonyOS-Cases</a>/<a title="Cases" class="repository" target="" style="padding-bottom: 0px; margin-right: 4px" sa_evt="repoClick" sa_location="其他" sa_url="" sa_repo_id="32931089" href="/harmonyos-cases/cases">Cases</a></span><span class="project-badges"><style>
  .gitee-modal {
    width: 500px !important; }
</style>
</span>
<input type="hidden" name="project_title" id="project_title" value="HarmonyOS-Cases/Cases" />
</h2>
</div>
</div>
</div>
<div class='ui small modal long' id='modal-fork-project'>
<i class='icon-close iconfont close'></i>
<div class='header'>
Fork 仓库
</div>
<div class='content fork-project-content'>
<div class='fork-info-content'>
<div class='ui segment fork_project_loader'>
<div class='ui active inverted dimmer'>
<div class='ui text loader'>加载中</div>
</div>
</div>
</div>
</div>
<div class='actions fork-action d-flex-between hide'>
<div>
</div>
<div>
<a class='cancel'>&emsp;取消&emsp;</a>
<div class='ui disabled button orange ok'>&emsp;确认&emsp;</div>
</div>
</div>
</div>
<script>
  var title_import_url = "false";
  var title_post_url = "/harmonyos-cases/cases/update_import";
  var title_fork_url = "/harmonyos-cases/cases/sync_fork";
  var title_project_path = "cases";
  var title_p_name = "Cases";
  var title_p_id= "32931089";
  var title_description = "看置顶Issue，加入HarmonyOS NEXT应用开发案例交流微信群！";
  var title_form_authenticity_token = "i99DGVRkSoC/44iDlxP2ocdjaqgPKUmvvXC6v+PcChX/zRuU3GJNaOPSTAAelSP3un1CZFtP9yei9MgAwJvv3Q==";
  var watch_type = "unwatch";
  var checkFirst = false;

$('.js-project-watch').dropdown('set selected', watch_type);
$('.checkbox.sync-wiki').checkbox();
$('.checkbox.sync-prune').checkbox();
$('.checkbox.team-member-checkbox').checkbox();
</script>
<script>
  $(function () {
    // SemticUI 校验表单等地方要求直接return 值, 对异步支持非常不友好...
    // 从提交表单处 再用异步校验 ,控制是否提交
    var $modalFork = $('#modal-fork-project');
    var $okBtn = $modalFork.find('.ui.ok.button');
    var $currentTarget = null;
    var isSameProject = false;
  
    $('#fork-top-button, #fork-btm-button').on('click', function (e) {
      e.preventDefault();
      $modalFork.modal('show');
      setTimeout(function () {
        $.ajax({ url: '/harmonyos-cases/cases/fork_project_info' }).done(function () {
          // 自定义错误消息模板,  inline : true 每个输入框后面都插入消息提示, 而非集中到一处提醒
          $.fn.form.settings.templates.prompt = function (errors) {
            return $('<div />').addClass('ui error message custom prompt label').html(errors[0]);
          };
          // 表单的内容是异步传输的js动态生成的....
          var $repoForm = $('#modal-fork-project .repo-form');
          $repoForm.form({
            on: 'change',
            inline: true,
            fields: {
              projectName: {
                identifier: 'project-name',
                rules: [
                  {
                    type: 'empty',
                    prompt: "仓库名不能为空"
                  },
                  {
                    type: 'regExp',
                    value: window.giteeRegex.projectName,
                    prompt: "仓库名只允许包含中文、字母、数字或者下划线(_)、中划线(-)、英文句号(.)、加号(+)，必须以字母、数字或者点(.)开头，不能以下划线/中划线结尾，且长度为2~191个字符"
                  },
                  {
                    type: 'maxLength[255]',
                    prompt: "仓库名只允许包含中文、字母、数字或者下划线(_)、中划线(-)、英文句号(.)、加号(+)，必须以字母、数字或者点(.)开头，不能以下划线/中划线结尾，且长度为2~191个字符"
                  }
                ]
              },
              projectPath: {
                identifier: 'project-path',
                rules: [
                  {
                    type: 'empty',
                    prompt: "路径不能为空"
                  },
                  {
                    type: 'regExp',
                    value: window.giteeRegex.projectPath,
                    prompt: "路径只允许包含字母、数字或者下划线(_)、中划线(-)、英文句号(.)，必须以字母、数字或者点(.)开头，且长度为2~191个字符"
                  }
                ]
              }
            }
          });
  
          $modalFork.find('.namespace-img-area.ui.checkbox').checkbox({
            onChecked: function () {
              $currentTarget = $(this).closest('.ui.checkbox');
              // 当前选中的空间
              isSameProject = $currentTarget[0].hasAttribute('data-any-same-projects');
              var conflictProjectName = $currentTarget.data('conflict-project-title');
              var conflictProjectUrl = $currentTarget.data('conflict-project-url');
              var conflictProjectNameSpacePath = $currentTarget.data('conflict-namespace');
              var conflictPathType = $currentTarget.find('.path-type').text();
              // fork目标
              var targetProjectName = $currentTarget.data('target-project-name');
              var targetProjectPath = $currentTarget.data('target-project-path');
              // 命名空间名称(@xxx)
              var conflictNameSpaceName = $currentTarget.find('.path-name').text();
              var $forkTargetNamespace = $('.fork-target-namespace-area');
              var $forkTargetNamespaceItem = $(this).closest('.fork-target-namespace-item')
              // 冲突 显示修改表单
              if (isSameProject) {
                //$forkTargetNamespace.addClass('same-name-editing');
                $('.fork-target-namespace-item').removeClass('same-name-editing')
                $forkTargetNamespaceItem.addClass('same-name-editing')
                $forkTargetNamespace
                  .find('.conflict-namespace-name')
                  .attr('href', `/${conflictProjectNameSpacePath}`)
                  .text(conflictNameSpaceName);
                $forkTargetNamespace
                  .find('.conflict-path')
                  .attr('href', `${conflictProjectUrl}`)
                  .text(`${conflictProjectNameSpacePath}/${targetProjectPath}`);
                $forkTargetNamespace
                  .find('.prefix-path')
                  .text(`${window.location.origin}/${conflictProjectNameSpacePath}/`);
                $forkTargetNamespace
                  .find('.conflict-path-type')
                  .text(conflictPathType.toLowerCase())
                var $nameInput = $forkTargetNamespace.find('[name="project-name"]');
                var $pathInput = $forkTargetNamespace.find('[name="project-path"]');
                $nameInput.val(targetProjectName);
                $pathInput.val(targetProjectPath);
                checkFirst = true
                // 立即校验一次
                asyncValidateForkRepoForm();
              } else {
                $('.fork-target-namespace-item').removeClass('same-name-editing')
                $forkTargetNamespaceItem.addClass('same-name-editing');
              }
              $okBtn.removeClass('disabled');
            }
          });
        });
      }, 500);
    });
    // 异步校验
    function asyncValidateForkRepoForm (successCallback) {
      var $repoForm = $('#modal-fork-project .same-name-editing .repo-form');
      var $forkTargetNamespace = $('.fork-target-namespace-area .same-name-editing');
      var $nameInput = $forkTargetNamespace.find('[name="project-name"]');
      var $pathInput = $forkTargetNamespace.find('[name="project-path"]');
      var name = $nameInput.val().trim();
      var path = $pathInput.val().trim();
      var namespace = $currentTarget ? $currentTarget.data('conflict-namespace') : '';
      if (!name || !path) return;
      $okBtn.addClass('loading');
      $.ajax('/projects/check_fork_form', {
        type: 'get',
        data: { project_name: name, project_path: path, target_namespaces: namespace },
        success: function (data) {
          if (data.status == 0) {
            successCallback && successCallback();
          } else if (data.status == -1 && Array.isArray(data.conflict_keys)) {
            if (!checkFirst) {
              data.conflict_keys.includes('name') && $repoForm.form('add prompt', 'project-name', "已存在相同仓库名");
              data.conflict_keys.includes('path') && $repoForm.form('add prompt', 'project-path', "已存在相同路径");
            } else {
              data.conflict_keys.includes('name') && data.new_name && $nameInput.val(data.new_name);
              data.conflict_keys.includes('path') && data.new_path && $pathInput.val(data.new_path);
            }
          } else {
            Flash.error("校验失败");
          }
          checkFirst = false
        },
        error: function (err) {
          Flash.error(err.responseJSON.message);
        },
        complete: function () {
          $okBtn.removeClass('loading');
          // 添加提示 弹窗变高后 刷新弹窗位置
          $modalFork.modal('refresh');
        }
      });
    }
    function forkSubmit () {
      $modalFork.modal('hide');
      // 构造一些 input 用于表单提交
      var $form = $('<form></form>');
      var $input = $('<input type="hidden" name="authenticity_token" />');
      var $inputCheck = $('<input type="hidden" name="members" />');
      var $inputCheck2 = $('<input type="hidden" name="namespace_path" />');
      var checkedPath = $('.checkbox.checked > input[name=namespace_path]').val();
      // fork存在冲突, 修改后的表单:
      if (isSameProject) {
        // 获取最新表单数据
        var $forkTargetNamespace = $('.fork-target-namespace-area .same-name-editing');
        var name = $forkTargetNamespace.find('[name="project-name"]').val().trim();
        var path = $forkTargetNamespace.find('[name="project-path"]').val().trim();
        var $projectName = $('<input type="hidden" name="name" />');
        var $projectPath = $('<input type="hidden" name="path" />');
        $projectName.val(name);
        $projectPath.val(path);
        $form.append($projectName);
        $form.append($projectPath);
      }
      $form.hide();
      $form.attr('method', 'post');
      $form.attr('action', '/' + checkedPath + '/fork_project/harmonyos-cases%2Fcases');
      $input.attr('value', $('meta[name="csrf-token"]').attr('content'));
      $inputCheck.attr('value', $('.checkbox.checked > input[name=members]').val());
      $inputCheck2.attr('value', checkedPath);
      $form.append($input);
      $form.append($inputCheck);
      $form.append($inputCheck2);
      $form.appendTo('body');
      $form.submit();
    }
    $modalFork.modal({
      transition: 'fade',
      closable: true,
      centered: false,
      observeChanges:true,
      onApprove: function () {
        // 存在同名冲突时, 需要修改仓库信息, 再进行校验同名
        // 判断当前选中的空间类型, 用于决定是否需要修改路径仓库名,验证表单
        if (isSameProject) {
          var $repoForm = $('#modal-fork-project .same-name-editing .repo-form');
          $repoForm.form('validate form');
          var isRepoInfoValid = $repoForm.form('is valid'); // 前端校验通过
          // 由于是form提交和ajax检测结合..., 防止意外篡改 提交前必定校验一次, 通过后自动submit
          if (isRepoInfoValid) {
            // SemticUI add prompt 自定义验证连续执行太快, 会消失掉重复再出现再消失.
            setTimeout(function () {
              asyncValidateForkRepoForm(function () {
                forkSubmit();
              });
            }, 200);
          } else {
            $repoForm.form('validate form');
          }
        } else {
          // 正常 frok
          forkSubmit();
        }
        return false;
      }
    });
    $modalFork.find('.close-button').on('click', function () {
      $modalFork.modal('hide');
    });
  });
</script>
<style>
  i.loading, .icon-sync.loading {
    -webkit-animation: icon-loading 1.2s linear infinite;
    animation: icon-loading 1.2s linear infinite;
  }
  .qrcode_cs {
    float: left;
  }
  .check-sync-wiki {
    float: left;
    height: 28px;
    line-height: 28px;
  }
  .sync-wiki-warn {
    color: #e28560;
  }
</style>

<div class='git-project-nav'>
<div class='ui container'>
<div class='ui secondary pointing menu'>
<a class="item active " href="/harmonyos-cases/cases"><i class='iconfont icon-code'></i>
代码
</a><a class="item " href="/harmonyos-cases/cases/issues"><i class='iconfont icon-task'></i>
Issues
<span class='ui mini circular label'>
33
</span>
</a><a class="item " href="/harmonyos-cases/cases/pulls"><i class='iconfont icon-pull-request'></i>
Pull Requests
<span class='ui mini circular label'>
13
</span>
</a><a class="item " href="/harmonyos-cases/cases/wikis"><i class='iconfont icon-wiki'></i>
Wiki
</a><a class="item  " href="/harmonyos-cases/cases/graph/master"><i class='iconfont icon-statistics'></i>
统计
</a><a class="item " href="/harmonyos-cases/cases/gitee_go"><i class='iconfont icon-workflow'></i>
流水线
</a><div class='item'>
<div class='ui pointing top right dropdown git-project-service'>
<div>
<i class='iconfont icon-service'></i>
服务
<i class='dropdown icon'></i>
</div>
<div class='menu' style='display:none'>
<a class="item" href="/harmonyos-cases/cases/pages"><img src="/static/images/logo-en.svg" alt="Logo en" />
<div class='item-title'>
Gitee Pages
</div>
</a><a class="item" href="/harmonyos-cases/cases/quality_analyses?platform=sonar_qube"><img src="https://cn-assets.gitee.com/assets/sonar_mini-5e1b54bb9f6c951d97fb778ef623afea.png" alt="Sonar mini" />
<div class='item-title'>
质量分析
</div>
</a><a class="item" href="/harmonyos-cases/cases/gitee_scans"><img src="https://cn-assets.gitee.com/assets/giteescan-cd9ab4076bd751faf7e30888eb10f782.png" alt="Giteescan" />
<div class='item-title'>Gitee Scan</div>
</a><a class="item" target="_blank" href="https://gitee.com/help/articles/4193"><img src="https://cn-assets.gitee.com/assets/jenkins_for_gitee-554ec65c490d0f1f18de632c48acc4e7.png" alt="Jenkins for gitee" />
<div class='item-title'>
Jenkins for Gitee
</div>
</a><a class="item" target="_blank" href="https://gitee.com/help/articles/4318"><img src="https://cn-assets.gitee.com/assets/cloudbase-1197b95ea3398aff1df7fe17c65a6d42.png?20200925" alt="Cloudbase" />
<div class='item-title'>
腾讯云托管
</div>
</a><a class="item" target="_blank" href="https://gitee.com/help/articles/4330"><img src="https://cn-assets.gitee.com/assets/cloud_serverless-686cf926ced5d6d2f1d6e606d270b81e.png" alt="Cloud serverless" />
<div class='item-title'>
腾讯云 Serverless
</div>
</a><a class="item" href="/harmonyos-cases/cases/open_sca"><img src="https://cn-assets.gitee.com/assets/open_sca/logo-9049ced662b2f9936b8001e6f9cc4952.png" alt="Logo" />
<div class='item-title'>
悬镜安全
</div>
</a><a class="item" target="_blank" href="https://help.gitee.com/devops/connect/Aliyun-SAE"><img src="https://cn-assets.gitee.com/assets/SAE-f3aa9366a1e2b7fff4747402eb8f10c3.png" alt="Sae" />
<div class='item-title'>
阿里云 SAE
</div>
</a><a class="item" id="update-codeblitz-link" target="_blank" href="https://codeblitz.cloud.alipay.com/gitee/harmonyos-cases/cases/tree/master/docs/performance/performance-web-import.md"><img style="width:100px;margin-top:4px" src="https://cn-assets.gitee.com/assets/Codeblitz-8824e38875a106e16e29ff57ec977b08.png" alt="Codeblitz" />
<div class='item-title'>
Codeblitz
</div>
</a><button class='ui orange basic button quit-button' id='quiting-button'>
我知道了，不再自动展开
</button>
</div>
</div>
</div>
</div>
</div>
</div>
<script>
  $('.git-project-nav .ui.dropdown').dropdown({ action: 'nothing' });
  var gitee_reward_config = JSON.parse(localStorage.getItem('gitee_reward_config') || null) || false
  var $settingText = $('.setting-text')
  // 如果没有访问过
  if(!gitee_reward_config) $settingText.addClass('red-dot')
  $('.git-project-service').dropdown({
    on: 'click',
    action: 'nothing',
    onShow: function () {
      const branch = 'master'
      let newUrl = `https://codeblitz.cloud.alipay.com/gitee/harmonyos-cases/cases/tree/`
      const url = decodeURIComponent(window.location.pathname);
      const startIndex = url.indexOf('master');
      if (startIndex !== -1) {
        newUrl = newUrl + url.substring(startIndex); // 从分支名开始截取
      }else{
        newUrl = newUrl + branch
      }
      const linkElement = document.getElementById("update-codeblitz-link");
      linkElement.setAttribute("href", newUrl);
    },
  })
</script>
<style>
  .git-project-nav i.checkmark.icon {
    color: green;
  }
  #quiting-button {
    display: none;
  }

.git-project-nav .dropdown .menu.hidden:after {
visibility: hidden !important;
}
</style>
<script>
  isSignIn = true
  isClickGuide = true
  $('#git-versions.dropdown').dropdown();
  $.ajax({
    url:"/harmonyos-cases/cases/access/add_access_log",
    type:"GET"
  });
  $('#quiting-button').on('click',function() {
    $('.git-project-service').click();
    if (isSignIn) {
      $.post("/projects/set_service_guide")
    }
    $.cookie("Serve_State", true, { expires: 3650, path: '/'})
    $('#quiting-button').hide();
  });
  if (!(isClickGuide || $.cookie("Serve_State") == 'true')) {
    $('.git-project-service').click()
    $('#quiting-button').show()
  }
</script>

</div>
<div class='ui container'>

<div class='git-project-content-wrapper'>

<div class='ui grid' id='project-wrapper'>
<div class='sixteen wide column' id='git-project-container'>
<div class='git-project-content' id='git-project-content'>
<div class='row'>
<div class='git-project-desc-wrapper'>
<script>
  $('.git-project-desc-wrapper .ui.dropdown').dropdown();
  if (false) {
    gon.project_new_blob_path = "/harmonyos-cases/cases/new/master/docs/performance/performance-web-import.md"
    bindShowModal({
      el: $('.no-license .project-license__create'),
      complete: function(data, modal) {
        if (!data.haveNoChoice && !data.data) {
          Flash.show('请选择一项开源许可证')
        } else {
          location.href = gon.project_new_blob_path + '?license=' + data.data
        }
      },
      skip: function () {
        location.href = gon.project_new_blob_path + '?license'
      }
    });
  }

$(".project-admin-action-box .reject").click(function() {
var reason = $('[name=review-reject-reason]').val();
if (!reason) {
Flash.error('请选择不通过理由')
return
}
$.ajax({
type: 'POST',
url: "/admin/shumei_content/shumei_check/reject_project_public",
data: {
reason: reason,
status: 'rejected',
project_id: 32931089
},
success: function(result){
if(result.status == 'success'){
window.location.reload();
}else{
Flash.error(result.message)
}
}
})
})

$(".project-admin-action-box .approve").click(function(){

    $.ajax({
      type: 'POST',
      url: "/admin/shumei_content/shumei_check/reject_project_public",
      data: {
        status: 'approved',
        project_id: 32931089
      },
      success: function(result){
        if(result.status == 'success'){
          window.location.reload();
        }else{
          Flash.error(result.message)
        }
      }
    })
})

$(".project-admin-action-box .waiting").click(function(){

    $.ajax({
      type: 'POST',
      url: "/admin/shumei_content/shumei_check/reject_project_public",
      data: {
        status: 'waiting',
        project_id: 32931089
      },
      success: function(result){
        if(result.status == 'success'){
          window.location.reload();
        }else{
          Flash.error(result.message)
        }
      }
    })
})

$('i.help.circle.icon').popup({
popup: '.no-license .ui.popup',
position: 'right center'
});

$('#remove-no-license-message').on('click', function() {
$.cookie("skip_repo_no_license_message_32931089", 'hide', { expires: 365 });
$('#user-no-license-message').hide();
return;
});
</script>
</div>

</div>
<div class='git-project-bread' id='git-project-bread'>
<div class='ui horizontal list mr-1'>
<div class='item git-project-branch-item'>
<input type="hidden" name="path" id="path" value="docs/performance/performance-web-import.md" />
<div class='ui top left pointing dropdown gradient button dropdown-has-tabs' id='git-project-branch'>
<input type="hidden" name="ref" id="ref" value="master" />
<div class='default text'>
master
</div>
<i class='dropdown icon'></i>
<div class='menu'>
<div class='ui left icon input'>
<i class='iconfont icon-search dropdown-search-icon'></i>
<input class='search-branch' placeholder='搜索分支' type='text'>
</div>
<div class='tab-menu project-branch-tab-menu'>
<div class='tab-menu-actions d-align-center'>
<div class='tab-menu-action' data-tab='branches'>
<a class="ui link button" href="/harmonyos-cases/cases/branches">管理</a>
</div>
<div class='tab-menu-action' data-tab='tags'>
<a class="ui link button" href="/harmonyos-cases/cases/tags">管理</a>
</div>
</div>
<div class='tab-menu-item' data-placeholder='搜索分支' data-tab='branches'>
分支 (5)
</div>
<div class='tab-menu-item' data-placeholder='搜索标签' data-tab='tags'>
标签 (4)
</div>
</div>
<div class='tab scrolling menu' data-tab='branches' id='branches_panel'>
<div data-value="master" class="item"><span>master</span></div>
<div data-value="4.1" class="item"><span>4.1</span></div>
<div data-value="revert-b89f3bb" class="item"><span>revert-b89f3bb</span></div>
<div data-value="revert-f1264dc" class="item"><span>revert-f1264dc</span></div>
<div data-value="revert-merge-103-master" class="item"><span>revert-merge-103-master</span></div>
</div>
<div class='tab scrolling menu' data-tab='tags' id='tags_panel'>
<div class='item' data-value='0.0.4'>0.0.4</div>
<div class='item' data-value='v0.0.3'>v0.0.3</div>
<div class='item' data-value='v0.0.2'>v0.0.2</div>
<div class='item' data-value='v0.0.1'>v0.0.1</div>
</div>
</div>
</div>
<style>
  .iconfont.icon-shieldlock {
    color: #8c92a4;
  }
  .dropdown-search-icon {
    position: absolute;
    top: 8px;
    left: 11px;
  }
</style>
<style>
  #git-project-branch .project-branch-tab-menu {
    width: 400px !important;
    margin: 0 16px !important;
    padding-left: 0px !important;
    padding-right: 0px !important;
    border-bottom: 1px solid #dfe3e9 !important; }
  #git-project-branch .tab-menu-actions {
    position: absolute;
    right: 0px !important;
    bottom: 0.357em; }
  #git-project-branch .tab-menu-action {
    position: relative !important;
    right: 0px !important;
    bottom: 0px !important; }
  #git-project-branch .menu::after {
    display: none !important; }
</style>
<script>
  var $branchesDropdown = $('#branches_panel');
  var $tagsDropdown = $('#tags_panel');
  var $searchNameInput = $('.search-branch');
  var concurrentRequestLock = false;
  var filterXSS = window.filterXSS;
  var search_text = "";
  var branch_page_number = 1;
  var branch_total_pager = Math.ceil(5 / 20) || 1

var flag_is_loading = false;
var flag_page_number = 1;
var flag_total_pager = Math.ceil(4 / 20) || 1

$branchesDropdown.scroll(function() {
var branchesPanel = document.getElementById('branches_panel');
var numOfBranches = $branchesDropdown.children().length;
if (branchesPanel.clientHeight + branchesPanel.scrollTop + 37 > branchesPanel.scrollHeight && numOfBranches < 5) {
debounceLoadMoreBranches.call();
}
});
function resetFlagVal() {
flag_is_loading = false;
flag_page_number = 1;
flag_total_pager = 1;

    concurrentRequestLock = false
    search_text = "";
    branch_page_number = 1;
    branch_total_pager = 1
}
$searchNameInput.on('input', window.globalUtils.debouce(function (e) {
resetFlagVal()
var $currentTab = $('.tab-menu-action.active');
var numOfBranches = $branchesDropdown.children().length;
var searchWord = $searchNameInput.val().trim();
search_text = searchWord
if($currentTab.data('tab') === 'branches') {
if (searchWord !== "") {
loadData(searchWord,1);
} else {
loadData();
}
}
var numOfTags = $tagsDropdown.children().length;
if($currentTab.data('tab') === 'tags') {
if (searchWord !== "") {
fetchTags(searchWord,1);
} else {
fetchTags();
}
}
}, 500));

function toggleNoResultView($popPanel) {
let no_data_html= `<div class='mt-1 mb-1 d-flex-center'> <span>暂无数据</span> </div>`
  $popPanel.append(no_data_html)
}
var debounceLoadMoreBranches = window.globalUtils.debouce(function () {
if (concurrentRequestLock) return;
branch_page_number += 1;
if (branch_page_number > branch_total_pager) return;
loadData(search_text, branch_page_number);
}, 350);

function loadData(search, page) {
if (concurrentRequestLock) { return; }
concurrentRequestLock = true;

    var searchParams = search || "";
    var pageParams = page || 1;
    $.ajax({
      url: "/" + gon.user_project + "/branches/names.json",
      type: 'GET',
      data: {
        search: searchParams,
        page: pageParams,
      },
      dataType: 'json',
      success: function (data) {
        branch_total_pager = data.total_pages;
        var html = '';
  
        if (pageParams === 1) {
          $branchesDropdown.empty();
        }
        data.branches.forEach(function (branch) {
          var protectRule = '';
          var branchName = filterXSS(branch.name);
          if(branch.branch_type.value === 1) {
            var rule = filterXSS(branch.protection_rule.wildcard);
            protectRule = `<i
                class="iconfont icon-shieldlock protected-branch-popup"
                data-title="受保护分支"
                data-content='保护规则： ${rule}'
              >
              </i>`
          }
          html += `<div data-value='${branchName}' class="item">
                    <span>${branchName}</span> ${protectRule}
                    </div>`
        });
        $branchesDropdown.append(html);
        $('.protected-branch-popup').popup()
        if (pageParams === 1 && data.count === 0) {
          toggleNoResultView($branchesDropdown);
        }
      },
      complete: function () {
        concurrentRequestLock = false;
      }
    });
}



$tagsDropdown.scroll(function() {
var tagsPanel = document.getElementById('tags_panel');
var numOfTags = $tagsDropdown.children().length;
if (tagsPanel.clientHeight + tagsPanel.scrollTop + 37 > tagsPanel.scrollHeight && numOfTags < 4) {
debounceLoadMore.call();
}
});
var debounceLoadMore = window.globalUtils.debouce(function () {
if (flag_is_loading) return;
flag_page_number += 1;
if (flag_page_number > flag_total_pager) return;
fetchTags(search_text, flag_page_number);
}, 350);

function fetchTags(search, page) {
var searchParams = search || "";
var pageParams = page || 1;

    if (flag_is_loading) return;
    flag_is_loading = true;
  
    $.ajax({
      url: "/" + gon.user_project + "/tags/names.json",
      data: {
        search: searchParams,
        page: pageParams,
      },
      type: "GET",
      xhrFields: {
        withCredentials: true,
      },
      success: function (data) {
        flag_total_pager = data.total_pages;
        if (pageParams === 1) {
          $tagsDropdown.html('');
        }
        data.tags.forEach((tag) => {
          const itemDiv = document.createElement('div');
          itemDiv.classList.add('item');
          itemDiv.setAttribute('data-value', tag.name);
          itemDiv.innerText = window.filterXSS(tag.name);
          $tagsDropdown.append(itemDiv)
        });
        if (pageParams === 1 && data.count === 0) {
          toggleNoResultView($tagsDropdown);
        }
      },
      error: function () {
      },
      complete: function () {
        flag_is_loading = false;
      },
    });
}
$('.project-branch-tab-menu').on('click','.tab-menu-item', function (e) {
var $currentTab = $(this).data('tab')
if($currentTab === 'branches') {
$searchNameInput.val('')
search_text = '';
loadData()
}
if($currentTab === 'tags') {
$searchNameInput.val('')
search_text = '';
fetchTags();
}
})
</script>

<script>
  $(function () {
    Gitee.initTabsInDropdown($('#git-project-branch').dropdown({
      fullTextSearch: true,
      selectOnKeydown: false,
      action: function (text,value,el) {
        var oItemOrInitObject = el[0] || el
        var isNotSelect = oItemOrInitObject.dataset.tab && oItemOrInitObject.dataset.tab === 'branches'
        if(isNotSelect){
          console.warn("You didn't choose a branch")
          return
        }
        var path = $('#path').val();
        var href = ['/harmonyos-cases/cases/tree', encodeURIComponent(value), path].join('/');
        window.location.href = href;
        return true
      },
      onNoResults: function (searchTerm) {
        //未找到结果
        return true
      },
    }));
    $('.protected-branch-popup').popup()
  })
</script>

</div>
</div>
<div class='git-project-right-actions pull-right'>
<div class='ui orange button' id='btn-dl-or-clone'>
克隆/下载
<i class='dropdown icon'></i>
</div>
<div class='ui small modal' id='git-project-download-panel'>
<i class='iconfont icon-close close'></i>
<div class='header'>
克隆/下载
</div>
<div class='content'>
<div class='ui secondary pointing menu mb-2 menu-container'>
<a class='item active' data-text='' data-type='http' data-url='https://gitee.com/harmonyos-cases/cases.git'>HTTPS</a>
<a class='item' data-text='' data-type='ssh' data-url='git@gitee.com:harmonyos-cases/cases.git'>SSH</a>
<a class='item' data-text="该仓库未启用SVN访问，请仓库管理员前往【&lt;a target='_blank' href=/harmonyos-cases/cases/settings#function&gt;仓库设置&lt;/a&gt;】开启。" data-type='svn' data-url=''>SVN</a>
<a class='item' data-text="该仓库未启用SVN访问，请仓库管理员前往【&lt;a target='_blank' href=/harmonyos-cases/cases/settings#function&gt;仓库设置&lt;/a&gt;】开启。" data-type='svn_ssh' data-url=''>SVN+SSH</a>
<a class="button-box ui basic orange button" sa_evt="repoDownload" sa_repo_id="32931089" sa_is_self="false" sa_is_member="false" href="/harmonyos-cases/cases/repository/archive/master.zip"><i class='icon download'></i>
下载ZIP
</a></div>
<div class='ui fluid right labeled small input download-url-panel mb-2'>
<input type="text" name="project_url_clone" id="project_url_clone" value="https://gitee.com/harmonyos-cases/cases.git" onclick="focus();select()" readonly="readonly" />
<div class='ui basic label copy-icon-box'>
<i class='icon iconfont icon-clone mr-0 btn-copy-clone' data-clipboard-target='#project_url_clone' id='btn-copy-project_clone_url1'></i>
</div>
</div>
<div class='tip-box mb-2'>
提示
</div>
<div class='mb-1 clone-url-title'>
下载代码请复制以下命令到终端执行
</div>
<div class='ui fluid right labeled small input download-url-panel mb-2'>
<input type="text" name="project_clone_url" id="project_clone_url" value="https://gitee.com/harmonyos-cases/cases.git" onclick="focus();select()" readonly="readonly" />
<div class='ui basic label copy-icon-box'>
<i class='icon iconfont icon-clone mr-0 btn-copy-clone' data-clipboard-target='#project_clone_url' id='btn-copy-project_clone_url'></i>
</div>
</div>
<div class='ui fluid right labeled warning-text forbid-warning-text'>

</div>
<div class='http-ssh-item mb-2'>
<div>
为确保你提交的代码身份被 Gitee 正确识别，请执行以下命令完成配置
</div>
<div class='textarea-box mt-2'>
<textarea class='textarea-content-box' id='global-config-clone' readonly>git config --global user.name 'test073001' &#10git config --global user.email 'shishuoxin@oschina.cn'</textarea>
<i class='icon iconfont icon-clone mr-2 btn-copy-clone text-dark' data-clipboard-target='#global-config-clone' id='btn-copy-global-config'></i>
</div>
</div>
<div class='ssh-item item-panel-box'>
<div class='mb-2'>
初次使用 SSH 协议进行代码克隆、推送等操作时，需按下述提示完成 SSH 配置
</div>
<div class='mb-1'>
<span>1</span>
生成 RSA 密钥
</div>
<div class='ui fluid right labeled small input mb-2'>
<input type="text" name="ssh_keygen_clone" id="ssh_keygen_clone" value="ssh-keygen -t rsa" onclick="focus();select()" readonly="readonly" />
<div class='ui basic label copy-icon-box'>
<i class='icon iconfont icon-clone mr-0 btn-copy-clone' data-clipboard-target='#ssh_keygen_clone' id='btn-copy-ssh_keygen'></i>
</div>
</div>
<div class='mb-1'>
<span>2</span>
获取 RSA 公钥内容，并配置到<a href='/profile/sshkeys' target="_blank"> SSH公钥 </a> 中
</div>
<div class='ui fluid right labeled small input mb-2'>
<input type="text" name="id_rsa_clone" id="id_rsa_clone" value="cat ~/.ssh/id_rsa.pub" onclick="focus();select()" readonly="readonly" />
<div class='ui basic label copy-icon-box'>
<i class='icon iconfont icon-clone mr-0 btn-copy-clone' data-clipboard-target='#id_rsa_clone' id='btn-copy-d_rsa'></i>
</div>
</div>
</div>
<div class='svn-item item-panel-box'>
<div class='mb-1 mt-2'>
在 Gitee 上使用 SVN，请访问<a href='https://help.gitee.com/enterprise/code-manage/%E4%BB%A3%E7%A0%81%E6%89%98%E7%AE%A1/%E4%BB%A3%E7%A0%81%E4%BB%93%E5%BA%93/Gitee%20SVN%E6%94%AF%E6%8C%81' target="_blank"> 使用指南 </a>
</div>
</div>
<div class='http-item item-panel-box'>
<div class='mb-2 mt-2'>
使用 HTTPS 协议时，命令行会出现如下账号密码验证步骤。基于安全考虑，Gitee 建议<a href='/profile/personal_access_tokens' target="_blank"> 配置并使用私人令牌 </a>替代登录密码进行克隆、推送等操作
</div>
<div>
Username for 'https://gitee.com': test073001_admin_admin_admin_admin
</div>
<div class='mb-1'>
<span>
Password for 'https://test073001_admin_admin_admin_admin@gitee.com':
</span>
<span>
私人令牌
</span>
</div>
</div>

</div>
</div>
<style>
  #git-project-download-panel {
    top: 90px !important; }
    #git-project-download-panel input {
      color: #40485b !important; }
    #git-project-download-panel .textarea-box {
      width: 100%;
      height: 60px;
      color: #9d9d9d;
      border-radius: 2px;
      background-color: #F5F5F5 !important;
      display: -webkit-box;
      display: -ms-flexbox;
      display: flex;
      -webkit-box-align: center;
          -ms-flex-align: center;
              align-items: center; }
    #git-project-download-panel .menu-container {
      font-weight: bold;
      border-color: rgba(0, 0, 0, 0.1) !important;
      border-bottom: 1px solid rgba(0, 0, 0, 0.1) !important; }
      #git-project-download-panel .menu-container .item {
        padding: 7px 12px !important; }
    #git-project-download-panel .hr-item {
      color: rgba(39, 41, 43, 0.15) !important; }
    #git-project-download-panel .textarea-content-box {
      width: 100%;
      height: 60px;
      resize: none;
      border: 0px !important;
      background-color: #F5F5F5 !important;
      color: #40485b !important; }
    #git-project-download-panel .btn-copy-clone {
      cursor: pointer;
      color: rgba(0, 0, 0, 0.87) !important; }
    #git-project-download-panel .copy-icon-box {
      background-color: #F5F5F5 !important;
      border-left: 0px !important; }
    #git-project-download-panel .button-box {
      border: 0px !important;
      float: right !important;
      padding-right: 0 !important; }
    #git-project-download-panel .tip-box {
      border-bottom: 1px solid rgba(0, 0, 0, 0.1) !important;
      padding-bottom: 4px;
      font-weight: 700; }
    #git-project-download-panel .popup-container {
      padding: 8px 12px 4px 12px;
      text-align: center;
      font-size: 14px; }
      #git-project-download-panel .popup-container .ok {
        margin: 12px auto;
        width: 25%;
        min-width: 125px;
        display: block; }
      #git-project-download-panel .popup-container .cancel {
        margin-left: 0; }
</style>
<script>
  $(function () {
    var $btnClone = $('#btn-dl-or-clone')
    var $modalDownload = $('#git-project-download-panel');
    var $input = $('#project_clone_url')
    var $inputUrl = $('#project_url_clone')
    var cloneUrlTitle= $('.clone-url-title')

    $('#btn-dl-or-clone').on('click', function (e) {
      e.preventDefault();
      $modalDownload.modal('show');
    })
  
    $modalDownload.find('.menu > .item').on('click', function(e) {
      var $item = $(this).addClass('active');
      $item.siblings().removeClass('active');
      var dataUrl = $item.attr('data-url');
      var cloneUrl = $item.attr('data-url');
      var dataType = $item.attr('data-type')
      var cloneToLocal = '下载代码请复制以下命令到终端执行'
      if(dataType=='http'){
        $modalDownload.find('.http-item').show();
        $('.content > .item-panel-box:not(.http-item)').hide();
        $modalDownload.find('.http-ssh-item').show();
        cloneUrl = 'git clone '+dataUrl
      }else if(dataType=='ssh'){
        $modalDownload.find('.ssh-item').show();
        $('.content > .item-panel-box:not(.ssh-item)').hide();
        $modalDownload.find('.http-ssh-item').show();
        cloneUrl = 'git clone '+dataUrl
      }else if(dataType=='svn') {
        $('.content > .item-panel-box:not(.svn-item)').hide();
        $modalDownload.find('.svn-item').show();
        $modalDownload.find('.http-ssh-item').hide();
        cloneUrl = 'svn checkout '+dataUrl
      }else {
        $('.content > .item-panel-box:not(.svn-item)').hide();
        $modalDownload.find('.svn-item').show();
        $modalDownload.find('.http-ssh-item').hide();
        cloneUrl = 'svn checkout '+dataUrl
      }
      if (dataUrl) {
        $modalDownload.find('.download-url-panel').show();
        $input.val(cloneUrl);
        $inputUrl.val(dataUrl)
        cloneUrlTitle.show();
        $modalDownload.find('.forbid-warning-text').html('');
      } else {
        $modalDownload.find('.download-url-panel').hide();
        //$modalDownload.find('.svn-item').hide();
        cloneUrlTitle.hide();
        $modalDownload.find('.forbid-warning-text').html($item.attr('data-text') || '');
      }
      $.cookie('remote_way', $item.attr('data-type'), { expires: 365, path: '/' });
    }).filter('[data-type="' + ($.cookie('remote_way') || 'http') + '"]').trigger('click');
  
    $('.btn-copy-clone').popup({
      content: '点击复制',
    }).on('click', function(e) {
      e.stopPropagation();
      return false;
    }).each(function(_, btnCopy) {
      var $btnCopy = $(btnCopy);
      new Clipboard(btnCopy).on('success', function() {
        $btnCopy.popup('destroy').popup({
          content: '已复制',
          on: 'manual'
        }).popup('show');
        setTimeout(function() {
          $btnCopy.popup('destroy').popup({
            content: '点击复制'
          });
        }, 2000);
      });
    });
    var $downloadBtn= $('.unlogin-download-btn')
    var $popupContainer = $('.popup-container')
    $downloadBtn.popup({
      popup : $('.custom.popup'),
      position   : 'bottom right',
    }).on('click', function(e) {
      $downloadBtn.popup('destroy').popup({
        popup : $('.custom.popup'),
        on: 'manual',
        position   : 'bottom right',
      }).popup('show');
      setTimeout(function() {
        $downloadBtn.popup('hide');
      }, 2000);
  
    })
})
</script>

</div>
<div class='d-inline pull-right' id='git-project-root-actions'>
<div class='ui horizontal list repo-action-list d-flex d-align-center repo-action-list-right'>
<div class='item search-box-container'>
<div class='ui icon input search-input' id='search-box'>
<input class='search-file-name' id='search-file-name' maxlength='40' placeholder='搜索文件' type='text'>
</div>
<a class='d-flex d-align-center' id='search-file-btn'>
<span class='iconify' data-icon='gitee:search' style='font-size: 16px;color:#979CAC;margin-right:10px'></span>
</a>
<div class='filter-file-container' style='display: none;'></div>
</div>
<script>
  $('#git-tree-file').dropdown({
    action: 'hide',
    onHide: function () {
      $('.plus-box').removeClass('click-active')
    },
    onShow: function () {
      $('.plus-box').addClass('click-active')
    }
  });
  $('.disabled-upload-readonly').popup({
    content: "只读目录不允许上传文件",
    className: {
      popup: 'ui popup',
    },
    position: 'bottom center',
  })
  $('.disabled-create-folder').popup({
    content: "只读目录不允许创建目录",
    className: {
      popup: 'ui popup',
    },
    position: 'bottom center',
  })
  $('.disabled-create-file').popup({
    content: "只读目录不允许创建文件",
    className: {
      popup: 'ui popup',
    },
    position: 'bottom center',
  })
  $('.disabled-create-submodule').popup({
    content: "只读目录不允许创建子模块",
    className: {
      popup: 'ui popup',
    },
    position: 'bottom center',
  })
  $('.disabled-upload-readonly, .disabled-create-folder, .disabled-create-file, .disabled-create-submodule').click(function() {
    return false
  })
</script>
<style>
  .disabled-upload-readonly, .disabled-create-file, .disabled-create-folder, .disabled-create-submodule {
    background-color: #dcddde !important;
    color: rgba(0, 0, 0, 0.4) !important;
    opacity: 0.3 !important;
    background-image: none !important;
    -webkit-box-shadow: none !important;
            box-shadow: none !important; }
</style>

<div class='item toschina-content__hidden webIDE-box' data-content='Web IDE'>
<a class="ui d-flex d-align-center webide ml-1" target="_blank" href="/-/ide/project/harmonyos-cases/cases/edit/master/-/docs/performance/performance-web-import.md"><span class='iconify' data-icon='gitee:computer' style='font-size: 16px;color:#979CAC;margin-right:12px'></span>
</a></div>
</div>
<script>
  $('.webIDE-box').popup()
</script>
<script src="https://cn-assets.gitee.com/assets/file_search/app-7488efdce7782c80c4936145b910d07e.js"></script>

</div>
<div class='breadcrumb_path path-breadcrumb-contrainer' id='git-project-breadcrumb'>
<div class='ui breadcrumb path project-path-breadcrumb' id='path-breadcrumb'>
<a data-direction="back" class="section repo-name" style="font-weight: bold" href="/harmonyos-cases/cases/tree/master">cases
</a><div class='divider'>
/
</div>
<strong>
<a data-direction="back" class="section" href="/harmonyos-cases/cases/tree/master/docs"><span class='cblue'>
docs
</span>
</a></strong>
<div class='divider'>
/
</div>
<strong>
<a data-direction="back" class="section" href="/harmonyos-cases/cases/tree/master/docs/performance"><span class='cblue'>
performance
</span>
</a></strong>
<div class='divider'>
/
</div>
<strong>
performance-web-import.md
</strong>
<i class='iconfont icon-clone' data-clipboard-text='docs/performance/performance-web-import.md' id='btn-copy-file-path'></i>
</div>
<style>
  #btn-copy-file-path {
    vertical-align: middle;
    cursor: pointer;
  }
</style>
<script>
  $btnCopy = $('#btn-copy-file-path')
  $btnCopy.popup({
    content: '复制路径'
  })

if ($btnCopy[0]) {
new Clipboard($btnCopy[0]).on('success', function() {
$btnCopy.popup('destroy').popup({
content: '已复制',
on: 'manual'
}).popup('show');
setTimeout(function () {
$btnCopy.popup('destroy').popup({
content: '复制路径'
});
}, 2000)
});
}
</script>


</div>
<div class='ui horizontal list repo-action-list branches-tags' style='display: none;'>
<div class='item'>
<a class="ui blank button" href="/harmonyos-cases/cases/branches"><i class='iconfont icon-branches'></i>
分支 5
</a></div>
<div class='item mr-3'>
<a class="ui blank button" href="/harmonyos-cases/cases/tags"><i class='iconfont icon-tag'></i>
标签 4
</a></div>
</div>
</div>
<script src="https://cn-assets.gitee.com/webpacks/parse_blob_form_scheme-c196873aa4bc8cd09e53.bundle.js"></script>
<script>
  if(window.gon.locale == 'en')
    $('.branches-tags').css('margin-top', '12px')
   // 仓库页面切换路径时: 刷新 yaml 错误检查
  $(window).on('pjax-complete:file-show', function () {
    window.parseBlobFormScheme && window.parseBlobFormScheme($('.js-blob-data').data('blob'));
  });
</script>

<style>
  .ui.dropdown .menu > .header {
    text-transform: none; }
</style>
<script>
  $(function () {
    var $tip = $('#apk-download-tip');
    if (!$tip.length) {
      return;
    }
    $tip.find('.btn-close').on('click', function () {
      $tip.hide();
    });
  });
  (function(){
    function pathAutoRender() {
      var $parent = $('#git-project-bread'),
          $child = $('#git-project-bread').children('.ui.horizontal.list'),
          mainWidth = 0;
      $child.each(function (i,item) {
        mainWidth += $(item).width()
      });
      $('.breadcrumb.path.fork-path').remove();
      if (mainWidth > 995) {
        $('#path-breadcrumb').hide();
        $parent.append('<div class="ui breadcrumb path fork-path">' + $('#path-breadcrumb').html() + '<div/>')
      } else {
        $('#path-breadcrumb').show();
      }
    }
    window.pathAutoRender = pathAutoRender;
    pathAutoRender();
  })();
</script>

<div class='row column tree-holder' id='tree-holder'>
<div class='tree-content-holder' id='tree-content-holder'>
<div class='file_holder'>
<div class='file_title'>
<div class='blob-header-title'>
<div class='blob-description'>
<i class="iconfont icon-file"></i>
<span class='file_name' title='performance-web-import.md'>
performance-web-import.md
</span>
<small>71.39 KB</small>
</div>
<div class='options'><div class='js-code-parsing code-parsing-btn ui pointing right top dropdown'>
<img class='' height='37' src='/static/images/ma_icon.svg' width='33'>
<div class='btn'>
<span>马建仓 AI 助手</span>
<i class='dropdown icon'></i>
</div>
<div class='menu ai-code-dropdown-box pt-1 pb-1'>
<span class='item' data-text='代码解读' data-value='parsing'>代码解读</span>
<span class='item' data-text='代码找茬' data-value='analysis'>代码找茬</span>
<span class='item' data-text='代码优化' data-value='optimize'>代码优化</span>
</div>
</div>
<div class='ui mini buttons basic'>
<textarea name="blob_raw" id="blob_raw" style="display:none;">
# Web组件开发性能提升指导&#x000A;&#x000A;## 简介&#x000A;&#x000A;开发者实现在应用中跳转显示网页需要分为两个方面：使用@ohos.web.webview提供Web控制能力；使用Web组件提供网页显示的能力。在实际应用中往往由于各种原因导致首次跳转Web网页或Web组件内跳转时出现白屏、卡顿等情况。本文介绍提升Web首页加载与Web网页间跳转速度的几种方法。&#x000A;&#x000A;## 优化思路&#x000A;&#x000A;用户在使用Web组件显示网页时往往会经历四个阶段：无反馈--&gt;白屏--&gt;网页渲染--&gt;完全展示，系统会在各个阶段内分别进行WebView初始化、建立网络连接、接受数据与渲染页面等操作，如图一所示是WebView的启动阶段。&#x000A;&#x000A;图一 Web组件显示页面的阶段&#x000A;&#x000A;![Web组件显示页面的阶段](./figures/web-display-stage.png)&#x000A;&#x000A;要优化Web组件的首页加载性能，可以从图例标记的三个阶段来进行优化：&#x000A;&#x000A;1. 在WebView的初始化阶段：应用打开WebView的第一步是启动浏览器内核，而这段时间由于WebView还不存在，所有后续的步骤是完全阻塞的。因此可以考虑在应用中预先完成初始化WebView，以及在初始化的同时通过预先加载组件内核、完成网络请求等方法，使得WebView初始化不是完全的阻塞后续步骤，从而减小耗时。&#x000A;2. 在建立连接阶段：当开发者提前知道访问的网页地址，我们可以预先建立连接，进行DNS预解析。&#x000A;3. 在接收资源数据阶段：当开发者预先知道用户下一页会点击什么页面的时候，可以合理使用缓存和预加载，将该页面的资源提前下载到缓存中。&#x000A;&#x000A;综上所述，开发者可以通过方法1和2来提升Web首页加载速度，在应用创建Ability的时候，在OnCreate阶段预先初始化内核。随后在onAppear阶段进行预解析DNS、预连接要加载的首页。  &#x000A;在网页跳转的场景，开发者也可以通过方法3，在onPageEnd阶段预加载下一个要访问的页面，提升Web网页间的跳转和显示速度，如图二所示。&#x000A;&#x000A;图二 Web组件的生命周期回调函数&#x000A;&#x000A;![Web组件的生命周期回调函数](./figures/web-life-cycle.png)&#x000A;&#x000A;## 优化方法&#x000A;&#x000A;### 提前初始化内核&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;当应用首次打开时，默认不会初始化浏览器内核，只有当创建WebView实例的时候，才会开始初始化浏览器内核。  &#x000A;为了能提前初始化WebView实例，@ohos.web.webview提供了initializeWebEngine方法。该方法实现在Web组件初始化之前，通过接口加载Web引擎的动态库文件，从而提前进行Web组件动态库的加载和Web内核主进程的初始化，最终以提高启动性能，减少白屏时间。  &#x000A;&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【反例】&#x000A;&#x000A;在未初始化Web内核前提下，启动加载Web页面&#x000A;&#x000A;```typescript&#x000A;import web_webview from &#39;@ohos.web.webview&#39;;&#x000A;import { hiTraceMeter } from &#39;@kit.PerformanceAnalysisKit&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: web_webview.WebviewController = new web_webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: &#39;https://www.example.com/example.html&#39;, controller: this.controller })&#x000A;        .fileAccess(true)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_enginee_un_init.png)&#x000A;&#x000A;&#x000A;【正例】&#x000A;&#x000A;在页面开始加载时，调用initializeWebEngine()接口初始化Web内核，具体步骤如下：&#x000A;&#x000A;1. 初始化Web内核&#x000A;&#x000A;```typescript&#x000A;// EntryAbility.ets&#x000A;import { UIAbility, AbilityConstant, Want } from &#39;@kit.AbilityKit&#39;;&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;export default class EntryAbility extends UIAbility {&#x000A;  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {&#x000A;    webview.WebviewController.initializeWebEngine();&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;2. 加载Web组件&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import web_webview from &#39;@ohos.web.webview&#39;;&#x000A;import { hiTraceMeter } from &#39;@kit.PerformanceAnalysisKit&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: web_webview.WebviewController = new web_webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: &#39;https://www.example.com/example.html&#39;, controller: this.controller })&#x000A;        .fileAccess(true)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_enginee_init.png)&#x000A;&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 直接加载Web页面  | 1264ms | 在加载Web组件时才初始化Web内核，增加启动时间 |&#x000A;| 提前初始化Web内核  | 1153ms | 加载页面时减少了Web内核初始化步骤，提高启动性能 |&#x000A;&#x000A;&#x000A;### 预解析DNS、预连接&#x000A;WebView在onAppear阶段进行预连接socket， 当Web内核真正发起请求的时候会直接复用预连接的socket，如果当前预解析还没完成，真正发起网络请求进行DNS解析的时候也会复用当前正在执行的DNS解析任务。同理即使预连接的socket还没有连接成功，Web内核也会复用当前正在连接中的socket，进而优化资源的加载过程。  &#x000A;@ohos.web.webview提供了prepareForPageLoad方法实现预连接url，在加载url之前调用此API，对url只进行DNS解析、socket建链操作，并不获取主资源子资源。  &#x000A;参数：&#x000A;&#x000A;| 参数名            | 类型      | 说明                                                                                        |&#x000A;|----------------|---------|-------------------------------------------------------------------------------------------|&#x000A;| url            | string  | 预连接的url。                                                                                  |&#x000A;| preconnectable | boolean | 是否进行预连接。如果preconnectable为true，则对url进行dns解析，socket建链预连接；如果preconnectable为false，则不做任何预连接操作。 |&#x000A;| numSockets     | number  | 要预连接的socket数。socket数目连接需要大于0，最多允许6个连接。              &#x000A;&#x000A;使用方法如下：&#x000A;&#x000A;```typescript&#x000A;// 开启预连接需要先使用上述方法预加载WebView内核。&#x000A;webview.WebviewController.initializeWebEngine();&#x000A;// 启动预连接，连接地址为即将打开的网址。&#x000A;webview.WebviewController.prepareForPageLoad(&quot;https://www.example.com&quot;, true, 2); &#x000A;```&#x000A;&#x000A;&#x000A;### 预加载下一页&#x000A;开发者可以在onPageEnd阶段进行预加载，当真正去加载下一个页面的时候，如果预加载已经成功，则相当于直接从缓存中加载页面资源，速度更快。一般来说能够准确预测到用户下一步要访问的页面的时候，可以进行预加载将要访问的页面，比如小说下一页， 浏览器在地址栏输入过程中识别到用户将要访问的页面等。  &#x000A;@ohos.web.webview提供prefetchPage方法实现在预测到将要加载的页面之前调用，提前下载页面所需的资源，包括主资源子资源，但不会执行网页JavaScript代码或呈现网页，以加快加载速度。  &#x000A;参数：&#x000A;&#x000A;| 参数名               | 类型               | 说明             |&#x000A;|-------------------|------------------|----------------|&#x000A;| url               | string           | 预加载的url。       |&#x000A;| additionalHeaders | Array&lt;WebHeader&gt; | url的附加HTTP请求头。 |&#x000A;&#x000A;使用方法如下：&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebBrowser.ets&#x000A;&#x000A;import webview from &#39;@ohos.web.webview&#39;;&#x000A;  // ...&#x000A;&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;    // ...&#x000A;    Web({ src: &#39;https://www.example.com&#39;, controller: this.controller })&#x000A;      .onPageEnd((event) =&gt; {&#x000A;        //  ...&#x000A;        // 在确定即将跳转的页面时开启预加载&#x000A;        this.controller.prefetchPage(&#39;https://www.example.com/nextpage&#39;);&#x000A;      })&#x000A;    Button(&#39;下一页&#39;)&#x000A;      .onClick(() =&gt; {&#x000A;        // ...&#x000A;        // 跳转下一页&#x000A;        this.controller.loadUrl(&#39;https://www.example.com/nextpage&#39;);&#x000A;      })&#x000A;```&#x000A;&#x000A;### 预渲染优化&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;预渲染优化适用于Web页面启动和跳转场景，例如，进入首页后，跳转到其他子页。与预连接、预下载不同的是，预渲染需要开发者额外创建一个新的ArkWeb组件，并在后台对其进行预渲染，此时该组件并不会立刻挂载到组件树上，即不会对用户呈现(组件状态为Hidden和InActive)，开发者可以在后续使用中按需动态挂载。&#x000A;&#x000A;具体原理如下图所示，首先需要定义一个自定义组件封装ArkWeb组件，该ArkWeb组件被离线创建，被包含在一个无状态的节点NodeContainer中，并与相应的NodeController绑定。该ArkWeb组件在后台完成预渲染后，在需要展示该ArkWeb组件时，再通过NodeController将其挂载到ViewTree的NodeContainer中，即通过NodeController绑定到对应的NodeContainer组件。预渲染通用实现的步骤如下：&#x000A;&#x000A;创建自定义ArkWeb组件：开发者需要根据实际场景创建封装一个自定义的ArkWeb组件，该ArkWeb组件被离线创建。&#x000A;创建并绑定NodeController：实现NodeController接口，用于自定义节点的创建、显示、更新等操作的管理。并将对应的NodeController对象放入到容器中，等待调用。&#x000A;绑定NodeContainer组件：将NodeContainer与NodeController进行绑定，实现动态组件页面显示。&#x000A;&#x000A;图三 预渲染优化原理图&#x000A;&#x000A;![](./figures/web-node-container.png)&#x000A;&#x000A;  &gt; 说明  &#x000A;  &gt; 预渲染相比于预下载、预连接方案，会消耗更多的内存、算力，仅建议针对高频页面使用，单应用后台创建的ArkWeb组件要求小于200个。&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;1. 创建载体，并创建ArkWeb组件&#x000A;    ```typescript&#x000A;    // 载体Ability&#x000A;    // EntryAbility.ets&#x000A;    import {createNWeb} from &quot;../pages/common&quot;&#x000A;    onWindowStageCreate(windowStage: window.WindowStage): void {&#x000A;      windowStage.loadContent(&#39;pages/Index&#39;, (err, data) =&gt; {&#x000A;        // 创建ArkWeb动态组件（需传入UIContext），loadContent之后的任意时机均可创建&#x000A;        createNWeb(&quot;https://www.example.com&quot;, windowStage.getMainWindowSync().getUIContext());&#x000A;        if (err.code) {&#x000A;          return;&#x000A;        }&#x000A;      });&#x000A;    }&#x000A;    ```&#x000A;2. 创建NodeContainer和对应的NodeController，渲染后台ArkWeb组件&#x000A;&#x000A;    ```typescript&#x000A;    // 创建NodeController&#x000A;    // common.ets&#x000A;    import { UIContext } from &#39;@kit.ArkUI&#39;;&#x000A;    import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;    import { NodeController, BuilderNode, Size, FrameNode }  from &#39;@kit.ArkUI&#39;;&#x000A;    // @Builder中为动态组件的具体组件内容&#x000A;    // Data为入参封装类&#x000A;    // 调用onActive，开启渲染&#x000A;    @Builder&#x000A;    function WebBuilder(data:Data) {&#x000A;      Column() {&#x000A;        Web({ src: data.url, controller: data.controller })&#x000A;          .onPageBegin(() =&gt; {&#x000A;            data.controller.onActive();&#x000A;          })&#x000A;          .width(&quot;100%&quot;)&#x000A;          .height(&quot;100%&quot;)&#x000A;      }&#x000A;    }&#x000A;    let wrap = wrapBuilder&lt;Data[]&gt;(WebBuilder);&#x000A;    // 用于控制和反馈对应的NodeContianer上的节点的行为，需要与NodeContainer一起使用&#x000A;    export class myNodeController extends NodeController {&#x000A;      private rootnode: BuilderNode&lt;Data[]&gt; | null = null;&#x000A;      // 必须要重写的方法，用于构建节点数、返回节点挂载在对应NodeContianer中&#x000A;      // 在对应NodeContianer创建的时候调用、或者通过rebuild方法调用刷新&#x000A;      makeNode(uiContext: UIContext): FrameNode | null {&#x000A;        console.info(&quot; uicontext is undifined : &quot;+ (uiContext === undefined));&#x000A;        if (this.rootnode != null) {&#x000A;          // 返回FrameNode节点&#x000A;          return this.rootnode.getFrameNode();&#x000A;        }&#x000A;        // 返回null控制动态组件脱离绑定节点&#x000A;        return null;&#x000A;      }&#x000A;      // 当布局大小发生变化时进行回调&#x000A;      aboutToResize(size: Size) {&#x000A;        console.info(&quot;aboutToResize width : &quot; + size.width  +  &quot; height : &quot; + size.height )&#x000A;      }&#x000A;      // 当controller对应的NodeContainer在Appear的时候进行回调&#x000A;      aboutToAppear() {&#x000A;        console.info(&quot;aboutToAppear&quot;)&#x000A;      }&#x000A;      // 当controller对应的NodeContainer在Disappear的时候进行回调&#x000A;      aboutToDisappear() {&#x000A;        console.info(&quot;aboutToDisappear&quot;)&#x000A;      }&#x000A;      // 此函数为自定义函数，可作为初始化函数使用&#x000A;      // 通过UIContext初始化BuilderNode，再通过BuilderNode中的build接口初始化@Builder中的内容&#x000A;      initWeb(url:string, uiContext:UIContext, control:WebviewController) {&#x000A;        if(this.rootnode != null)&#x000A;        {&#x000A;          return;&#x000A;        }&#x000A;        // 创建节点，需要uiContext&#x000A;        this.rootnode = new BuilderNode(uiContext)&#x000A;        // 创建动态Web组件&#x000A;        this.rootnode.build(wrap, { url:url, controller:control })&#x000A;      }&#x000A;    }&#x000A;    // 创建Map保存所需要的NodeController&#x000A;    let NodeMap:Map&lt;string, myNodeController | undefined&gt; = new Map();&#x000A;    // 创建Map保存所需要的WebViewController&#x000A;    let controllerMap:Map&lt;string, WebviewController | undefined&gt; = new Map();&#x000A;    // 初始化需要UIContext 需在Ability获取&#x000A;    export const createNWeb = (url: string, uiContext: UIContext) =&gt; {&#x000A;      // 创建NodeController&#x000A;      let baseNode = new myNodeController();&#x000A;      let controller = new webview.WebviewController() ;&#x000A;      // 初始化自定义Web组件&#x000A;      baseNode.initWeb(url, uiContext, controller);&#x000A;      controllerMap.set(url, controller)&#x000A;      NodeMap.set(url, baseNode);&#x000A;    }&#x000A;    // 自定义获取NodeController接口&#x000A;    export const getNWeb = (url : string) : myNodeController | undefined =&gt; {&#x000A;      return NodeMap.get(url);&#x000A;    }&#x000A;    ```&#x000A;3. 通过NodeContainer使用已经预渲染的页面&#x000A;&#x000A;    ```typescript&#x000A;    // 使用NodeController的Page页&#x000A;    // Index.ets&#x000A;    import {createNWeb, getNWeb} from &quot;./common&quot;&#x000A;    @Entry&#x000A;    @Component&#x000A;    struct Index {&#x000A;      build() {&#x000A;        Row() {&#x000A;          Column() {&#x000A;            // NodeContainer用于与NodeController节点绑定，rebuild会触发makeNode&#x000A;            // Page页通过NodeContainer接口绑定NodeController，实现动态组件页面显示&#x000A;            NodeContainer(getNWeb(&quot;https://www.example.com&quot;))&#x000A;              .height(&quot;90%&quot;)&#x000A;              .width(&quot;100%&quot;)&#x000A;          }&#x000A;          .width(&#39;100%&#39;)&#x000A;        }&#x000A;        .height(&#39;100%&#39;)&#x000A;      }&#x000A;    }&#x000A;    ```&#x000A;&#x000A;&#x000A;### 预取POST请求优化&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;预取POST请求适用于Web页面启动和跳转场景，当即将加载的Web页面中存在POST请求且POST请求耗时较长时，会导致页面加载时间增加，可以选择不同时机对POST请求进行预取，消除等待POST请求数据下载完成的耗时，具体有以下两种场景可供参考：&#x000A;&#x000A;1. 如果是应用首页，推荐在ArkWeb组件创建后或者提前初始化web内核后，对首页的POST请求进行预取，如onCreate、aboutToAppear。&#x000A;2. 当前页面完成加载后，可以对用户下一步可能点击页面的POST请求进行预取，推荐在Web组件的生命周期函数onPageEnd及后继时机进行。&#x000A;&#x000A;注意事项：&#x000A;&#x000A;1. 本方案能消除POST请求下载耗时，预计收益可能在百毫秒（依赖POST请求的数据内容和当前网络环境）。&#x000A;2. 预取POST请求行为包括连接和资源下载，连接和资源加载耗时可能达到百毫秒（依赖POST请求的数据内容和当前网络环境），建议开发者为预下载留出足够的时间。&#x000A;3. 预取POST请求行为相比于预连接会消耗额外的流量、内存，建议针对高频页面使用。&#x000A;4. POST请求具有一定的即时性，预取POST请求需要指定恰当的有效期。&#x000A;5. 目前仅支持预取Context-Type为application/x-www-form-urlencoded的POST请求。最多可以预获取6个POST请求。如果要预获取第7个，会自动清除最早预获取的POST缓存。开发者也可以通过clearPrefetchedResource()接口主动清除后续不再使用的预获取资源缓存。&#x000A;6. 如果要使用预获取的资源缓存，开发者需要在正式发起的POST请求的请求头中增加键值“ArkWebPostCacheKey”，其内容为对应缓存的cacheKey。&#x000A;&#x000A;&#x000A;#### 案例实践&#x000A;&#x000A;&#x000A;##### 场景一：加载包含POST请求的首页&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;当首页中包含POST请求，且POST请求耗时较长时，不推荐直接加载Web页面&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;  &#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: &#39;https://www.example.com/&#39;, controller: this.webviewController })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;通过预取POST加载包含POST请求的首页，具体步骤如下：&#x000A;&#x000A;1. 通过initializeWebEngine()来提前初始化Web组件的内核，然后在初始化内核后调用prefetchResource()预获取将要加载页面中的POST请求。&#x000A;&#x000A;```typescript&#x000A;// EntryAbility.ets&#x000A;import { UIAbility, AbilityConstant, Want } from &#39;@kit.AbilityKit&#39;;&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;export default class EntryAbility extends UIAbility {&#x000A;  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {&#x000A;    console.info(&#39;EntryAbility onCreate.&#39;);&#x000A;    webview.WebviewController.initializeWebEngine();&#x000A;    // 预获取时，需要将&quot;https://www.example1.com/POST?e=f&amp;g=h&quot;替换成为真实要访问的网站地址&#x000A;    webview.WebviewController.prefetchResource(&#x000A;      {&#x000A;        url: &#39;https://www.example.com/POST?e=f&amp;g=h&#39;,&#x000A;        method: &#39;POST&#39;,&#x000A;        formData: &#39;a=x&amp;b=y&#39;&#x000A;      },&#x000A;      [{&#x000A;        headerKey: &#39;c&#39;,&#x000A;        headerValue: &#39;z&#39;&#x000A;      }],&#x000A;      &#39;KeyX&#39;, 500&#x000A;    );&#x000A;    AppStorage.setOrCreate(&#39;abilityWant&#39;, want);&#x000A;    console.info(&#39;EntryAbility onCreate done.&#39;);&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;2. 通过Web组件，加载包含POST请求的Web页面&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;  &#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: &#39;https://www.example.com/&#39;, controller: this.webviewController })&#x000A;        .onPageEnd(() =&gt; {&#x000A;          // 清除后续不再使用的预获取资源缓存&#x000A;          webview.WebviewController.clearPrefetchedResource([&#39;KeyX&#39;]);&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;3. 在页面将要加载的JavaScript文件中，发起POST请求，设置请求响应头ArkWebPostCacheKey为对应预取时设置的cachekey值&#39;KeyX&#39;&#x000A;&#x000A;```typescript&#x000A;const xhr = new XMLHttpRequest();&#x000A;xhr.open(&#39;POST&#39;, &#39;https://www.example.com/POST?e=f&amp;g=h&#39;, true);&#x000A;xhr.setRequestHeader(&#39;Content-Type&#39;, &#39;application/x-www-form-urlencoded&#39;);&#x000A;xhr.setRequestHeader(&#39;ArkWebPostCacheKey&#39;, &#39;KeyX&#39;);&#x000A;xhr.onload = function () {&#x000A;  if (xhr.status &gt;= 200 &amp;&amp; xhr.status &lt; 300) {&#x000A;    console.info(&#39;成功&#39;, xhr.responseText);&#x000A;  } else {&#x000A;    console.error(&#39;请求失败&#39;);&#x000A;  }&#x000A;}&#x000A;const formData = new FormData();&#x000A;formData.append(&#39;a&#39;, &#39;x&#39;);&#x000A;formData.append(&#39;b&#39;, &#39;y&#39;);&#x000A;xhr.send(formData);&#x000A;```&#x000A;&#x000A;&#x000A;##### 场景二：加载包含POST请求的下一页&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;当即将加载的Web页面中包含POST请求，且POST请求耗时较长时，不推荐直接加载Web页面&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      // 在适当的时机加载业务用Web组件，本例以Button点击触发为例&#x000A;      Button(&#39;加载页面&#39;)&#x000A;        .onClick(() =&gt; {&#x000A;          // url请替换为真实地址&#x000A;          this.controller.loadUrl(&#39;https://www.example1.com/&#39;);&#x000A;        })&#x000A;      Web({ src: &#39;https://www.example.com/&#39;, controller: this.webviewController })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;通过预取POST加载包含POST请求的下一个跳转页面，具体步骤如下：&#x000A;&#x000A;1. 当前页面完成显示后，使用onPageEnd()对即将要加载页面中的POST请求进行预获取。&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      // 在适当的时机加载业务用Web组件，本例以Button点击触发为例&#x000A;      Button(&#39;加载页面&#39;)&#x000A;        .onClick(() =&gt; {&#x000A;          // url请替换为真实地址&#x000A;          this.controller.loadUrl(&#39;https://www.example1.com/&#39;);&#x000A;        })&#x000A;      Web({ src: &#39;https://www.example.com/&#39;, controller: this.webviewController })&#x000A;        .onPageEnd(() =&gt; {&#x000A;          // 预获取时，需要将&quot;https://www.example1.com/POST?e=f&amp;g=h&quot;替换成为真实要访问的网站地址&#x000A;          webview.WebviewController.prefetchResource(&#x000A;            {&#x000A;              url: &#39;https://www.example1.com/POST?e=f&amp;g=h&#39;,&#x000A;              method: &#39;POST&#39;,&#x000A;              formData: &#39;a=x&amp;b=y&#39;&#x000A;            },&#x000A;            [{&#x000A;              headerKey: &#39;c&#39;,&#x000A;              headerValue: &#39;z&#39;&#x000A;            }],&#x000A;            &#39;KeyX&#39;, 500&#x000A;          );&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;2. 将要加载的页面中，js正式发起POST请求，设置请求响应头ArkWebPostCacheKey为对应预取时设置的cachekey值&#39;KeyX&#39;&#x000A;&#x000A;```typescript&#x000A;const xhr = new XMLHttpRequest();&#x000A;xhr.open(&#39;POST&#39;, &#39;https://www.example1.com/POST?e=f&amp;g=h&#39;, true);&#x000A;xhr.setRequestHeader(&#39;Content-Type&#39;, &#39;application/x-www-form-urlencoded&#39;);&#x000A;xhr.setRequestHeader(&#39;ArkWebPostCacheKey&#39;, &#39;KeyX&#39;);&#x000A;xhr.onload = function () {&#x000A;  if (xhr.status &gt;= 200 &amp;&amp; xhr.status &lt; 300) {&#x000A;    console.info(&#39;成功&#39;, xhr.responseText);&#x000A;  } else {&#x000A;    console.error(&#39;请求失败&#39;);&#x000A;  }&#x000A;}&#x000A;const formData = new FormData();&#x000A;formData.append(&#39;a&#39;, &#39;x&#39;);&#x000A;formData.append(&#39;b&#39;, &#39;y&#39;);&#x000A;xhr.send(formData);&#x000A;```&#x000A;&#x000A;&#x000A;### JSBridge优化&#x000A;&#x000A;#### 适用场景&#x000A;应用使用ArkTS、C++语言混合开发，或本身应用架构较贴近于小程序架构，自带C++侧环境，&#x000A;推荐使用ArkWeb在native侧提供的ArkWeb_ControllerAPI、ArkWeb_ComponentAPI实现JSBridge功能。&#x000A;![img.png](images/web_jsbridge_ets_ndk_compare.png)&#x000A;&#x000A;上图为具有普适性的小程序一般架构，其中逻辑层需要应用自带JavaScript运行时，本身已存在C++环境，通过native接口可直接在C++环境中完成与视图层（ArkWeb作为渲染器）的通信，无需再返回ArkTS环境调用JSBridge相关接口。&#x000A;![img.png](images/web_jsbridge_ets_ndk_compare_new.png)&#x000A;native JSBridge方案可以解决ArkTS环境的冗余切换，同时允许回调在非UI线程上报，避免造成UI阻塞。&#x000A;&#x000A;#### 案例实践&#x000A;&#x000A;【反例】&#x000A;&#x000A;使用ArkTS接口实现JSBridge通信。&#x000A;&#x000A;应用侧代码：&#x000A;```typescript&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;&#x000A;  aboutToAppear() {&#x000A;    // 配置Web开启调试模式&#x000A;    webview.WebviewController.setWebDebuggingAccess(true);&#x000A;  }&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Button(&#39;runJavaScript&#39;)&#x000A;        .onClick(() =&gt; {&#x000A;          console.info(&#39;现在时间是:&#39;+new Date().getTime())&#x000A;          // 前端页面函数无参时，将param删除。&#x000A;          this.webviewController.runJavaScript(&#39;htmlTest(param)&#39;);&#x000A;        })&#x000A;      Button(&#39;runJavaScriptCodePassed&#39;)&#x000A;        .onClick(() =&gt; {&#x000A;          // 传递runJavaScript侧代码方法。&#x000A;          this.webviewController.runJavaScript(`function changeColor(){document.getElementById(&#39;text&#39;).style.color = &#39;red&#39;}`);&#x000A;        })&#x000A;      Web({ src: $rawfile(&#39;index.html&#39;), controller: this.webviewController })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;前端页面代码：&#x000A;```html&#x000A;&lt;!DOCTYPE html&gt;&#x000A;&lt;html&gt;&#x000A;&lt;body&gt;&#x000A;&lt;button type=&quot;button&quot; onclick=&quot;callArkTS()&quot;&gt;Click Me!&lt;/button&gt;&#x000A;&lt;h1 id=&quot;text&quot;&gt;这是一个测试信息，默认字体为黑色，调用runJavaScript方法后字体为绿色，调用runJavaScriptCodePassed方法后字体为红色&lt;/h1&gt;&#x000A;&lt;script&gt;&#x000A;  // 调用有参函数时实现。&#x000A;  var param = &quot;param: JavaScript Hello World!&quot;;&#x000A;  function htmlTest(param) {&#x000A;    document.getElementById(&#39;text&#39;).style.color = &#39;green&#39;;&#x000A;    document.getElementById(&#39;text&#39;).innerHTML = &#39;现在时间：&#39;+new Date().getTime()&#x000A;    console.info(param);&#x000A;  }&#x000A;  // 调用无参函数时实现。&#x000A;  function htmlTest() {&#x000A;    document.getElementById(&#39;text&#39;).style.color = &#39;green&#39;;&#x000A;  }&#x000A;  // Click Me！触发前端页面callArkTS()函数执行JavaScript传递的代码。&#x000A;  function callArkTS() {&#x000A;    changeColor();&#x000A;  }&#x000A;&lt;/script&gt;&#x000A;&lt;/body&gt;&#x000A;&lt;/html&gt;&#x000A;```&#x000A;&#x000A;点击runJavaScript按钮后触发h5页面htmlTest方法，使得页面内容变更为当前时间戳，如下图所示：&#x000A;&#x000A;![img.png](images/web_jsbridge_h5_screen.png)&#x000A;&#x000A;![img.png](images/web_jsbridge_ets_screen.png)&#x000A;&#x000A;经过多轮测试，可以得出从点击原生button到h5触发htmlTest方法，耗时约7ms~9ms。&#x000A;&#x000A;【正例】&#x000A;&#x000A;使用NDK接口实现JSBridge通信。&#x000A;&#x000A;应用侧代码：&#x000A;```typescript&#x000A;import testNapi from &#39;libentry.so&#39;;&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;class testObj {&#x000A;  test(): string {&#x000A;    console.info(&#39;ArkUI Web Component&#39;);&#x000A;    return &quot;ArkUI Web Component&quot;;&#x000A;  }&#x000A;&#x000A;  toString(): void {&#x000A;    console.info(&#39;Web Component toString&#39;);&#x000A;  }&#x000A;}&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  webTag: string = &#39;ArkWeb1&#39;;&#x000A;  controller: webview.WebviewController = new webview.WebviewController(this.webTag);&#x000A;  @State testObjtest: testObj = new testObj();&#x000A;&#x000A;  aboutToAppear() {&#x000A;    console.info(&quot;aboutToAppear&quot;)&#x000A;    //初始化web ndk&#x000A;    testNapi.nativeWebInit(this.webTag);&#x000A;  }&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Row() {&#x000A;        Button(&#39;runJS hello&#39;)&#x000A;          .fontSize(12)&#x000A;          .onClick(() =&gt; {&#x000A;            console.info(&#39;start:----&gt;&#39;+new Date().getTime());&#x000A;            testNapi.runJavaScript(this.webTag, &quot;runJSRetStr(\&quot;&quot; + &quot;hello&quot; + &quot;\&quot;)&quot;);&#x000A;          })&#x000A;      }.height(&#39;20%&#39;)&#x000A;&#x000A;      Row() {&#x000A;        Web({ src: $rawfile(&#39;runJS.html&#39;), controller: this.controller })&#x000A;          .javaScriptAccess(true)&#x000A;          .fileAccess(true)&#x000A;          .onControllerAttached(() =&gt; {&#x000A;            console.info(this.controller.getWebId());&#x000A;          })&#x000A;      }.height(&#39;80%&#39;)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;hello.cpp作为应用C++侧业务逻辑代码：&#x000A;```C&#x000A;//注册对象及方法，发送脚本到H5执行后的回调，解析存储应用侧传过来的实例等代码逻辑这里不进行展示，开发者根据自身业务场景自行实现。&#x000A;&#x000A;// 发送JS脚本到H5侧执行&#x000A;static napi_value RunJavaScript(napi_env env, napi_callback_info info) {&#x000A;    size_t argc = 2;&#x000A;    napi_value args[2] = {nullptr};&#x000A;    napi_get_cb_info(env, info, &amp;argc, args, nullptr, nullptr);&#x000A;&#x000A;    // 获取第一个参数 webTag&#x000A;    size_t webTagSize = 0;&#x000A;    napi_get_value_string_utf8(env, args[0], nullptr, 0, &amp;webTagSize);&#x000A;    char *webTagValue = new (std::nothrow) char[webTagSize + 1];&#x000A;    size_t webTagLength = 0;&#x000A;    napi_get_value_string_utf8(env, args[0], webTagValue, webTagSize + 1, &amp;webTagLength);&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;, &quot;ndk OH_NativeArkWeb_RunJavaScript webTag:%{public}s&quot;,&#x000A;                 webTagValue);&#x000A;&#x000A;    // 获取第二个参数 jsCode&#x000A;    size_t bufferSize = 0;&#x000A;    napi_get_value_string_utf8(env, args[1], nullptr, 0, &amp;bufferSize);&#x000A;    char *jsCode = new (std::nothrow) char[bufferSize + 1];&#x000A;    size_t byteLength = 0;&#x000A;    napi_get_value_string_utf8(env, args[1], jsCode, bufferSize + 1, &amp;byteLength);&#x000A;&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;,&#x000A;                 &quot;ndk OH_NativeArkWeb_RunJavaScript jsCode len:%{public}zu&quot;, strlen(jsCode));&#x000A;&#x000A;    // 构造runJS执行的结构体&#x000A;    ArkWeb_JavaScriptObject object = {(uint8_t *)jsCode, bufferSize, &amp;JSBridgeObject::StaticRunJavaScriptCallback,&#x000A;                                     static_cast&lt;void *&gt;(jsbridge_object_ptr-&gt;GetWeakPtr())};&#x000A;    controller-&gt;runJavaScript(webTagValue, &amp;object);&#x000A;    return nullptr;&#x000A;}&#x000A;&#x000A;EXTERN_C_START&#x000A;static napi_value Init(napi_env env, napi_value exports) {&#x000A;    napi_property_descriptor desc[] = {&#x000A;        {&quot;nativeWebInit&quot;, nullptr, NativeWebInit, nullptr, nullptr, nullptr, napi_default, nullptr},&#x000A;        {&quot;runJavaScript&quot;, nullptr, RunJavaScript, nullptr, nullptr, nullptr, napi_default, nullptr},&#x000A;    };&#x000A;    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);&#x000A;    return exports;&#x000A;}&#x000A;EXTERN_C_END&#x000A;&#x000A;static napi_module demoModule = {&#x000A;    .nm_version = 1,&#x000A;    .nm_flags = 0,&#x000A;    .nm_filename = nullptr,&#x000A;    .nm_register_func = Init,&#x000A;    .nm_modname = &quot;entry&quot;,&#x000A;    .nm_priv = ((void *)0),&#x000A;    .reserved = {0},&#x000A;};&#x000A;&#x000A;extern &quot;C&quot; __attribute__((constructor)) void RegisterEntryModule(void) { napi_module_register(&amp;demoModule); }&#x000A;```&#x000A;&#x000A;Native侧业务代码entry/src/main/cpp/jsbridge_object.h、entry/src/main/cpp/jsbridge_object.cpp&#x000A;详见[应用侧与前端页面的相互调用(C/C++)](https://gitee.com/openharmony/docs/blob/master/zh-cn/application-dev/web/arkweb-ndk-jsbridge.md)&#x000A;&#x000A;runJS.html作为应用前端页面：&#x000A;&#x000A;```html&#x000A;&lt;!DOCTYPE html&gt;&#x000A;&lt;html lang=&quot;en-gb&quot;&gt;&#x000A;&lt;head&gt;&#x000A;  &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;&#x000A;  &lt;title&gt;run javascript demo&lt;/title&gt;&#x000A;&lt;/head&gt;&#x000A;&lt;body&gt;&#x000A;&lt;h1&gt;run JavaScript Ext demo&lt;/h1&gt;&#x000A;&lt;p id=&quot;webDemo&quot;&gt;&lt;/p&gt;&#x000A;&lt;br&gt;&#x000A;&lt;button type=&quot;button&quot; style=&quot;height:30px;width:200px&quot; onclick=&quot;testNdkProxyObjMethod1()&quot;&gt;test ndk method1 ! &lt;/button&gt;&#x000A;&lt;br&gt;&#x000A;&lt;br&gt;&#x000A;&lt;button type=&quot;button&quot; style=&quot;height:30px;width:200px&quot; onclick=&quot;testNdkProxyObjMethod2()&quot;&gt;test ndk method2 ! &lt;/button&gt;&#x000A;&lt;br&gt;&#x000A;&#x000A;&lt;/body&gt;&#x000A;&lt;script type=&quot;text/javascript&quot;&gt;&#x000A;&#x000A;  function testNdkProxyObjMethod1() {&#x000A;  &#x000A;    //校验ndk方法是否已经注册到window&#x000A;    if (window.ndkProxy == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy undefined&quot;&#x000A;      return &quot;objName undefined&quot;&#x000A;    }&#x000A;&#x000A;    if (window.ndkProxy.method1 == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy method1 undefined&quot;&#x000A;      return &quot;objName  test undefined&quot;&#x000A;    }&#x000A;&#x000A;    if (window.ndkProxy.method2 == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy method2 undefined&quot;&#x000A;      return &quot;objName  test undefined&quot;&#x000A;    }&#x000A;    &#x000A;    //调用ndk注册到window的method1方法，并将结果回显到p标签&#x000A;    var retStr = window.ndkProxy.method1(&quot;hello&quot;, &quot;world&quot;, [1.2, -3.4, 123.456], [&quot;Saab&quot;, &quot;Volvo&quot;, &quot;BMW&quot;, undefined], 1.23456, 123789, true, false, 0,  undefined);&#x000A;    document.getElementById(&quot;webDemo&quot;).innerHTML  = &quot;ndkProxy and method1 is ok, &quot; + retStr;&#x000A;  }&#x000A;  &#x000A;  function testNdkProxyObjMethod2() {&#x000A;  &#x000A;    //校验ndk方法是否已经注册到window&#x000A;    if (window.ndkProxy == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy undefined&quot;&#x000A;      return &quot;objName undefined&quot;&#x000A;    }&#x000A;&#x000A;    if (window.ndkProxy.method1 == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy method1 undefined&quot;&#x000A;      return &quot;objName  test undefined&quot;&#x000A;    }&#x000A;&#x000A;    if (window.ndkProxy.method2 == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy method2 undefined&quot;&#x000A;      return &quot;objName  test undefined&quot;&#x000A;    }&#x000A;&#x000A;    var student = {&#x000A;      name:&quot;zhang&quot;,&#x000A;      sex:&quot;man&quot;,&#x000A;      age:25&#x000A;    };&#x000A;    var cars = [student, 456, false, 4.567];&#x000A;    let params = &quot;[\&quot;{\\\&quot;scope\\\&quot;]&quot;;&#x000A;&#x000A;    //调用ndk注册到window的method2方法，并将结果回显到p标签&#x000A;    var retStr = window.ndkProxy.method2(&quot;hello&quot;, &quot;world&quot;, false, cars, params);&#x000A;    document.getElementById(&quot;webDemo&quot;).innerHTML  = &quot;ndkProxy and method2 is ok, &quot; + retStr;&#x000A;  }&#x000A;  &#x000A;  function runJSRetStr(data) {&#x000A;    const d = new Date();&#x000A;    let time = d.getTime();&#x000A;    document.getElementById(&quot;webDemo&quot;).innerHTML = new Date().getTime()&#x000A;    return JSON.stringify(time)&#x000A;  }&#x000A;&lt;/script&gt;&#x000A;&lt;/html&gt;&#x000A;```&#x000A;&#x000A;点击runJS hello按钮后触发h5页面runJSRetStr方法，使得页面内容变更为当前时间戳。&#x000A;&#x000A;![img.png](images/web_jsbridge_ndk_ets_screen.png)&#x000A;&#x000A;![img.png](images/web_jsbridge_ndk_h5_screen.png)&#x000A;&#x000A;经过多轮测试，可以得出从点击原生button到h5触发runJSRetStr方法，耗时约2ms~6ms。&#x000A;&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| **通信方式**            | **耗时(局限不同设备和场景，数据仅供参考)** | **说明**            |&#x000A;|---------------------|--------------------------|-------------------|&#x000A;| ArkWeb实现与前端页面通信     | 7ms~9ms                  | ArkTS环境冗余切换,耗时较长  |&#x000A;| ArkWeb、c++实现与前端页面通信 | 2ms~6ms                  | 避免ArkTS环境冗余切换，耗时短 |&#x000A;&#x000A;JSBridge优化方案适用于ArkWeb应用侧与前端网页通信场景，开发者可根据应用架构选择合适的业务通信机制：&#x000A;&#x000A;1.应用使用ArkTS语言开发，推荐使用ArkWeb在ArkTS提供的runJavaScriptExt接口实现应用侧至前端页面的通信，同时使用registerJavaScriptProxy实现前端页面至应用侧的通信。&#x000A;&#x000A;2.应用使用ArkTS、C++语言混合开发，或本身应用结构较贴近于小程序架构，自带C++侧环境，推荐使用ArkWeb在NDK侧提供的OH_NativeArkWeb_RunJavaScript及OH_NativeArkWeb_RegisterJavaScriptProxy接口实现JSBridge功能。&#x000A;&#x000A;&gt; 说明&#x000A;&gt; 开发者需根据当前业务区分是否存在C++侧环境（较为显著标志点为当前应用是否使用了Node API技术进行开发，若是则该应用具备C++侧环境）。&#x000A;&gt; 具备C++侧环境的应用开发，可使用ArkWeb提供的NDK侧JSBridge接口。&#x000A;&gt; 不具备C++侧环境的应用开发，可使用ArkWeb侧JSBridge接口。&#x000A;&#x000A;&#x000A;### 异步JSBridge调用&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;异步JSBridge调用适用于H5侧调用原生或C++侧注册得JSBridge函数场景下，将用户指定的JSBridge接口的调用抛出后，不等待执行结果，&#x000A;以避免在ArkUI主线程负载重时JSBridge同步调用可能导致Web线程等待IPC时间过长，从而造成阻塞的问题。&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;使用ArkTS接口实现JSBridge通信&#x000A;&#x000A;【案例一】&#x000A;&#x000A;步骤1.只注册同步函数&#x000A;```typescript&#x000A;import webview from &#39;@ohos.web.webview&#39;;&#x000A;// 定义ETS侧对象及函数&#x000A;class TestObj {&#x000A;  test(testStr:string): string {&#x000A;    let start = Date.now();&#x000A;    // 模拟耗时操作&#x000A;    for(let i = 0; i &lt; 500000; i++) {}&#x000A;    let end = Date.now();&#x000A;    console.info(&#39;objName.test start: &#39; + start);&#x000A;    return &#39;objName.test Sync function took &#39; + (end - start) + &#39;ms&#39;;&#x000A;  }&#x000A;  asyncTestBool(testBol:boolean): Promise&lt;string&gt; {&#x000A;    return new Promise((resolve, reject) =&gt; {&#x000A;      let start = Date.now();&#x000A;      // 模拟耗时操作（异步）&#x000A;      setTimeout(() =&gt; {&#x000A;        for(let i = 0; i &lt; 500000; i++) {}&#x000A;        let end = Date.now();&#x000A;        console.info(&#39;objAsyncName.asyncTestBool start: &#39; + start);&#x000A;        resolve(&#39;objName.asyncTestBool Async function took &#39; + (end - start) + &#39;ms&#39;);&#x000A;      }, 0); // 使用0毫秒延迟来模拟立即开始的异步操作&#x000A;    });&#x000A;  }&#x000A;}&#x000A;&#x000A;class WebObj {&#x000A;  webTest(): string {&#x000A;    let start = Date.now();&#x000A;    // 模拟耗时操作&#x000A;    for(let i = 0; i &lt; 500000; i++) {}&#x000A;    let end = Date.now();&#x000A;    console.info(&#39;objTestName.webTest start: &#39; + start);&#x000A;    return &#39;objTestName.webTest Sync function took &#39; + (end - start) + &#39;ms&#39;;&#x000A;  }&#x000A;  webString(): string {&#x000A;    let start = Date.now();&#x000A;    // 模拟耗时操作&#x000A;    for(let i = 0; i &lt; 500000; i++) {}&#x000A;    let end = Date.now();&#x000A;    console.info(&#39;objTestName.webString start: &#39; + start);&#x000A;    return &#39;objTestName.webString Sync function took &#39; + (end - start) + &#39;ms&#39;&#x000A;  }&#x000A;}&#x000A;&#x000A;class AsyncObj {&#x000A;&#x000A;  asyncTest(): Promise&lt;string&gt; {&#x000A;    return new Promise((resolve, reject) =&gt; {&#x000A;      let start = Date.now();&#x000A;      // 模拟耗时操作（异步）&#x000A;      setTimeout(() =&gt; {&#x000A;        for (let i = 0; i &lt; 500000; i++) {&#x000A;        }&#x000A;        let end = Date.now();&#x000A;        console.info(&#39;objAsyncName.asyncTest start: &#39; + start);&#x000A;        resolve(&#39;objAsyncName.asyncTest Async function took &#39; + (end - start) + &#39;ms&#39;);&#x000A;      }, 0); // 使用0毫秒延迟来模拟立即开始的异步操作&#x000A;    });&#x000A;  }&#x000A;&#x000A;  asyncString(testStr:string): Promise&lt;string&gt; {&#x000A;    return new Promise((resolve, reject) =&gt; {&#x000A;      let start = Date.now();&#x000A;      // 模拟耗时操作（异步）&#x000A;      setTimeout(() =&gt; {&#x000A;        for (let i = 0; i &lt; 500000; i++) {&#x000A;        }&#x000A;        let end = Date.now();&#x000A;        console.info(&#39;objAsyncName.asyncString start: &#39; + start);&#x000A;        resolve(&#39;objAsyncName.asyncString Async function took &#39; + (end - start) + &#39;ms&#39;);&#x000A;      }, 0); // 使用0毫秒延迟来模拟立即开始的异步操作&#x000A;    });&#x000A;  }&#x000A;}&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;  @State testObjtest: TestObj = new TestObj();&#x000A;  @State webTestObj: WebObj = new WebObj();&#x000A;  @State asyncTestObj: AsyncObj = new AsyncObj();&#x000A;  build() {&#x000A;    Column() {&#x000A;      Button(&#39;refresh&#39;)&#x000A;        .onClick(()=&gt;{&#x000A;          try{&#x000A;            this.controller.refresh();&#x000A;          } catch (error) {&#x000A;            console.error(`ErrorCode:${(error as BusinessError).code},Message:${(error as BusinessError).message}`)&#x000A;          }&#x000A;        })&#x000A;      Button(&#39;Register JavaScript To Window&#39;)&#x000A;        .onClick(()=&gt;{&#x000A;          try {&#x000A;            //只注册同步函数&#x000A;            this.controller.registerJavaScriptProxy(this.webTestObj,&quot;objTestName&quot;,[&quot;webTest&quot;,&quot;webString&quot;]);&#x000A;          } catch (error) {&#x000A;            console.error(`ErrorCode:${(error as BusinessError).code},Message:${(error as BusinessError).message}`)&#x000A;          }&#x000A;        })&#x000A;      Web({src: $rawfile(&#39;index.html&#39;),controller: this.controller}).javaScriptAccess(true)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;步骤2.H5侧调用JSBridge函数&#x000A;```html&#x000A;&lt;!DOCTYPE html&gt;&#x000A;&lt;html lang=&quot;en&quot;&gt;&#x000A;&lt;head&gt;&#x000A;  &lt;meta charset=&quot;UTF-8&quot;&gt;&#x000A;  &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;&#x000A;  &lt;title&gt;Document&lt;/title&gt;&#x000A;&lt;/head&gt;&#x000A;&lt;body&gt;&#x000A;&lt;button type=&quot;button&quot; onclick=&quot;htmlTest()&quot;&gt; Click Me!&lt;/button&gt;&#x000A;&lt;p id=&quot;demo&quot;&gt;&lt;/p&gt;&#x000A;&lt;p id=&quot;webDemo&quot;&gt;&lt;/p&gt;&#x000A;&lt;p id=&quot;asyncDemo&quot;&gt;&lt;/p&gt;&#x000A;&lt;/body&gt;&#x000A;&lt;script type=&quot;text/javascript&quot;&gt;&#x000A;  async function htmlTest() {&#x000A;    document.getElementById(&quot;demo&quot;).innerHTML = &#39;测试开始:&#39; + new Date().getTime() + &#39;\n&#39;;&#x000A;&#x000A;    const time1 = new Date().getTime()&#x000A;    objTestName.webString();&#x000A;    const time2 = new Date().getTime()&#x000A;&#x000A;    objAsyncName.asyncString()&#x000A;    const time3 = new Date().getTime()&#x000A;&#x000A;    objName.asyncTestBool()&#x000A;    const time4 = new Date().getTime()&#x000A;&#x000A;    objName.test();&#x000A;    const time5 = new Date().getTime()&#x000A;&#x000A;    objTestName.webTest();&#x000A;    const time6 = new Date().getTime()&#x000A;    objAsyncName.asyncTest()&#x000A;    const time7 = new Date().getTime()&#x000A;&#x000A;    const result = [&#x000A;      &#39;objTestName.webString()耗时：&#39;+ (time2 - time1),&#x000A;      &#39;objAsyncName.asyncString()耗时：&#39;+ (time3 - time2),&#x000A;      &#39;objName.asyncTestBool()耗时：&#39;+ (time4 - time3),&#x000A;      &#39;objName.test()耗时：&#39;+ (time5 - time4),&#x000A;      &#39;objTestName.webTest()耗时：&#39;+ (time6 - time5),&#x000A;      &#39;objAsyncName.asyncTest()耗时：&#39;+ (time7 - time6),&#x000A;    ]&#x000A;    document.getElementById(&quot;demo&quot;).innerHTML = document.getElementById(&quot;demo&quot;).innerHTML + &#39;\n&#39; + result.join(&#39;\n&#39;)&#x000A;  }&#x000A;&lt;/script&gt;&#x000A;&lt;/html&gt;&#x000A;```&#x000A;&#x000A;【案例二】&#x000A;&#x000A;步骤1.使用registerJavaScriptProxy或javaScriptProxy注册异步函数或异步同步共存&#x000A;```typescript&#x000A;//registerJavaScriptProxy方式注册&#x000A;Button(&#39;refresh&#39;)&#x000A;  .onClick(()=&gt;{&#x000A;    try{&#x000A;      this.controller.refresh();&#x000A;    } catch (error) {&#x000A;      console.error(`ErrorCode:${(error as BusinessError).code},Message:${(error as BusinessError).message}`)&#x000A;    }&#x000A;  })&#x000A;Button(&#39;Register JavaScript To Window&#39;)&#x000A;  .onClick(()=&gt;{&#x000A;    try {&#x000A;      //调用注册接口对象及成员函数，其中同步函数列表必填，空白则需要用[]占位；异步函数列表非必填&#x000A;      //同步、异步函数都注册&#x000A;      this.controller.registerJavaScriptProxy(this.testObjtest,&quot;objName&quot;,[&quot;test&quot;],[&quot;asyncTestBool&quot;]);&#x000A;      //只注册异步函数，同步函数列表处留空&#x000A;      this.controller.registerJavaScriptProxy(this.asyncTestObj,&quot;objAsyncName&quot;,[],[&quot;asyncTest&quot;,&quot;asyncString&quot;]);&#x000A;    } catch (error) {&#x000A;      console.error(`ErrorCode:${(error as BusinessError).code},Message:${(error as BusinessError).message}`)&#x000A;    }&#x000A;  })&#x000A;Web({src: $rawfile(&#39;index.html&#39;),controller: this.controller}).javaScriptAccess(true)&#x000A;&#x000A;//javaScriptProxy方式注册&#x000A;//javaScriptProxy只支持注册一个对象，若需要注册多个对象请使用registerJavaScriptProxy&#x000A;Web({src: $rawfile(&#39;index.html&#39;),controller: this.controller})&#x000A;  .javaScriptAccess(true)&#x000A;  .javaScriptProxy({&#x000A;    object: this.testObjtest,&#x000A;    name:&quot;objName&quot;,&#x000A;    methodList: [&quot;test&quot;,&quot;toString&quot;],&#x000A;    //指定异步函数列表&#x000A;    asyncMethodList: [&quot;test&quot;,&quot;toString&quot;],&#x000A;    controller: this.controller&#x000A;  })&#x000A;```&#x000A;&#x000A;步骤2.H5侧调用JSBridge函数与反例中一致&#x000A;&#x000A;#### 总结&#x000A;&#x000A;![img.png](images/web_jsbridge_async_compare.png)&#x000A;&#x000A;| **注册方法类型** | **耗时(局限不同设备和场景，数据仅供参考)** | **说明**        |&#x000A;|------------|--------------------------|---------------|&#x000A;| 同步方法       | 1398ms，2707ms，2705ms     | 同步函数调用会阻塞JS线程 |&#x000A;| 异步方法       | 2ms，2ms，4ms              | 异步函数调用不阻塞JS线程 |&#x000A;&#x000A;通过截图可看到async的异步方法不需要等待结果，所以在js单线程任务队列中不会长时间占用，同步任务需要等待原生主线程同步执行后返回结果。&#x000A;&#x000A;&gt;JSBridge接口在注册时，即会根据注册调用的接口决定其调用方式（同步/异步）。开发者需根据当前业务区分，&#x000A;&gt; 是否将其注册为异步函数。&#x000A;&gt;- 同步函数调用将会阻塞JS的执行，等待调用的JSBridge函数执行结束，适用于需要返回值，或者有时序问题等场景。&#x000A;&gt;- 异步函数调用时不会等待JSBridge函数执行结束，后续JS可在短时间后继续执行。但JSBridge函数无法直接返回值。&#x000A;&gt;- 注册在ETS侧的JSBridge函数调用时需要在主线程上执行；NDK侧注册的函数将在其他线程中执行。&#x000A;&gt;- 异步JSBridge接口与同步接口在JS侧的调用方式一致，仅注册方式不同，本部分调用方式仅作简要示范。&#x000A;&#x000A;附NDK接口实现JSBridge通信(C++侧注册异步函数):&#x000A;```c&#x000A;// 定义JSBridge函数&#x000A;static void ProxyMethod1(const char* webTag, void* userData) {&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;, &quot;Method1 webTag :%{public}s&quot;,webTag);&#x000A;}&#x000A;&#x000A;static void ProxyMethod2(const char* webTag, void* userData) {&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;, &quot;Method2 webTag :%{public}s&quot;,webTag);&#x000A;}&#x000A;&#x000A;static void ProxyMethod3(const char* webTag, void* userData) {&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;, &quot;Method3 webTag :%{public}s&quot;,webTag);&#x000A;}&#x000A;&#x000A;void RegisterCallback(const char *webTag) {&#x000A;    int myUserData = 100;&#x000A;    //创建函数方法结构体&#x000A;    ArkWeb_ProxyMethod m1 = {&#x000A;        .methodName = &quot;method1&quot;,&#x000A;        .callback = ProxyMethod1,&#x000A;        .userData = (void *)&amp;myUserData&#x000A;    };&#x000A;    ArkWeb_ProxyMethod m2 = {&#x000A;        .methodName = &quot;method2&quot;,&#x000A;        .callback = ProxyMethod2,&#x000A;        .userData = (void *)&amp;myUserData&#x000A;    };&#x000A;    ArkWeb_ProxyMethod m3 = {&#x000A;        .methodName = &quot;method3&quot;,&#x000A;        .callback = ProxyMethod3,&#x000A;        .userData = (void *)&amp;myUserData&#x000A;    };&#x000A;    ArkWeb_ProxyMethod methodList[2] = {m1,m2};&#x000A;    &#x000A;    //创建JSBridge对象结构体&#x000A;    ArkWeb_ProxyObject obj = {&#x000A;        .objName = &quot;ndkProxy&quot;,&#x000A;        .methodList = methodList,&#x000A;        .size = 2,&#x000A;    };&#x000A;    // 获取ArkWeb_Controller API结构体&#x000A;    ArkWeb_AnyNativeAPI* apis = OH_ArkWeb_GetNativeAPI(ArkWeb_NativeAPIVariantKind::ARKWEB_NATIVE_CONTROLLER);&#x000A;    ArkWeb_ControllerAPI* ctrlApi = reinterpret_cast&lt;ArkWeb_ControllerAPI*&gt;(apis);&#x000A;    &#x000A;        // 调用注册接口，注册函数&#x000A;        ctrlApi-&gt;registerJavaScriptProxy(webTag, &amp;obj);&#x000A;    &#x000A;    ArkWeb_ProxyMethod asyncMethodList[1] = {m3};&#x000A;    ArkWeb_ProxyObject obj2 = {&#x000A;        .objName = &quot;ndkProxy&quot;,&#x000A;    .methodList = asyncMethodList,&#x000A;    .size = 1,&#x000A;    };&#x000A;    ctrlApi-&gt;registerAsyncJavaScriptProxy(webTag, &amp;obj2)&#x000A;}&#x000A;```&#x000A;&#x000A;&#x000A;### 预编译JavaScript生成字节码缓存（Code Cache）&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;预编译JavaScript生成字节码缓存适用于在页面加载之前提前将即将使用到的JavaScript文件编译成字节码并缓存到本地，在页面首次加载时节省编译时间。&#x000A;&#x000A;开发者需要创建一个无需渲染的离线Web组件，用于进行预编译，在预编译结束后使用其他Web组件加载对应的业务网页。&#x000A;&#x000A;注意事项：&#x000A;&#x000A;1. 仅使用HTTP或HTTPS协议请求的JavaScript文件可以进行预编译操作。&#x000A;2. 不支持使用了ES6 Module的语法的JavaScript文件生成预编译字节码缓存。&#x000A;3. 通过配置参数中响应头中的E-Tag、Last-Modified对应的值标记JavaScript对应的缓存版本，对应的值发生变动则更新字节码缓存。&#x000A;4. 不支持本地JavaScript文件预编译缓存。&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;在未使用预编译JavaScript前提下，启动加载Web页面&#x000A;&#x000A;```typescript&#x000A;import web_webview from &#39;@ohos.web.webview&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: web_webview.WebviewController = new web_webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      // 在适当的时机加载业务用Web组件，本例以Button点击触发为例&#x000A;      Button(&#39;加载页面&#39;)&#x000A;        .onClick(() =&gt; {&#x000A;          // url请替换为真实地址&#x000A;          this.controller.loadUrl(&#39;https://www.example.com/b.html&#39;);&#x000A;        })&#x000A;      Web({ src: &#39;https://www.example.com/a.html&#39;, controller: this.controller })&#x000A;        .fileAccess(true)&#x000A;        .onPageBegin((event) =&gt; {&#x000A;          console.info(`load page begin: ${event?.url}`);&#x000A;        })&#x000A;        .onPageEnd((event) =&gt; {&#x000A;          console.info(`load page end: ${event?.url}`);&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;点击“加载页面”按钮，性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_js_un_pre_compile.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;使用预编译JavaScript生成字节码缓存，具体步骤如下：&#x000A;&#x000A;1. 配置预编译的JavaScript文件信息&#x000A;&#x000A;```typescript&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;&#x000A;interface Config {&#x000A;  url: string,&#x000A;  localPath: string, // 本地资源路径&#x000A;  options: webview.CacheOptions&#x000A;}&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  // 配置预编译的JavaScript文件信息&#x000A;  configs: Array&lt;Config&gt; = [&#x000A;    {&#x000A;      url: &#39;https://www/example.com/example.js&#39;,&#x000A;      localPath: &#39;example.js&#39;,&#x000A;      options: {&#x000A;        responseHeaders: [&#x000A;          { headerKey: &#39;E-Tag&#39;, headerValue: &#39;aWO42N9P9dG/5xqYQCxsx+vDOoU=&#39; },&#x000A;          { headerKey: &#39;Last-Modified&#39;, headerValue: &#39;Web, 21 Mar 2024 10:38:41 GMT&#39; }&#x000A;        ]&#x000A;      }&#x000A;    }&#x000A;  ]&#x000A;  // ...&#x000A;}&#x000A;```&#x000A;&#x000A;2. 读取配置，进行预编译&#x000A;&#x000A;```typescript&#x000A;Web({ src: &#39;https://www.example.com/a.html&#39;, controller: this.controller })&#x000A;  .onControllerAttached(async () =&gt; {&#x000A;    // 读取配置，进行预编译&#x000A;    for (const config of this.configs) {&#x000A;      let content = await getContext().resourceManager.getRawFileContentSync(config.localPath);&#x000A;&#x000A;      try {&#x000A;        this.controller.precompileJavaScript(config.url, content, config.options)&#x000A;          .then((errCode: number) =&gt; {&#x000A;            console.info(&#39;precompile successfully!&#39; );&#x000A;          }).catch((errCode: number) =&gt; {&#x000A;          console.error(&#39;precompile failed.&#39; + errCode);&#x000A;        })&#x000A;      } catch (err) {&#x000A;        console.error(&#39;precompile failed!.&#39; + err.code + err.message);&#x000A;      }&#x000A;    }&#x000A;  })&#x000A;```&#x000A;&#x000A;&#x000A;点击“加载页面”按钮，性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_js_pre_compile.png)&#x000A;&#x000A;&#x000A;  &gt; 说明&#x000A;  &gt;&#x000A;  &gt; 当需要更新本地已经生成的编译字节码时，修改cacheOptions参数中的responseHeaders中的E-Tag或Last-Modified响应头对应的值，再次调用接口即可。&#x000A;&#x000A;&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 直接加载Web页面  | 3183ms | 在触发页面加载时才进行JavaScript编译，增加加载时间 |&#x000A;| 预编译JavaScript生成字节码缓存  | 268ms | 加载页面前完成预编译JavaScript，节省了跳转页面首次加载的编译时间 |&#x000A;&#x000A;&#x000A;&#x000A;### 支持自定义协议的JavaScript生成字节码缓存（Code Cache）&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;支持自定义协议的JavaScript生成字节码缓存适用于在页面加载时存在自定义协议的JavaScript文件，支持其生成字节码缓存到本地，在页面非首次加载时节省编译时间。具体操作步骤如下：&#x000A;&#x000A;1. 开发者首先需要在Web组件运行前，向Web组件注册自定义协议。&#x000A;&#x000A;2. 其次需要拦截自定义协议的JavaScript，设置ResponseData和ResponseDataID，ResponseData为JavaScript内容，ResponseDataID用于区分JavaScript内容是否发生变更。若JavaScript内容变更，ResponseDataID需要一起变更。&#x000A;&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;##### 场景一 调用ArkTS接口， webview.WebviewController.customizeSchemes(schemes: Array&lt;WebCustomScheme&gt;): void&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;直接加载包含自定义协议的JavaScript的Web页面&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;import { BusinessError } from &#39;@kit.BasicServicesKit&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;  // 创建scheme对象，isCodeCacheSupported为false时不支持自定义协议的JavaScript生成字节码缓存&#x000A;  scheme: webview.WebCustomScheme = { schemeName: &#39;scheme&#39;, isSupportCORS: true, isSupportFetch: true, isCodeCacheSupported: false };&#x000A;  // 请求数据&#x000A;  @State jsData: string = &#39;xxx&#39;;&#x000A;&#x000A;  aboutToAppear(): void {&#x000A;    try {&#x000A;      webview.WebviewController.customizeSchemes([this.scheme]);&#x000A;    } catch (error) {&#x000A;      const e: BusinessError = error as BusinessError;&#x000A;      console.error(`ErrorCode: ${e.code}, Message: ${e.message}`);&#x000A;    }&#x000A;  }&#x000A;  build() {&#x000A;    Column({ space: 10 }) {&#x000A;      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {&#x000A;        Web({&#x000A;          // 需将&#39;https://www.example.com/&#39;替换为真是的包含自定义协议的JavaScript的Web页面地址&#x000A;          src: &#39;https://www.example.com/&#39;,&#x000A;          controller: this.controller&#x000A;        })&#x000A;          .fileAccess(true)&#x000A;          .javaScriptAccess(true)&#x000A;          .onInterceptRequest(event =&gt; {&#x000A;            const responseResource: WebResourceResponse = new WebResourceResponse();&#x000A;            // 拦截页面请求&#x000A;            if (event?.request.getRequestUrl() === &#39;scheme1://www.example.com/test.js&#39;) {&#x000A;              responseResource.setResponseHeader([&#x000A;                {&#x000A;                  headerKey: &#39;ResponseDataId&#39;,&#x000A;                  // 格式：不超过13位的纯数字。JS识别码，JS有更新时必须更新该字段&#x000A;                  headerValue: &#39;0000000000001&#39;&#x000A;                }&#x000A;              ]);&#x000A;              responseResource.setResponseData(this.jsData);&#x000A;              responseResource.setResponseEncoding(&#39;utf-8&#39;);&#x000A;              responseResource.setResponseMimeType(&#39;application/javascript&#39;);&#x000A;              responseResource.setResponseCode(200);&#x000A;              responseResource.setReasonMessage(&#39;OK&#39;);&#x000A;              return responseResource;&#x000A;            }&#x000A;            return null;&#x000A;          })&#x000A;      }&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_schemes_un_customize.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;支持自定义协议JS生成字节码缓存，具体步骤如下：&#x000A;&#x000A;1. 将scheme对象属性isCodeCacheSupported设置为true，支持自定义协议的JavaScript生成字节码缓存。&#x000A;&#x000A;```typescript&#x000A;scheme: webview.WebCustomScheme = { schemeName: &#39;scheme&#39;, isSupportCORS: true, isSupportFetch: true, isCodeCacheSupported: true };&#x000A;```&#x000A;&#x000A;2. 在Web组件运行前，向Web组件注册自定义协议。&#x000A;&#x000A;  &gt; 说明&#x000A;  &gt; 不得与Web内核内置协议相同。&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;aboutToAppear(): void {&#x000A;  try {&#x000A;    webview.WebviewController.customizeSchemes([this.scheme]);&#x000A;  } catch (error) {&#x000A;    const e: BusinessError = error as BusinessError;&#x000A;    console.error(`ErrorCode: ${e.code}, Message: ${e.message}`);&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;3. 拦截自定义协议的JavaScript，设置ResponseData和ResponseDataID。ResponseData为JS内容，ResponseDataID用于区分JS内容是否发生变更。&#x000A;&#x000A;  &gt; 说明&#x000A;  &gt; 若JS内容变更，ResponseDataID需要一起变更。&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;Web({&#x000A;  // 需将&#39;https://www.example.com/&#39;替换为真是的包含自定义协议的JavaScript的Web页面地址&#x000A;  src: &#39;https://www.example.com/&#39;,&#x000A;  controller: this.controller&#x000A;})&#x000A;  .fileAccess(true)&#x000A;  .javaScriptAccess(true)&#x000A;  .onInterceptRequest(event =&gt; {&#x000A;    const responseResource: WebResourceResponse = new WebResourceResponse();&#x000A;    // 拦截页面请求&#x000A;    if (event?.request.getRequestUrl() === &#39;scheme1://www.example.com/test.js&#39;) {&#x000A;      responseResource.setResponseHeader([&#x000A;        {&#x000A;          headerKey: &#39;ResponseDataId&#39;,&#x000A;          // 格式：不超过13位的纯数字。JS识别码，JS有更新时必须更新该字段&#x000A;          headerValue: &#39;0000000000001&#39;&#x000A;        }&#x000A;      ]);&#x000A;      responseResource.setResponseData(this.jsData2);&#x000A;      responseResource.setResponseEncoding(&#39;utf-8&#39;);&#x000A;      responseResource.setResponseMimeType(&#39;application/javascript&#39;);&#x000A;      responseResource.setResponseCode(200);&#x000A;      responseResource.setReasonMessage(&#39;OK&#39;);&#x000A;      return responseResource;&#x000A;    }&#x000A;    return null;&#x000A;  })&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_schemes_customize.png)&#x000A;&#x000A;&#x000A;##### 场景二 调用Native接口，int32_t OH_ArkWeb_RegisterCustomSchemes(const char * scheme, int32_t option)&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;通过网络拦截接口对Web组件发出的请求进行拦截，Demo工程构建请参考[拦截Web组件发起的网络请求](https://gitee.com/openharmony/docs/blob/master/zh-cn/application-dev/web/web-scheme-handler.md)&#x000A;&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Avg Wall Duration为两次加载页面开始到结束的平均耗时：&#x000A;&#x000A;![](images/web_schemes_un_registe.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;支持将自定义协议的JavaScript资源生成code cache，具体步骤如下：&#x000A;&#x000A;1. 注册三方协议配置时，传入ARKWEB_SCHEME_OPTION_CODE_CACHE_ENABLED参数。&#x000A;&#x000A;```c&#x000A;// 注册三方协议的配置，需要在Web内核初始化之前调用，否则会注册失败。&#x000A;static napi_value RegisterCustomSchemes(napi_env env, napi_callback_info info)&#x000A;{&#x000A;  OH_LOG_INFO(LOG_APP, &quot;register custom schemes&quot;);&#x000A;  OH_ArkWeb_RegisterCustomSchemes(&quot;custom&quot;, ARKWEB_SCHEME_OPTION_STANDARD | ARKWEB_SCHEME_OPTION_CORS_ENABLED | ARKWEB_SCHEME_OPTION_CODE_CACHE_ENABLED);&#x000A;  return nullptr;&#x000A;}&#x000A;```&#x000A;&#x000A;2. 设置ResponsesDataId。&#x000A;&#x000A;```c&#x000A;// 在worker线程中读取rawfile，并通过ResourceHandler返回给Web内核&#x000A;void RawfileRequest::ReadRawfileDataOnWorkerThread() {&#x000A;    // ...&#x000A;    if (&#39;test-cc.js&#39; == rawfilePath()) {&#x000A;        OH_ArkWebResponse_SetHeaderByName(response(), &quot;ResponseDataID&quot;, &quot;0000000000001&quot;, true);&#x000A;    }&#x000A;    OH_ArkWebResponse_SetCharset(response(), &quot;UTF-8&quot;);&#x000A;}&#x000A;```&#x000A;&#x000A;3. 注册三方协议的配置，设置SchemeHandler。&#x000A;&#x000A;```typescript&#x000A;// EntryAbility.ets&#x000A;import { UIAbility, AbilityConstant, Want } from &#39;@kit.AbilityKit&#39;;&#x000A;import { webview } from &#39;@kit.ArkWeb&#39;;&#x000A;import { window } from &#39;@kit.ArkUI&#39;;&#x000A;import testNapi from &#39;libentry.so&#39;;&#x000A;&#x000A;export default class EntryAbility extends UIAbility {&#x000A;  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {&#x000A;    // 注册三方协议的配置&#x000A;    testNapi.registerCustomSchemes();&#x000A;    // 初始化Web组件内核，该操作会初始化Brownser进程以及创建BrownserContext&#x000A;    webview.WebviewController.initializeWebEngine();&#x000A;    // 设置SchemeHandler&#x000A;    testNapi.setSchemeHandler();&#x000A;  }&#x000A;  // ...&#x000A;}&#x000A;```&#x000A;&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Avg Wall Duration为两次加载页面开始到结束的平均耗时：&#x000A;&#x000A;![](images/web_schemes_registe.png)&#x000A;&#x000A;&#x000A;&#x000A;#### 总结(以Native接口性能数据举例)&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 直接加载Web页面  | 8ms | 在触发页面加载时才进行JavaScript编译，增加加载时间 |&#x000A;| 自定义协议的JavaScript生成字节码缓存  | 4ms | 支持自定义协议头的JS文件在第二次加载JS时生成code cache,节约了第三次及之后的页面加载或跳转的自定义协议JS文件的编译时间，提升了页面加载和跳转的性能 |&#x000A;&#x000A;&#x000A;&#x000A;### 离线资源免拦截注入&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;离线资源免拦截注入适用于在页面加载之前提前将即将使用到的图片、样式表和脚本资源注入到内存缓存中，在页面首次加载时节省网络请求时间。&#x000A;&#x000A;注意事项：&#x000A;&#x000A;1. 开发者需创建一个无需渲染的离线Web组件，用于将资源注入到内存缓存中，使用其他Web组件加载对应的业务网页。&#x000A;2. 仅使用HTTP或HTTPS协议请求的资源可被注入进内存缓存。&#x000A;3. 内存缓存中的资源由内核自动管理，当注入的资源过多导致内存压力过大，内核自动释放未使用的资源，应避免注入大量资源到内存缓存中。&#x000A;4. 正常情况下，资源的有效期由提供的Cache-Control或Expires响应头控制其有效期，默认的有效期为86400秒，即1天。&#x000A;5. 资源的MIMEType通过提供的参数中的Content-Type响应头配置，Content-Type需符合标准，否则无法正常使用，MODULE_JS必须提供有效的MIMEType，其他类型可不提供。&#x000A;6. 仅支持通过HTML中的标签加载。&#x000A;7. 如果业务网页中的script标签使用了crossorigin属性，则必须在接口的responseHeaders参数中设置Cross-Origin响应头的值为anoymous或use-credentials。&#x000A;8. 当调用web_webview.WebviewController.SetRenderProcessMode(web_webview.RenderProcessMode.MULTIPLE)接口后，应用会启动多渲染进程模式，此方案在此场景下不会生效。&#x000A;9. 单次调用最大支持注入30个资源，单个资源最大支持10Mb。&#x000A;&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;直接加载Web页面&#x000A;&#x000A;```typescript&#x000A;import webview from &#39;@ohos.web.webview&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      // 在适当的时机加载业务用Web组件，本例以Button点击触发为例&#x000A;      Button(&#39;加载页面&#39;)&#x000A;        .onClick(() =&gt; {&#x000A;          this.controller.loadUrl(&#39;https://www.example.com/b.html&#39;);&#x000A;        })&#x000A;      Web({ src: &#39;https://www.example.com/a.html&#39;, controller: this.controller })&#x000A;        .fileAccess(true)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_resource_un_offline.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;使用资源免拦截注入加载Web页面，请参考以下步骤：&#x000A;&#x000A;1. 创建资源配置&#x000A;&#x000A;```typescript&#x000A;interface ResourceConfig {&#x000A;  urlList: Array&lt;string&gt;;&#x000A;  type: webview.OfflineResourceType;&#x000A;  responseHeaders: Array&lt;Header&gt;;&#x000A;  localPath: string; // 本地资源存放在rawfile目录下的路径&#x000A;}&#x000A;&#x000A;const configs: Array&lt;ResourceConfig&gt; = [&#x000A;  {&#x000A;    localPath: &#39;example.png&#39;,&#x000A;    urlList: [&#x000A;      // 多url场景，第一个url作为资源的源&#x000A;      &#39;https://www.example.com/&#39;,&#x000A;      &#39;https://www.example.com/path1/example.png&#39;,&#x000A;      &#39;https://www.example.com/path2/example.png&#39;&#x000A;    ],&#x000A;    type: webview.OfflineResourceType.IMAGE,&#x000A;    responseHeaders: [&#x000A;      { headerKey: &#39;Cache-Control&#39;, headerValue: &#39;max-age=1000&#39; },&#x000A;      { headerKey: &#39;Content-Type&#39;, headerValue: &#39;image/png&#39; }&#x000A;    ]&#x000A;  },&#x000A;  {&#x000A;    localPath: &#39;example.js&#39;,&#x000A;    urlList: [&#x000A;      // 仅提供一个url，这个url既作为资源的源，也作为资源的网络请求地址&#x000A;      &#39;https://www.example.com/example.js&#39;&#x000A;    ],&#x000A;    type: webview.OfflineResourceType.CLASSIC_JS,&#x000A;    responseHeaders: [&#x000A;      // 以&lt;script crossorigin=&#39;anonymous&#39;/&gt;方式使用，提供额外的响应头&#x000A;      { headerKey: &#39;Cross-Origin&#39;, headerValue: &#39;anonymous&#39; }&#x000A;    ]&#x000A;  }&#x000A;];&#x000A;&#x000A;```&#x000A;&#x000A;2. 读取配置，注入资源&#x000A;&#x000A;```typescript&#x000A;Web({ src: &#39;https://www.example.com/a.html&#39;, controller: this.controller })&#x000A;  .onControllerAttached(async () =&gt; {&#x000A;    try {&#x000A;      const resourceMapArr: Array&lt;webview.OfflineResourceMap&gt; = [];&#x000A;      // 读取配置，从rawfile目录中读取文件内容&#x000A;      for (const config of this.configs) {&#x000A;        const buf: Uint8Array = await getContext().resourceManager.getRawFileContentSync(config.localPath);&#x000A;        resourceMapArr.push({&#x000A;          urlList: config.urlList,&#x000A;          resource: buf,&#x000A;          responseHeaders: config.responseHeaders,&#x000A;          type: config.type&#x000A;        });&#x000A;      }&#x000A;      // 注入资源&#x000A;      this.controller.injectOfflineResources(resourceMapArr);&#x000A;    } catch (err) {&#x000A;      console.error(&#39;error: &#39; + err.code + &#39; &#39; + err.message);&#x000A;    }&#x000A;  })&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_resource_offline.png)&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 直接加载Web页面  | 1312ms | 在触发页面加载时才发起资源请求，增加页面加载时间 |&#x000A;| 使用离线资源免拦截注入加载Web页面  | 74ms | 将资源预置在内存中，节省了网络请求时间 |&#x000A;&#x000A;&#x000A;&#x000A;### 资源拦截替换加速&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;资源拦截替换加速在原本的资源拦截替换接口基础上新增支持了ArrayBuffer格式的入参，开发者无需在应用侧进行ArrayBuffer到String格式的转换，可直接使用ArrayBuffer格式的数据进行拦截替换。&#x000A;&#x000A;  &gt; 说明&#x000A;  &gt;&#x000A;  &gt; 本方案与原本的资源拦截替换接口在使用上没有任何区别，开发者仅需在调用WebResourceResponse.setResponseData()接口时传入ArrayBuffer格式的数据即可。&#x000A;&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;使用字符串格式的数据做拦截替换&#x000A;&#x000A;```typescript&#x000A;import webview from &#39;@ohos.web.webview&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;  responseResource: WebResourceResponse = new WebResourceResponse();&#x000A;  // 这里是string格式数据&#x000A;  resourceStr: string = &#39;xxxxxxxxxxxxxxx&#39;;&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: &#39;https:www.example.com/test.html&#39;, controller: this.controller })&#x000A;        .onInterceptRequest(event =&gt; {&#x000A;          if (event) {&#x000A;            if (!event.request.getRequestUrl().startsWith(&#39;https://www.example.com/&#39;)) {&#x000A;              return null;&#x000A;            }&#x000A;          }&#x000A;          // 使用string格式的数据做拦截替换&#x000A;          this.responseResource.setResponseData(this.resourceStr);&#x000A;          this.responseResource.setResponseEncoding(&#39;utf-8&#39;);&#x000A;          this.responseResource.setResponseMimeType(&#39;text/json&#39;);&#x000A;          this.responseResource.setResponseCode(200);&#x000A;          this.responseResource.setReasonMessage(&#39;OK&#39;);&#x000A;          this.responseResource.setResponseHeader([{ headerKey: &#39;Access-Control-Allow-Origin&#39;, headerValue: &#39;*&#39; }]);&#x000A;          return this.responseResource;&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;资源替换耗时如图所示，getMessageData ... someFunction took后的时间页面加载资源的耗时：&#x000A;&#x000A;![](images/web_send_response_data_string.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;使用ArrayBuffer格式的数据做拦截替换&#x000A;&#x000A;```typescript&#x000A;import webview from &#39;@ohos.web.webview&#39;;&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;  responseResource: WebResourceResponse = new WebResourceResponse();&#x000A;  // 这里是ArrayBuffer格式数据&#x000A;  buffer: ArrayBuffer = new ArrayBuffer(10);&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: &#39;https:www.example.com/test.html&#39;, controller: this.controller })&#x000A;        .onInterceptRequest(event =&gt; {&#x000A;          if (event) {&#x000A;            if (!event.request.getRequestUrl().startsWith(&#39;https://www.example.com/&#39;)) {&#x000A;              return null;&#x000A;            }&#x000A;          }&#x000A;          // 使用ArrayBuffer格式的数据做拦截替换&#x000A;          this.responseResource.setResponseData(this.buffer);&#x000A;          this.responseResource.setResponseEncoding(&#39;utf-8&#39;);&#x000A;          this.responseResource.setResponseMimeType(&#39;text/json&#39;);&#x000A;          this.responseResource.setResponseCode(200);&#x000A;          this.responseResource.setReasonMessage(&#39;OK&#39;);&#x000A;          this.responseResource.setResponseHeader([{ headerKey: &#39;Access-Control-Allow-Origin&#39;, headerValue: &#39;*&#39; }]);&#x000A;          return this.responseResource;&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;资源替换耗时如图所示，getMessageData william someFunction took后的时间页面加载资源的耗时：&#x000A;&#x000A;![](images/web_send_response_data_buffer.png)&#x000A;&#x000A;&#x000A;&#x000A;#### 总结&#x000A;&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 使用string格式的数据做拦截替换  | 34ms | Web组件内部数据传输仍需要转换为ArrayBuffer，增加数据处理步骤，增加启动耗时 |&#x000A;| 使用ArrayBuffer格式的数据做拦截替换  | 13ms | 接口直接支持ArrayBuffer格式，节省了转换时间，同时对ArrayBuffer格式的数据传输方式进行了优化，进一步减少耗时 |&#x000A;&#x000A;### 预加载优化滑动白块&#x000A;&#x000A;Web场景应用在加载图片资源时，需要先发起请求，然后解析渲染到屏幕上。在列表滑动过程中，如果等屏幕可视区域出现新图片时才开始发起请求，会因上述加载资源的步骤出现时间差，导致列表中图片出现白块问题，在网络情况不良或应用渲染图片阻塞时，这种情况会更加严重。本章节针对Web场景，在HTML页面中使用预加载策略，使列表滑动前预先加载可视区域外的图片资源，解决可视区域白块问题，提高用户使用体验。&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;滑动白块的产生主要来源于页面滑动场景组件可见和组件上屏刷新之间的时间差，在这两个时间点间，由于网络图片未加载完成，该区域显示的是默认图片即图片白块。图片组件从可见到上屏刷新之间的耗时主要是由图片资源网络请求和解码渲染两部分组成，在这段时间内页面滑动距离是滑动速度(px/ms)*(下载耗时+解码耗时)(ms)，因此只要设置预加载的高度大于滑动距离，就可以保证页面基本无白块。开发者可根据`预加载高度(px)&gt;滑动速度(px/ms)*(下载耗时+解码耗时)(ms)`这一计算公式对应用进行调整，计算出Web页面在设备视窗外需要预加载的图片个数，即可视窗口根元素超过屏幕的高度。&#x000A;&#x000A;开发者可以使用IntersectionObserver接口，将视窗作为根元素并对其进行观察，当图片滑动进入视窗时替换默认地址为真实地址，触发图片加载。此时适当的扩展视窗高度，就可以实现在图片进入视窗前提前开始加载图片，解决图片未及时加载导致出现白块的问题。&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;常规案例使用懒加载的逻辑加载图片，图片组件进入可视区域后再执行加载，滑动过程中列表有大量图片未加载完成产生的白块。&#x000A;&#x000A;![img](./figures/web-sliding-white-block-optimization-1.gif)&#x000A;&#x000A;```html&#x000A;&lt;!DOCTYPE html&gt;&#x000A;&lt;html&gt;&#x000A;    &lt;head&gt;&#x000A;        &lt;title&gt;Image List&lt;/title&gt;&#x000A;    &lt;/head&gt;&#x000A;    &lt;body&gt;&#x000A;        &lt;ul&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo1.jpg&quot; alt=&quot;Photo 1&quot;&gt;&lt;/li&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo2.jpg&quot; alt=&quot;Photo 2&quot;&gt;&lt;/li&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo3.jpg&quot; alt=&quot;Photo 3&quot;&gt;&lt;/li&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo4.jpg&quot; alt=&quot;Photo 4&quot;&gt;&lt;/li&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo5.jpg&quot; alt=&quot;Photo 5&quot;&gt;&lt;/li&gt;&#x000A;            &lt;!-- 添加更多的图片只需要复制并修改src和alt属性即可 --&gt;&#x000A;        &lt;/ul&gt;&#x000A;    &lt;/body&gt;&#x000A;    &lt;script&gt;&#x000A;        window.onload = function(){&#x000A;          // 可视窗口作为根元素，不进行扩展&#x000A;          const options = {root:document,rootMargin:&#39;0% 0% 0% 0%&#39;}&#x000A;          // 创建一个IntersectionObserver实例&#x000A;          const observer = new IntersectionObserver(function(entries,observer){&#x000A;            entries.forEach(function(entry){&#x000A;              // 检查图片是否进入可视区域&#x000A;              if(entry.isIntersecting){&#x000A;                const image = entry.target;&#x000A;                // 将数据源的src赋值给img的src&#x000A;                image.src = image.dataset.src;&#x000A;                // 停止观察该图片&#x000A;                observer.unobserve(image);&#x000A;              }&#x000A;            })&#x000A;          },options);&#x000A;          &#x000A;          document.querySelectorAll(&#39;img&#39;).forEach(img =&gt; { observer.observe(img) });&#x000A;        }&#x000A;    &lt;/script&gt;&#x000A;&lt;/html&gt;&#x000A;```&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;根据上方公式，优化案例设定在400mm/s的速度滑动屏幕，此时可计算应用需预加载0.5个屏幕高度的图片。在常规加载案例中，页面将可视窗口作为根元素，rootMargin属性均为0，可视窗口与设备屏幕高度相等。此时可通过设置`rootMargin`向下方向为50%（即0.5个屏幕高度），扩展可视窗口的高度，使图片在屏幕外提前进入可视窗口。当图片元素进入可视窗口时，会将&lt;img&gt;标签的data-src属性中保存的图片地址赋值给src属性，从而实现图片的预加载。应用会查询页面上所有具有data-src属性的&lt;img&gt;标签，并开始观察这些图片。当某张图片进入已拓展高度的可视窗口时，就会执行相应的加载操作，实现页面预渲染更多图片，解决滑动白块问题。&#x000A;&#x000A;```javascript&#x000A;// html结构与上方常规案例相同&#x000A;// 可视区域作为根元素，向下扩展50%的margin长度&#x000A;const options = {root:document,rootMargin:&#39;0% 0% 50% 0%&#39;};&#x000A;// 创建IntersectionObserver实例&#x000A;const observer = new IntersectionObserver(function(entries,observer){&#x000A;  // ...&#x000A;},options);&#x000A;&#x000A;document.querySelectorAll(&#39;img&#39;).forEach(img =&gt; {observer.observe(img)});&#x000A;```&#x000A;&#x000A;![img](figures/web-sliding-white-block-optimization-2.gif)&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| 图片加载方式      | 说明                                     |&#x000A;|-------------|----------------------------------------|&#x000A;| 常规加载（不推荐用法） | 常规案例在列表滑动过程中，由于图片加载未及时导致出现大量白块，影响用户体验。 |&#x000A;| 预加载（推荐用法）   | 优化案例在拓展0.5个屏幕高度的可视窗口后，滑动时无明显白块，用户体验提升。 |&#x000A;&#x000A;开发者可使用公式，根据设备屏幕高度和设置滑动屏幕速度预估值，计算出视窗根元素需要扩展的高度，解决滑动白块问题。&#x000A;&#x000A;## 性能分析&#x000A;&#x000A;### 场景示例&#x000A;&#x000A;构建通过点击按钮跳转Web网页和在网页内跳转页面的场景，在点击按钮触发跳转事件、Web组件触发OnPageEnd事件处使用Hilog打点记录时间戳。&#x000A;&#x000A;#### 反例&#x000A;&#x000A;入口页通过router实现跳转&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebUninitialized.ets&#x000A;&#x000A;// ...&#x000A;Button(&#39;进入网页&#39;)&#x000A;  .onClick(() =&gt; {&#x000A;    hilog.info(0x0001, &quot;WebPerformance&quot;, &quot;UnInitializedWeb&quot;);&#x000A;    router.pushUrl({ url: &#39;pages/WebBrowser&#39; });&#x000A;  })&#x000A;```&#x000A;Web页使用Web组件加载指定网页&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebBrowser.ets&#x000A;&#x000A;// ...&#x000A;Web({ src: &#39;https://www.example.com&#39;, controller: this.controller })&#x000A;  .domStorageAccess(true)&#x000A;  .onPageEnd((event) =&gt; {&#x000A;     if (event) {&#x000A;       hilog.info(0x0001, &quot;WebPerformance&quot;, &quot;WebPageOpenEnd&quot;);&#x000A;     }&#x000A;  })&#x000A;```&#x000A;&#x000A;#### 正例&#x000A;&#x000A;入口页提前进行Web组件的初始化和预连接&#x000A;&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebInitialized.ets&#x000A;&#x000A;import webview from &#39;@ohos.web.webview&#39;;&#x000A;&#x000A;// ...&#x000A;Button(&#39;进入网页&#39;)&#x000A;  .onClick(() =&gt; {&#x000A;     hilog.info(0x0001, &quot;WebPerformance&quot;, &quot;InitializedWeb&quot;);&#x000A;     router.pushUrl({ url: &#39;pages/WebBrowser&#39; });&#x000A;  })&#x000A;// ...&#x000A;aboutToAppear() {&#x000A;  webview.WebviewController.initializeWebEngine();&#x000A;  webview.WebviewController.prepareForPageLoad(&quot;https://www.example.com&quot;, true, 2);&#x000A;}&#x000A;```&#x000A;Web页加载的同时使用prefetchPage预加载下一页&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebBrowser.ets&#x000A;&#x000A;import webview from &#39;@ohos.web.webview&#39;;&#x000A;&#x000A;  // ...&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;    // ...&#x000A;    Web({ src: &#39;https://www.example.com&#39;, controller: this.controller })&#x000A;      .domStorageAccess(true)&#x000A;      .onPageEnd((event) =&gt; {&#x000A;         if (event) {&#x000A;           hilog.info(0x0001, &quot;WebPerformance&quot;, &quot;WebPageOpenEnd&quot;);&#x000A;           this.controller.prefetchPage(&#39;https://www.example.com/nextpage&#39;);&#x000A;         }&#x000A;      })&#x000A;```&#x000A;&#x000A;### 数据对比&#x000A;&#x000A;通过分别抓取正反示例的trace数据后使用SmartPerf Host工具分析可以得出以下结论：&#x000A;&#x000A;![hilog](./figures/web-hilog.png)&#x000A;&#x000A;从点击按钮进入Web首页到Web组件触发OnPageEnd事件，表示首页加载完成。对比优化前后时延可以得出，使用提前初始化内核和预解析、预连接可以减少平均100ms左右的加载时间。&#x000A;&#x000A;![首页完成时延](./figures/web-open-time-chart.png)&#x000A;&#x000A;从Web首页内点击跳转下一页按钮到Web组件触发OnPageEnd事件，表示页面间跳转完成。对比优化前后时延可以得出，使用预加载下一页方法可以减少平均40~50ms左右的跳转时间。&#x000A;&#x000A;![跳转完成时延](./figures/web-route-time-chart.png)</textarea>
<a class="ui button" id="copy-text" href="#">一键复制</a>
<a class="ui button edit-blob" title="" href="/harmonyos-cases/cases/edit/master/docs/performance/performance-web-import.md">编辑</a>
<a class="ui button edit-raw" target="_blank" href="/harmonyos-cases/cases/raw/master/docs/performance/performance-web-import.md">原始数据</a>
<a class="ui button edit-blame" href="/harmonyos-cases/cases/blame/master/docs/performance/performance-web-import.md">按行查看</a>
<a class="ui button edit-history" href="/harmonyos-cases/cases/commits/master/docs/performance/performance-web-import.md">历史</a>
</div>
<script>
  window.gon.aiCodeParams = {
    pathWithNamespace: `harmonyos-cases/cases`,
    blob: $("#blob_raw").val(),
    fileName: `docs/performance/performance-web-import.md`,
    id: `ffe5b487cf21613bcfe605fb5aa35bba10219927`,
    timeStamp: `1725937309`,
    userId: `14744567`,
    sign: `jrH3WsdGWNzPug/CcK/w1mjKs37Wt3pU1bZHO/wStM6oIYgmMBu9tpZuk44ZHcBRZkD9EVmcPyFUjAdVrrRDpAozvVTeb6zipLe9AtW971GlbbLqKpF76TQe7Wr3HZCFi2wlhwfeNotUhXgcGbCsh0Lxa19wiwzrkV6PIZxl+C8=`,
  }
  window.gon.blobName = `"performance-web-import.md"`
  $('.js-code-parsing').dropdown({
    on: 'hover',
    action: 'hide',
    onHide: function () {
    },
    onShow: function () {
    }
  });
  $(".ai-code-dropdown-box").find('.item').on("click", function (e) {
    window.jqxhr && window.jqxhr.abort();
    window.aiLoadingTimer && clearTimeout(window.aiLoadingTimer);
    aiReqLoading = false

    window.Gitee.setFullscreen(true);
    $(".side-toolbar").hide();
    var $siteContent = $(".site-content");
    // 获取最小高度
    var minHeight = parseInt($siteContent.css("min-height"));
    // 获取当前高度
    var currentHeight = parseInt($siteContent.height());
    if (minHeight + 1 > currentHeight) {
      $("#code-parsing").css("height", currentHeight);
    }
  
    $("#git-project-container").addClass('git-transition-width');
    $("#project-wrapper").css("marginTop", "-24px");
    //$("#git-project-container").removeClass("sixteen wide column");
    //$("#git-project-container").addClass("twelve wide column");
    if(!$("#code-parsing").hasClass("code-parsing-box")){
      $("#git-project-container").attr("style", "width: 75% !important;");
    }
    $("#git-footer-main").css("margin-top", "14px");
    $("#code-parsing").addClass("code-parsing-box");
    $(".code-parsing-content").hide();
    $(".skeleton").show();
    $(".ai_code_btns_simple").hide();
  
    $("#code-parsing").find(".markdown-body").innerHTML='';
  
    aiCodeType = $(this).data("value");
    aiSubTitle = $(this).data("text");
    handleAiReqInit()
});
</script>
<script>
  "use strict";
  try {
    if((gon.wait_fork!=undefined && gon.wait_fork==true) || (gon.wait_fetch!=undefined && gon.wait_fetch==true)){
      $('.edit-blob').popup({content:"当前仓库正在后台处理中,暂时无法编辑", on: 'hover', delay: { show: 200, hide: 200 }});
      $('.edit-blob').click(function(e){
        e.preventDefault();
      })
    }
  
    var setUrl = function() {
      var params = window.location.search
      if (params==undefined || $.trim(params).length==0) return;
      $('span.options').children('.basic').find('a').each(function(index,ele){
        var origin_href = $(ele).attr('href');
        if (origin_href!="#" && origin_href.indexOf('?') == -1){
          $(ele).attr('href',origin_href+params);
        }
      });
    }
  
    setUrl();
  
    var clipboard = null,
        $btncopy  = $("#copy-text");
  
    clipboard = new Clipboard("#copy-text", {
      text: function(trigger) {
        return $("#blob_raw").val();
      }
    })
  
    clipboard.on('success', function(e) {
      $btncopy.popup('hide');
      $btncopy.popup('destroy');
      $btncopy.popup({content: '已复制', position: 'bottom center'});
      $btncopy.popup('show');
    })
  
    clipboard.on('error', function(e) {
      var giteeModal = new GiteeModalHelper({okText: '确定'});
      giteeModal.alert("一键复制", '复制失败，请手动复制');
    })
  
    $(function() {
      $btncopy.popup({
        content: '点击复制',
        position: 'bottom center'
      })
    })
  
  } catch (error) {
    console.log('blob/action error:' + error);
  }
  
  $(".disabled-edit-readonly").popup({
    content: "只读文件不可编辑",
    className: {
      popup: "ui popup",
    },
    position: "bottom center",
  });
  $(".disabled-edit-readonly, .disabled-edit-status").click(function () {
    return false;
  });
  $(".has_tooltip").popup({
    position: "top center",
  });
</script>
<style>
  .disabled-edit-readonly, .disabled-edit-status {
    background-color: #dcddde !important;
    color: rgba(0, 0, 0, 0.4) !important;
    opacity: 0.3 !important;
    background-image: none !important;
    -webkit-box-shadow: none !important;
            box-shadow: none !important;
    cursor: default !important; }
  
  .drawio-iframe-code-card {
    position: relative; }
    .drawio-iframe-code-card textarea {
      width: 100%;
      height: 140px;
      resize: none; }
    .drawio-iframe-code-card .icon-clone {
      position: absolute;
      right: 32px;
      bottom: 32px; }
    .drawio-iframe-code-card iframe {
      border-radius: 2px;
      border: 1px solid #DEDEDF; }
</style>
</div>
</div>
<div class='blob-header-title mt-1 ubblock_tip'>
</div>
<div class='contributor-description'><span class='recent-commit' style='margin-top: 0.7rem'>
<a class="commit-author-link  js-popover-card " data-username="enxue" href="/enxue">enxue</a>
<span>提交于</span>
<span class='timeago commit-date' title='2024-09-05 16:32:19 +0800'>
2024-09-05 16:32
</span>
.
<a href="/harmonyos-cases/cases/commit/69bddb742b47794572668eccc416234e1ce379ba">web滑动白块优化文章修改</a>
</span>
</div>
</div>
<div class='clearfix'></div>
<div class='file_catalog'>
<div class='toggle'>
<i class='icon angle left'></i>
</div>
<div class='scroll-container'>
<div class='container'>
<div class='skeleton'>
<div class='line line1'></div>
<div class='line line2'></div>
<div class='line line3'></div>
<div class='line line1'></div>
<div class='line line2'></div>
<div class='line line3'></div>
</div>
</div>
</div>
</div>
<div class='file_content markdown-body'>
<blob-markdown-renderer data-dir='docs/performance' data-path-with-namespace='/harmonyos-cases/cases'>&#x000A;<div class='content' style='display:none;'>&#x000A;# Web组件开发性能提升指导&#x000A;&#x000A;## 简介&#x000A;&#x000A;开发者实现在应用中跳转显示网页需要分为两个方面：使用@ohos.web.webview提供Web控制能力；使用Web组件提供网页显示的能力。在实际应用中往往由于各种原因导致首次跳转Web网页或Web组件内跳转时出现白屏、卡顿等情况。本文介绍提升Web首页加载与Web网页间跳转速度的几种方法。&#x000A;&#x000A;## 优化思路&#x000A;&#x000A;用户在使用Web组件显示网页时往往会经历四个阶段：无反馈--&gt;白屏--&gt;网页渲染--&gt;完全展示，系统会在各个阶段内分别进行WebView初始化、建立网络连接、接受数据与渲染页面等操作，如图一所示是WebView的启动阶段。&#x000A;&#x000A;图一 Web组件显示页面的阶段&#x000A;&#x000A;![Web组件显示页面的阶段](./figures/web-display-stage.png)&#x000A;&#x000A;要优化Web组件的首页加载性能，可以从图例标记的三个阶段来进行优化：&#x000A;&#x000A;1. 在WebView的初始化阶段：应用打开WebView的第一步是启动浏览器内核，而这段时间由于WebView还不存在，所有后续的步骤是完全阻塞的。因此可以考虑在应用中预先完成初始化WebView，以及在初始化的同时通过预先加载组件内核、完成网络请求等方法，使得WebView初始化不是完全的阻塞后续步骤，从而减小耗时。&#x000A;2. 在建立连接阶段：当开发者提前知道访问的网页地址，我们可以预先建立连接，进行DNS预解析。&#x000A;3. 在接收资源数据阶段：当开发者预先知道用户下一页会点击什么页面的时候，可以合理使用缓存和预加载，将该页面的资源提前下载到缓存中。&#x000A;&#x000A;综上所述，开发者可以通过方法1和2来提升Web首页加载速度，在应用创建Ability的时候，在OnCreate阶段预先初始化内核。随后在onAppear阶段进行预解析DNS、预连接要加载的首页。  &#x000A;在网页跳转的场景，开发者也可以通过方法3，在onPageEnd阶段预加载下一个要访问的页面，提升Web网页间的跳转和显示速度，如图二所示。&#x000A;&#x000A;图二 Web组件的生命周期回调函数&#x000A;&#x000A;![Web组件的生命周期回调函数](./figures/web-life-cycle.png)&#x000A;&#x000A;## 优化方法&#x000A;&#x000A;### 提前初始化内核&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;当应用首次打开时，默认不会初始化浏览器内核，只有当创建WebView实例的时候，才会开始初始化浏览器内核。  &#x000A;为了能提前初始化WebView实例，@ohos.web.webview提供了initializeWebEngine方法。该方法实现在Web组件初始化之前，通过接口加载Web引擎的动态库文件，从而提前进行Web组件动态库的加载和Web内核主进程的初始化，最终以提高启动性能，减少白屏时间。  &#x000A;&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【反例】&#x000A;&#x000A;在未初始化Web内核前提下，启动加载Web页面&#x000A;&#x000A;```typescript&#x000A;import web_webview from '@ohos.web.webview';&#x000A;import { hiTraceMeter } from '@kit.PerformanceAnalysisKit';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: web_webview.WebviewController = new web_webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: 'https://www.example.com/example.html', controller: this.controller })&#x000A;        .fileAccess(true)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_enginee_un_init.png)&#x000A;&#x000A;&#x000A;【正例】&#x000A;&#x000A;在页面开始加载时，调用initializeWebEngine()接口初始化Web内核，具体步骤如下：&#x000A;&#x000A;1. 初始化Web内核&#x000A;&#x000A;```typescript&#x000A;// EntryAbility.ets&#x000A;import { UIAbility, AbilityConstant, Want } from '@kit.AbilityKit';&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;export default class EntryAbility extends UIAbility {&#x000A;  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {&#x000A;    webview.WebviewController.initializeWebEngine();&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;2. 加载Web组件&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import web_webview from '@ohos.web.webview';&#x000A;import { hiTraceMeter } from '@kit.PerformanceAnalysisKit';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: web_webview.WebviewController = new web_webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: 'https://www.example.com/example.html', controller: this.controller })&#x000A;        .fileAccess(true)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_enginee_init.png)&#x000A;&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 直接加载Web页面  | 1264ms | 在加载Web组件时才初始化Web内核，增加启动时间 |&#x000A;| 提前初始化Web内核  | 1153ms | 加载页面时减少了Web内核初始化步骤，提高启动性能 |&#x000A;&#x000A;&#x000A;### 预解析DNS、预连接&#x000A;WebView在onAppear阶段进行预连接socket， 当Web内核真正发起请求的时候会直接复用预连接的socket，如果当前预解析还没完成，真正发起网络请求进行DNS解析的时候也会复用当前正在执行的DNS解析任务。同理即使预连接的socket还没有连接成功，Web内核也会复用当前正在连接中的socket，进而优化资源的加载过程。  &#x000A;@ohos.web.webview提供了prepareForPageLoad方法实现预连接url，在加载url之前调用此API，对url只进行DNS解析、socket建链操作，并不获取主资源子资源。  &#x000A;参数：&#x000A;&#x000A;| 参数名            | 类型      | 说明                                                                                        |&#x000A;|----------------|---------|-------------------------------------------------------------------------------------------|&#x000A;| url            | string  | 预连接的url。                                                                                  |&#x000A;| preconnectable | boolean | 是否进行预连接。如果preconnectable为true，则对url进行dns解析，socket建链预连接；如果preconnectable为false，则不做任何预连接操作。 |&#x000A;| numSockets     | number  | 要预连接的socket数。socket数目连接需要大于0，最多允许6个连接。              &#x000A;&#x000A;使用方法如下：&#x000A;&#x000A;```typescript&#x000A;// 开启预连接需要先使用上述方法预加载WebView内核。&#x000A;webview.WebviewController.initializeWebEngine();&#x000A;// 启动预连接，连接地址为即将打开的网址。&#x000A;webview.WebviewController.prepareForPageLoad(&quot;https://www.example.com&quot;, true, 2); &#x000A;```&#x000A;&#x000A;&#x000A;### 预加载下一页&#x000A;开发者可以在onPageEnd阶段进行预加载，当真正去加载下一个页面的时候，如果预加载已经成功，则相当于直接从缓存中加载页面资源，速度更快。一般来说能够准确预测到用户下一步要访问的页面的时候，可以进行预加载将要访问的页面，比如小说下一页， 浏览器在地址栏输入过程中识别到用户将要访问的页面等。  &#x000A;@ohos.web.webview提供prefetchPage方法实现在预测到将要加载的页面之前调用，提前下载页面所需的资源，包括主资源子资源，但不会执行网页JavaScript代码或呈现网页，以加快加载速度。  &#x000A;参数：&#x000A;&#x000A;| 参数名               | 类型               | 说明             |&#x000A;|-------------------|------------------|----------------|&#x000A;| url               | string           | 预加载的url。       |&#x000A;| additionalHeaders | Array&lt;WebHeader&gt; | url的附加HTTP请求头。 |&#x000A;&#x000A;使用方法如下：&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebBrowser.ets&#x000A;&#x000A;import webview from '@ohos.web.webview';&#x000A;  // ...&#x000A;&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;    // ...&#x000A;    Web({ src: 'https://www.example.com', controller: this.controller })&#x000A;      .onPageEnd((event) =&gt; {&#x000A;        //  ...&#x000A;        // 在确定即将跳转的页面时开启预加载&#x000A;        this.controller.prefetchPage('https://www.example.com/nextpage');&#x000A;      })&#x000A;    Button('下一页')&#x000A;      .onClick(() =&gt; {&#x000A;        // ...&#x000A;        // 跳转下一页&#x000A;        this.controller.loadUrl('https://www.example.com/nextpage');&#x000A;      })&#x000A;```&#x000A;&#x000A;### 预渲染优化&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;预渲染优化适用于Web页面启动和跳转场景，例如，进入首页后，跳转到其他子页。与预连接、预下载不同的是，预渲染需要开发者额外创建一个新的ArkWeb组件，并在后台对其进行预渲染，此时该组件并不会立刻挂载到组件树上，即不会对用户呈现(组件状态为Hidden和InActive)，开发者可以在后续使用中按需动态挂载。&#x000A;&#x000A;具体原理如下图所示，首先需要定义一个自定义组件封装ArkWeb组件，该ArkWeb组件被离线创建，被包含在一个无状态的节点NodeContainer中，并与相应的NodeController绑定。该ArkWeb组件在后台完成预渲染后，在需要展示该ArkWeb组件时，再通过NodeController将其挂载到ViewTree的NodeContainer中，即通过NodeController绑定到对应的NodeContainer组件。预渲染通用实现的步骤如下：&#x000A;&#x000A;创建自定义ArkWeb组件：开发者需要根据实际场景创建封装一个自定义的ArkWeb组件，该ArkWeb组件被离线创建。&#x000A;创建并绑定NodeController：实现NodeController接口，用于自定义节点的创建、显示、更新等操作的管理。并将对应的NodeController对象放入到容器中，等待调用。&#x000A;绑定NodeContainer组件：将NodeContainer与NodeController进行绑定，实现动态组件页面显示。&#x000A;&#x000A;图三 预渲染优化原理图&#x000A;&#x000A;![](./figures/web-node-container.png)&#x000A;&#x000A;  &gt; 说明  &#x000A;  &gt; 预渲染相比于预下载、预连接方案，会消耗更多的内存、算力，仅建议针对高频页面使用，单应用后台创建的ArkWeb组件要求小于200个。&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;1. 创建载体，并创建ArkWeb组件&#x000A;    ```typescript&#x000A;    // 载体Ability&#x000A;    // EntryAbility.ets&#x000A;    import {createNWeb} from &quot;../pages/common&quot;&#x000A;    onWindowStageCreate(windowStage: window.WindowStage): void {&#x000A;      windowStage.loadContent('pages/Index', (err, data) =&gt; {&#x000A;        // 创建ArkWeb动态组件（需传入UIContext），loadContent之后的任意时机均可创建&#x000A;        createNWeb(&quot;https://www.example.com&quot;, windowStage.getMainWindowSync().getUIContext());&#x000A;        if (err.code) {&#x000A;          return;&#x000A;        }&#x000A;      });&#x000A;    }&#x000A;    ```&#x000A;2. 创建NodeContainer和对应的NodeController，渲染后台ArkWeb组件&#x000A;&#x000A;    ```typescript&#x000A;    // 创建NodeController&#x000A;    // common.ets&#x000A;    import { UIContext } from '@kit.ArkUI';&#x000A;    import { webview } from '@kit.ArkWeb';&#x000A;    import { NodeController, BuilderNode, Size, FrameNode }  from '@kit.ArkUI';&#x000A;    // @Builder中为动态组件的具体组件内容&#x000A;    // Data为入参封装类&#x000A;    // 调用onActive，开启渲染&#x000A;    @Builder&#x000A;    function WebBuilder(data:Data) {&#x000A;      Column() {&#x000A;        Web({ src: data.url, controller: data.controller })&#x000A;          .onPageBegin(() =&gt; {&#x000A;            data.controller.onActive();&#x000A;          })&#x000A;          .width(&quot;100%&quot;)&#x000A;          .height(&quot;100%&quot;)&#x000A;      }&#x000A;    }&#x000A;    let wrap = wrapBuilder&lt;Data[]&gt;(WebBuilder);&#x000A;    // 用于控制和反馈对应的NodeContianer上的节点的行为，需要与NodeContainer一起使用&#x000A;    export class myNodeController extends NodeController {&#x000A;      private rootnode: BuilderNode&lt;Data[]&gt; | null = null;&#x000A;      // 必须要重写的方法，用于构建节点数、返回节点挂载在对应NodeContianer中&#x000A;      // 在对应NodeContianer创建的时候调用、或者通过rebuild方法调用刷新&#x000A;      makeNode(uiContext: UIContext): FrameNode | null {&#x000A;        console.info(&quot; uicontext is undifined : &quot;+ (uiContext === undefined));&#x000A;        if (this.rootnode != null) {&#x000A;          // 返回FrameNode节点&#x000A;          return this.rootnode.getFrameNode();&#x000A;        }&#x000A;        // 返回null控制动态组件脱离绑定节点&#x000A;        return null;&#x000A;      }&#x000A;      // 当布局大小发生变化时进行回调&#x000A;      aboutToResize(size: Size) {&#x000A;        console.info(&quot;aboutToResize width : &quot; + size.width  +  &quot; height : &quot; + size.height )&#x000A;      }&#x000A;      // 当controller对应的NodeContainer在Appear的时候进行回调&#x000A;      aboutToAppear() {&#x000A;        console.info(&quot;aboutToAppear&quot;)&#x000A;      }&#x000A;      // 当controller对应的NodeContainer在Disappear的时候进行回调&#x000A;      aboutToDisappear() {&#x000A;        console.info(&quot;aboutToDisappear&quot;)&#x000A;      }&#x000A;      // 此函数为自定义函数，可作为初始化函数使用&#x000A;      // 通过UIContext初始化BuilderNode，再通过BuilderNode中的build接口初始化@Builder中的内容&#x000A;      initWeb(url:string, uiContext:UIContext, control:WebviewController) {&#x000A;        if(this.rootnode != null)&#x000A;        {&#x000A;          return;&#x000A;        }&#x000A;        // 创建节点，需要uiContext&#x000A;        this.rootnode = new BuilderNode(uiContext)&#x000A;        // 创建动态Web组件&#x000A;        this.rootnode.build(wrap, { url:url, controller:control })&#x000A;      }&#x000A;    }&#x000A;    // 创建Map保存所需要的NodeController&#x000A;    let NodeMap:Map&lt;string, myNodeController | undefined&gt; = new Map();&#x000A;    // 创建Map保存所需要的WebViewController&#x000A;    let controllerMap:Map&lt;string, WebviewController | undefined&gt; = new Map();&#x000A;    // 初始化需要UIContext 需在Ability获取&#x000A;    export const createNWeb = (url: string, uiContext: UIContext) =&gt; {&#x000A;      // 创建NodeController&#x000A;      let baseNode = new myNodeController();&#x000A;      let controller = new webview.WebviewController() ;&#x000A;      // 初始化自定义Web组件&#x000A;      baseNode.initWeb(url, uiContext, controller);&#x000A;      controllerMap.set(url, controller)&#x000A;      NodeMap.set(url, baseNode);&#x000A;    }&#x000A;    // 自定义获取NodeController接口&#x000A;    export const getNWeb = (url : string) : myNodeController | undefined =&gt; {&#x000A;      return NodeMap.get(url);&#x000A;    }&#x000A;    ```&#x000A;3. 通过NodeContainer使用已经预渲染的页面&#x000A;&#x000A;    ```typescript&#x000A;    // 使用NodeController的Page页&#x000A;    // Index.ets&#x000A;    import {createNWeb, getNWeb} from &quot;./common&quot;&#x000A;    @Entry&#x000A;    @Component&#x000A;    struct Index {&#x000A;      build() {&#x000A;        Row() {&#x000A;          Column() {&#x000A;            // NodeContainer用于与NodeController节点绑定，rebuild会触发makeNode&#x000A;            // Page页通过NodeContainer接口绑定NodeController，实现动态组件页面显示&#x000A;            NodeContainer(getNWeb(&quot;https://www.example.com&quot;))&#x000A;              .height(&quot;90%&quot;)&#x000A;              .width(&quot;100%&quot;)&#x000A;          }&#x000A;          .width('100%')&#x000A;        }&#x000A;        .height('100%')&#x000A;      }&#x000A;    }&#x000A;    ```&#x000A;&#x000A;&#x000A;### 预取POST请求优化&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;预取POST请求适用于Web页面启动和跳转场景，当即将加载的Web页面中存在POST请求且POST请求耗时较长时，会导致页面加载时间增加，可以选择不同时机对POST请求进行预取，消除等待POST请求数据下载完成的耗时，具体有以下两种场景可供参考：&#x000A;&#x000A;1. 如果是应用首页，推荐在ArkWeb组件创建后或者提前初始化web内核后，对首页的POST请求进行预取，如onCreate、aboutToAppear。&#x000A;2. 当前页面完成加载后，可以对用户下一步可能点击页面的POST请求进行预取，推荐在Web组件的生命周期函数onPageEnd及后继时机进行。&#x000A;&#x000A;注意事项：&#x000A;&#x000A;1. 本方案能消除POST请求下载耗时，预计收益可能在百毫秒（依赖POST请求的数据内容和当前网络环境）。&#x000A;2. 预取POST请求行为包括连接和资源下载，连接和资源加载耗时可能达到百毫秒（依赖POST请求的数据内容和当前网络环境），建议开发者为预下载留出足够的时间。&#x000A;3. 预取POST请求行为相比于预连接会消耗额外的流量、内存，建议针对高频页面使用。&#x000A;4. POST请求具有一定的即时性，预取POST请求需要指定恰当的有效期。&#x000A;5. 目前仅支持预取Context-Type为application/x-www-form-urlencoded的POST请求。最多可以预获取6个POST请求。如果要预获取第7个，会自动清除最早预获取的POST缓存。开发者也可以通过clearPrefetchedResource()接口主动清除后续不再使用的预获取资源缓存。&#x000A;6. 如果要使用预获取的资源缓存，开发者需要在正式发起的POST请求的请求头中增加键值“ArkWebPostCacheKey”，其内容为对应缓存的cacheKey。&#x000A;&#x000A;&#x000A;#### 案例实践&#x000A;&#x000A;&#x000A;##### 场景一：加载包含POST请求的首页&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;当首页中包含POST请求，且POST请求耗时较长时，不推荐直接加载Web页面&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;  &#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: 'https://www.example.com/', controller: this.webviewController })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;通过预取POST加载包含POST请求的首页，具体步骤如下：&#x000A;&#x000A;1. 通过initializeWebEngine()来提前初始化Web组件的内核，然后在初始化内核后调用prefetchResource()预获取将要加载页面中的POST请求。&#x000A;&#x000A;```typescript&#x000A;// EntryAbility.ets&#x000A;import { UIAbility, AbilityConstant, Want } from '@kit.AbilityKit';&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;export default class EntryAbility extends UIAbility {&#x000A;  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {&#x000A;    console.info('EntryAbility onCreate.');&#x000A;    webview.WebviewController.initializeWebEngine();&#x000A;    // 预获取时，需要将&quot;https://www.example1.com/POST?e=f&amp;g=h&quot;替换成为真实要访问的网站地址&#x000A;    webview.WebviewController.prefetchResource(&#x000A;      {&#x000A;        url: 'https://www.example.com/POST?e=f&amp;g=h',&#x000A;        method: 'POST',&#x000A;        formData: 'a=x&amp;b=y'&#x000A;      },&#x000A;      [{&#x000A;        headerKey: 'c',&#x000A;        headerValue: 'z'&#x000A;      }],&#x000A;      'KeyX', 500&#x000A;    );&#x000A;    AppStorage.setOrCreate('abilityWant', want);&#x000A;    console.info('EntryAbility onCreate done.');&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;2. 通过Web组件，加载包含POST请求的Web页面&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;  &#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: 'https://www.example.com/', controller: this.webviewController })&#x000A;        .onPageEnd(() =&gt; {&#x000A;          // 清除后续不再使用的预获取资源缓存&#x000A;          webview.WebviewController.clearPrefetchedResource(['KeyX']);&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;3. 在页面将要加载的JavaScript文件中，发起POST请求，设置请求响应头ArkWebPostCacheKey为对应预取时设置的cachekey值'KeyX'&#x000A;&#x000A;```typescript&#x000A;const xhr = new XMLHttpRequest();&#x000A;xhr.open('POST', 'https://www.example.com/POST?e=f&amp;g=h', true);&#x000A;xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');&#x000A;xhr.setRequestHeader('ArkWebPostCacheKey', 'KeyX');&#x000A;xhr.onload = function () {&#x000A;  if (xhr.status &gt;= 200 &amp;&amp; xhr.status &lt; 300) {&#x000A;    console.info('成功', xhr.responseText);&#x000A;  } else {&#x000A;    console.error('请求失败');&#x000A;  }&#x000A;}&#x000A;const formData = new FormData();&#x000A;formData.append('a', 'x');&#x000A;formData.append('b', 'y');&#x000A;xhr.send(formData);&#x000A;```&#x000A;&#x000A;&#x000A;##### 场景二：加载包含POST请求的下一页&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;当即将加载的Web页面中包含POST请求，且POST请求耗时较长时，不推荐直接加载Web页面&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      // 在适当的时机加载业务用Web组件，本例以Button点击触发为例&#x000A;      Button('加载页面')&#x000A;        .onClick(() =&gt; {&#x000A;          // url请替换为真实地址&#x000A;          this.controller.loadUrl('https://www.example1.com/');&#x000A;        })&#x000A;      Web({ src: 'https://www.example.com/', controller: this.webviewController })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;通过预取POST加载包含POST请求的下一个跳转页面，具体步骤如下：&#x000A;&#x000A;1. 当前页面完成显示后，使用onPageEnd()对即将要加载页面中的POST请求进行预获取。&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      // 在适当的时机加载业务用Web组件，本例以Button点击触发为例&#x000A;      Button('加载页面')&#x000A;        .onClick(() =&gt; {&#x000A;          // url请替换为真实地址&#x000A;          this.controller.loadUrl('https://www.example1.com/');&#x000A;        })&#x000A;      Web({ src: 'https://www.example.com/', controller: this.webviewController })&#x000A;        .onPageEnd(() =&gt; {&#x000A;          // 预获取时，需要将&quot;https://www.example1.com/POST?e=f&amp;g=h&quot;替换成为真实要访问的网站地址&#x000A;          webview.WebviewController.prefetchResource(&#x000A;            {&#x000A;              url: 'https://www.example1.com/POST?e=f&amp;g=h',&#x000A;              method: 'POST',&#x000A;              formData: 'a=x&amp;b=y'&#x000A;            },&#x000A;            [{&#x000A;              headerKey: 'c',&#x000A;              headerValue: 'z'&#x000A;            }],&#x000A;            'KeyX', 500&#x000A;          );&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;2. 将要加载的页面中，js正式发起POST请求，设置请求响应头ArkWebPostCacheKey为对应预取时设置的cachekey值'KeyX'&#x000A;&#x000A;```typescript&#x000A;const xhr = new XMLHttpRequest();&#x000A;xhr.open('POST', 'https://www.example1.com/POST?e=f&amp;g=h', true);&#x000A;xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');&#x000A;xhr.setRequestHeader('ArkWebPostCacheKey', 'KeyX');&#x000A;xhr.onload = function () {&#x000A;  if (xhr.status &gt;= 200 &amp;&amp; xhr.status &lt; 300) {&#x000A;    console.info('成功', xhr.responseText);&#x000A;  } else {&#x000A;    console.error('请求失败');&#x000A;  }&#x000A;}&#x000A;const formData = new FormData();&#x000A;formData.append('a', 'x');&#x000A;formData.append('b', 'y');&#x000A;xhr.send(formData);&#x000A;```&#x000A;&#x000A;&#x000A;### JSBridge优化&#x000A;&#x000A;#### 适用场景&#x000A;应用使用ArkTS、C++语言混合开发，或本身应用架构较贴近于小程序架构，自带C++侧环境，&#x000A;推荐使用ArkWeb在native侧提供的ArkWeb_ControllerAPI、ArkWeb_ComponentAPI实现JSBridge功能。&#x000A;![img.png](images/web_jsbridge_ets_ndk_compare.png)&#x000A;&#x000A;上图为具有普适性的小程序一般架构，其中逻辑层需要应用自带JavaScript运行时，本身已存在C++环境，通过native接口可直接在C++环境中完成与视图层（ArkWeb作为渲染器）的通信，无需再返回ArkTS环境调用JSBridge相关接口。&#x000A;![img.png](images/web_jsbridge_ets_ndk_compare_new.png)&#x000A;native JSBridge方案可以解决ArkTS环境的冗余切换，同时允许回调在非UI线程上报，避免造成UI阻塞。&#x000A;&#x000A;#### 案例实践&#x000A;&#x000A;【反例】&#x000A;&#x000A;使用ArkTS接口实现JSBridge通信。&#x000A;&#x000A;应用侧代码：&#x000A;```typescript&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct WebComponent {&#x000A;  webviewController: webview.WebviewController = new webview.WebviewController();&#x000A;&#x000A;  aboutToAppear() {&#x000A;    // 配置Web开启调试模式&#x000A;    webview.WebviewController.setWebDebuggingAccess(true);&#x000A;  }&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Button('runJavaScript')&#x000A;        .onClick(() =&gt; {&#x000A;          console.info('现在时间是:'+new Date().getTime())&#x000A;          // 前端页面函数无参时，将param删除。&#x000A;          this.webviewController.runJavaScript('htmlTest(param)');&#x000A;        })&#x000A;      Button('runJavaScriptCodePassed')&#x000A;        .onClick(() =&gt; {&#x000A;          // 传递runJavaScript侧代码方法。&#x000A;          this.webviewController.runJavaScript(`function changeColor(){document.getElementById('text').style.color = 'red'}`);&#x000A;        })&#x000A;      Web({ src: $rawfile('index.html'), controller: this.webviewController })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;前端页面代码：&#x000A;```html&#x000A;&lt;!DOCTYPE html&gt;&#x000A;&lt;html&gt;&#x000A;&lt;body&gt;&#x000A;&lt;button type=&quot;button&quot; onclick=&quot;callArkTS()&quot;&gt;Click Me!&lt;/button&gt;&#x000A;&lt;h1 id=&quot;text&quot;&gt;这是一个测试信息，默认字体为黑色，调用runJavaScript方法后字体为绿色，调用runJavaScriptCodePassed方法后字体为红色&lt;/h1&gt;&#x000A;&lt;script&gt;&#x000A;  // 调用有参函数时实现。&#x000A;  var param = &quot;param: JavaScript Hello World!&quot;;&#x000A;  function htmlTest(param) {&#x000A;    document.getElementById('text').style.color = 'green';&#x000A;    document.getElementById('text').innerHTML = '现在时间：'+new Date().getTime()&#x000A;    console.info(param);&#x000A;  }&#x000A;  // 调用无参函数时实现。&#x000A;  function htmlTest() {&#x000A;    document.getElementById('text').style.color = 'green';&#x000A;  }&#x000A;  // Click Me！触发前端页面callArkTS()函数执行JavaScript传递的代码。&#x000A;  function callArkTS() {&#x000A;    changeColor();&#x000A;  }&#x000A;&lt;/script&gt;&#x000A;&lt;/body&gt;&#x000A;&lt;/html&gt;&#x000A;```&#x000A;&#x000A;点击runJavaScript按钮后触发h5页面htmlTest方法，使得页面内容变更为当前时间戳，如下图所示：&#x000A;&#x000A;![img.png](images/web_jsbridge_h5_screen.png)&#x000A;&#x000A;![img.png](images/web_jsbridge_ets_screen.png)&#x000A;&#x000A;经过多轮测试，可以得出从点击原生button到h5触发htmlTest方法，耗时约7ms~9ms。&#x000A;&#x000A;【正例】&#x000A;&#x000A;使用NDK接口实现JSBridge通信。&#x000A;&#x000A;应用侧代码：&#x000A;```typescript&#x000A;import testNapi from 'libentry.so';&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;class testObj {&#x000A;  test(): string {&#x000A;    console.info('ArkUI Web Component');&#x000A;    return &quot;ArkUI Web Component&quot;;&#x000A;  }&#x000A;&#x000A;  toString(): void {&#x000A;    console.info('Web Component toString');&#x000A;  }&#x000A;}&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  webTag: string = 'ArkWeb1';&#x000A;  controller: webview.WebviewController = new webview.WebviewController(this.webTag);&#x000A;  @State testObjtest: testObj = new testObj();&#x000A;&#x000A;  aboutToAppear() {&#x000A;    console.info(&quot;aboutToAppear&quot;)&#x000A;    //初始化web ndk&#x000A;    testNapi.nativeWebInit(this.webTag);&#x000A;  }&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Row() {&#x000A;        Button('runJS hello')&#x000A;          .fontSize(12)&#x000A;          .onClick(() =&gt; {&#x000A;            console.info('start:----&gt;'+new Date().getTime());&#x000A;            testNapi.runJavaScript(this.webTag, &quot;runJSRetStr(\&quot;&quot; + &quot;hello&quot; + &quot;\&quot;)&quot;);&#x000A;          })&#x000A;      }.height('20%')&#x000A;&#x000A;      Row() {&#x000A;        Web({ src: $rawfile('runJS.html'), controller: this.controller })&#x000A;          .javaScriptAccess(true)&#x000A;          .fileAccess(true)&#x000A;          .onControllerAttached(() =&gt; {&#x000A;            console.info(this.controller.getWebId());&#x000A;          })&#x000A;      }.height('80%')&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;hello.cpp作为应用C++侧业务逻辑代码：&#x000A;```C&#x000A;//注册对象及方法，发送脚本到H5执行后的回调，解析存储应用侧传过来的实例等代码逻辑这里不进行展示，开发者根据自身业务场景自行实现。&#x000A;&#x000A;// 发送JS脚本到H5侧执行&#x000A;static napi_value RunJavaScript(napi_env env, napi_callback_info info) {&#x000A;    size_t argc = 2;&#x000A;    napi_value args[2] = {nullptr};&#x000A;    napi_get_cb_info(env, info, &amp;argc, args, nullptr, nullptr);&#x000A;&#x000A;    // 获取第一个参数 webTag&#x000A;    size_t webTagSize = 0;&#x000A;    napi_get_value_string_utf8(env, args[0], nullptr, 0, &amp;webTagSize);&#x000A;    char *webTagValue = new (std::nothrow) char[webTagSize + 1];&#x000A;    size_t webTagLength = 0;&#x000A;    napi_get_value_string_utf8(env, args[0], webTagValue, webTagSize + 1, &amp;webTagLength);&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;, &quot;ndk OH_NativeArkWeb_RunJavaScript webTag:%{public}s&quot;,&#x000A;                 webTagValue);&#x000A;&#x000A;    // 获取第二个参数 jsCode&#x000A;    size_t bufferSize = 0;&#x000A;    napi_get_value_string_utf8(env, args[1], nullptr, 0, &amp;bufferSize);&#x000A;    char *jsCode = new (std::nothrow) char[bufferSize + 1];&#x000A;    size_t byteLength = 0;&#x000A;    napi_get_value_string_utf8(env, args[1], jsCode, bufferSize + 1, &amp;byteLength);&#x000A;&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;,&#x000A;                 &quot;ndk OH_NativeArkWeb_RunJavaScript jsCode len:%{public}zu&quot;, strlen(jsCode));&#x000A;&#x000A;    // 构造runJS执行的结构体&#x000A;    ArkWeb_JavaScriptObject object = {(uint8_t *)jsCode, bufferSize, &amp;JSBridgeObject::StaticRunJavaScriptCallback,&#x000A;                                     static_cast&lt;void *&gt;(jsbridge_object_ptr-&gt;GetWeakPtr())};&#x000A;    controller-&gt;runJavaScript(webTagValue, &amp;object);&#x000A;    return nullptr;&#x000A;}&#x000A;&#x000A;EXTERN_C_START&#x000A;static napi_value Init(napi_env env, napi_value exports) {&#x000A;    napi_property_descriptor desc[] = {&#x000A;        {&quot;nativeWebInit&quot;, nullptr, NativeWebInit, nullptr, nullptr, nullptr, napi_default, nullptr},&#x000A;        {&quot;runJavaScript&quot;, nullptr, RunJavaScript, nullptr, nullptr, nullptr, napi_default, nullptr},&#x000A;    };&#x000A;    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);&#x000A;    return exports;&#x000A;}&#x000A;EXTERN_C_END&#x000A;&#x000A;static napi_module demoModule = {&#x000A;    .nm_version = 1,&#x000A;    .nm_flags = 0,&#x000A;    .nm_filename = nullptr,&#x000A;    .nm_register_func = Init,&#x000A;    .nm_modname = &quot;entry&quot;,&#x000A;    .nm_priv = ((void *)0),&#x000A;    .reserved = {0},&#x000A;};&#x000A;&#x000A;extern &quot;C&quot; __attribute__((constructor)) void RegisterEntryModule(void) { napi_module_register(&amp;demoModule); }&#x000A;```&#x000A;&#x000A;Native侧业务代码entry/src/main/cpp/jsbridge_object.h、entry/src/main/cpp/jsbridge_object.cpp&#x000A;详见[应用侧与前端页面的相互调用(C/C++)](https://gitee.com/openharmony/docs/blob/master/zh-cn/application-dev/web/arkweb-ndk-jsbridge.md)&#x000A;&#x000A;runJS.html作为应用前端页面：&#x000A;&#x000A;```html&#x000A;&lt;!DOCTYPE html&gt;&#x000A;&lt;html lang=&quot;en-gb&quot;&gt;&#x000A;&lt;head&gt;&#x000A;  &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;&#x000A;  &lt;title&gt;run javascript demo&lt;/title&gt;&#x000A;&lt;/head&gt;&#x000A;&lt;body&gt;&#x000A;&lt;h1&gt;run JavaScript Ext demo&lt;/h1&gt;&#x000A;&lt;p id=&quot;webDemo&quot;&gt;&lt;/p&gt;&#x000A;&lt;br&gt;&#x000A;&lt;button type=&quot;button&quot; style=&quot;height:30px;width:200px&quot; onclick=&quot;testNdkProxyObjMethod1()&quot;&gt;test ndk method1 ! &lt;/button&gt;&#x000A;&lt;br&gt;&#x000A;&lt;br&gt;&#x000A;&lt;button type=&quot;button&quot; style=&quot;height:30px;width:200px&quot; onclick=&quot;testNdkProxyObjMethod2()&quot;&gt;test ndk method2 ! &lt;/button&gt;&#x000A;&lt;br&gt;&#x000A;&#x000A;&lt;/body&gt;&#x000A;&lt;script type=&quot;text/javascript&quot;&gt;&#x000A;&#x000A;  function testNdkProxyObjMethod1() {&#x000A;  &#x000A;    //校验ndk方法是否已经注册到window&#x000A;    if (window.ndkProxy == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy undefined&quot;&#x000A;      return &quot;objName undefined&quot;&#x000A;    }&#x000A;&#x000A;    if (window.ndkProxy.method1 == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy method1 undefined&quot;&#x000A;      return &quot;objName  test undefined&quot;&#x000A;    }&#x000A;&#x000A;    if (window.ndkProxy.method2 == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy method2 undefined&quot;&#x000A;      return &quot;objName  test undefined&quot;&#x000A;    }&#x000A;    &#x000A;    //调用ndk注册到window的method1方法，并将结果回显到p标签&#x000A;    var retStr = window.ndkProxy.method1(&quot;hello&quot;, &quot;world&quot;, [1.2, -3.4, 123.456], [&quot;Saab&quot;, &quot;Volvo&quot;, &quot;BMW&quot;, undefined], 1.23456, 123789, true, false, 0,  undefined);&#x000A;    document.getElementById(&quot;webDemo&quot;).innerHTML  = &quot;ndkProxy and method1 is ok, &quot; + retStr;&#x000A;  }&#x000A;  &#x000A;  function testNdkProxyObjMethod2() {&#x000A;  &#x000A;    //校验ndk方法是否已经注册到window&#x000A;    if (window.ndkProxy == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy undefined&quot;&#x000A;      return &quot;objName undefined&quot;&#x000A;    }&#x000A;&#x000A;    if (window.ndkProxy.method1 == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy method1 undefined&quot;&#x000A;      return &quot;objName  test undefined&quot;&#x000A;    }&#x000A;&#x000A;    if (window.ndkProxy.method2 == undefined) {&#x000A;      document.getElementById(&quot;webDemo&quot;).innerHTML = &quot;ndkProxy method2 undefined&quot;&#x000A;      return &quot;objName  test undefined&quot;&#x000A;    }&#x000A;&#x000A;    var student = {&#x000A;      name:&quot;zhang&quot;,&#x000A;      sex:&quot;man&quot;,&#x000A;      age:25&#x000A;    };&#x000A;    var cars = [student, 456, false, 4.567];&#x000A;    let params = &quot;[\&quot;{\\\&quot;scope\\\&quot;]&quot;;&#x000A;&#x000A;    //调用ndk注册到window的method2方法，并将结果回显到p标签&#x000A;    var retStr = window.ndkProxy.method2(&quot;hello&quot;, &quot;world&quot;, false, cars, params);&#x000A;    document.getElementById(&quot;webDemo&quot;).innerHTML  = &quot;ndkProxy and method2 is ok, &quot; + retStr;&#x000A;  }&#x000A;  &#x000A;  function runJSRetStr(data) {&#x000A;    const d = new Date();&#x000A;    let time = d.getTime();&#x000A;    document.getElementById(&quot;webDemo&quot;).innerHTML = new Date().getTime()&#x000A;    return JSON.stringify(time)&#x000A;  }&#x000A;&lt;/script&gt;&#x000A;&lt;/html&gt;&#x000A;```&#x000A;&#x000A;点击runJS hello按钮后触发h5页面runJSRetStr方法，使得页面内容变更为当前时间戳。&#x000A;&#x000A;![img.png](images/web_jsbridge_ndk_ets_screen.png)&#x000A;&#x000A;![img.png](images/web_jsbridge_ndk_h5_screen.png)&#x000A;&#x000A;经过多轮测试，可以得出从点击原生button到h5触发runJSRetStr方法，耗时约2ms~6ms。&#x000A;&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| **通信方式**            | **耗时(局限不同设备和场景，数据仅供参考)** | **说明**            |&#x000A;|---------------------|--------------------------|-------------------|&#x000A;| ArkWeb实现与前端页面通信     | 7ms~9ms                  | ArkTS环境冗余切换,耗时较长  |&#x000A;| ArkWeb、c++实现与前端页面通信 | 2ms~6ms                  | 避免ArkTS环境冗余切换，耗时短 |&#x000A;&#x000A;JSBridge优化方案适用于ArkWeb应用侧与前端网页通信场景，开发者可根据应用架构选择合适的业务通信机制：&#x000A;&#x000A;1.应用使用ArkTS语言开发，推荐使用ArkWeb在ArkTS提供的runJavaScriptExt接口实现应用侧至前端页面的通信，同时使用registerJavaScriptProxy实现前端页面至应用侧的通信。&#x000A;&#x000A;2.应用使用ArkTS、C++语言混合开发，或本身应用结构较贴近于小程序架构，自带C++侧环境，推荐使用ArkWeb在NDK侧提供的OH_NativeArkWeb_RunJavaScript及OH_NativeArkWeb_RegisterJavaScriptProxy接口实现JSBridge功能。&#x000A;&#x000A;&gt; 说明&#x000A;&gt; 开发者需根据当前业务区分是否存在C++侧环境（较为显著标志点为当前应用是否使用了Node API技术进行开发，若是则该应用具备C++侧环境）。&#x000A;&gt; 具备C++侧环境的应用开发，可使用ArkWeb提供的NDK侧JSBridge接口。&#x000A;&gt; 不具备C++侧环境的应用开发，可使用ArkWeb侧JSBridge接口。&#x000A;&#x000A;&#x000A;### 异步JSBridge调用&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;异步JSBridge调用适用于H5侧调用原生或C++侧注册得JSBridge函数场景下，将用户指定的JSBridge接口的调用抛出后，不等待执行结果，&#x000A;以避免在ArkUI主线程负载重时JSBridge同步调用可能导致Web线程等待IPC时间过长，从而造成阻塞的问题。&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;使用ArkTS接口实现JSBridge通信&#x000A;&#x000A;【案例一】&#x000A;&#x000A;步骤1.只注册同步函数&#x000A;```typescript&#x000A;import webview from '@ohos.web.webview';&#x000A;// 定义ETS侧对象及函数&#x000A;class TestObj {&#x000A;  test(testStr:string): string {&#x000A;    let start = Date.now();&#x000A;    // 模拟耗时操作&#x000A;    for(let i = 0; i &lt; 500000; i++) {}&#x000A;    let end = Date.now();&#x000A;    console.info('objName.test start: ' + start);&#x000A;    return 'objName.test Sync function took ' + (end - start) + 'ms';&#x000A;  }&#x000A;  asyncTestBool(testBol:boolean): Promise&lt;string&gt; {&#x000A;    return new Promise((resolve, reject) =&gt; {&#x000A;      let start = Date.now();&#x000A;      // 模拟耗时操作（异步）&#x000A;      setTimeout(() =&gt; {&#x000A;        for(let i = 0; i &lt; 500000; i++) {}&#x000A;        let end = Date.now();&#x000A;        console.info('objAsyncName.asyncTestBool start: ' + start);&#x000A;        resolve('objName.asyncTestBool Async function took ' + (end - start) + 'ms');&#x000A;      }, 0); // 使用0毫秒延迟来模拟立即开始的异步操作&#x000A;    });&#x000A;  }&#x000A;}&#x000A;&#x000A;class WebObj {&#x000A;  webTest(): string {&#x000A;    let start = Date.now();&#x000A;    // 模拟耗时操作&#x000A;    for(let i = 0; i &lt; 500000; i++) {}&#x000A;    let end = Date.now();&#x000A;    console.info('objTestName.webTest start: ' + start);&#x000A;    return 'objTestName.webTest Sync function took ' + (end - start) + 'ms';&#x000A;  }&#x000A;  webString(): string {&#x000A;    let start = Date.now();&#x000A;    // 模拟耗时操作&#x000A;    for(let i = 0; i &lt; 500000; i++) {}&#x000A;    let end = Date.now();&#x000A;    console.info('objTestName.webString start: ' + start);&#x000A;    return 'objTestName.webString Sync function took ' + (end - start) + 'ms'&#x000A;  }&#x000A;}&#x000A;&#x000A;class AsyncObj {&#x000A;&#x000A;  asyncTest(): Promise&lt;string&gt; {&#x000A;    return new Promise((resolve, reject) =&gt; {&#x000A;      let start = Date.now();&#x000A;      // 模拟耗时操作（异步）&#x000A;      setTimeout(() =&gt; {&#x000A;        for (let i = 0; i &lt; 500000; i++) {&#x000A;        }&#x000A;        let end = Date.now();&#x000A;        console.info('objAsyncName.asyncTest start: ' + start);&#x000A;        resolve('objAsyncName.asyncTest Async function took ' + (end - start) + 'ms');&#x000A;      }, 0); // 使用0毫秒延迟来模拟立即开始的异步操作&#x000A;    });&#x000A;  }&#x000A;&#x000A;  asyncString(testStr:string): Promise&lt;string&gt; {&#x000A;    return new Promise((resolve, reject) =&gt; {&#x000A;      let start = Date.now();&#x000A;      // 模拟耗时操作（异步）&#x000A;      setTimeout(() =&gt; {&#x000A;        for (let i = 0; i &lt; 500000; i++) {&#x000A;        }&#x000A;        let end = Date.now();&#x000A;        console.info('objAsyncName.asyncString start: ' + start);&#x000A;        resolve('objAsyncName.asyncString Async function took ' + (end - start) + 'ms');&#x000A;      }, 0); // 使用0毫秒延迟来模拟立即开始的异步操作&#x000A;    });&#x000A;  }&#x000A;}&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;  @State testObjtest: TestObj = new TestObj();&#x000A;  @State webTestObj: WebObj = new WebObj();&#x000A;  @State asyncTestObj: AsyncObj = new AsyncObj();&#x000A;  build() {&#x000A;    Column() {&#x000A;      Button('refresh')&#x000A;        .onClick(()=&gt;{&#x000A;          try{&#x000A;            this.controller.refresh();&#x000A;          } catch (error) {&#x000A;            console.error(`ErrorCode:${(error as BusinessError).code},Message:${(error as BusinessError).message}`)&#x000A;          }&#x000A;        })&#x000A;      Button('Register JavaScript To Window')&#x000A;        .onClick(()=&gt;{&#x000A;          try {&#x000A;            //只注册同步函数&#x000A;            this.controller.registerJavaScriptProxy(this.webTestObj,&quot;objTestName&quot;,[&quot;webTest&quot;,&quot;webString&quot;]);&#x000A;          } catch (error) {&#x000A;            console.error(`ErrorCode:${(error as BusinessError).code},Message:${(error as BusinessError).message}`)&#x000A;          }&#x000A;        })&#x000A;      Web({src: $rawfile('index.html'),controller: this.controller}).javaScriptAccess(true)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;步骤2.H5侧调用JSBridge函数&#x000A;```html&#x000A;&lt;!DOCTYPE html&gt;&#x000A;&lt;html lang=&quot;en&quot;&gt;&#x000A;&lt;head&gt;&#x000A;  &lt;meta charset=&quot;UTF-8&quot;&gt;&#x000A;  &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;&#x000A;  &lt;title&gt;Document&lt;/title&gt;&#x000A;&lt;/head&gt;&#x000A;&lt;body&gt;&#x000A;&lt;button type=&quot;button&quot; onclick=&quot;htmlTest()&quot;&gt; Click Me!&lt;/button&gt;&#x000A;&lt;p id=&quot;demo&quot;&gt;&lt;/p&gt;&#x000A;&lt;p id=&quot;webDemo&quot;&gt;&lt;/p&gt;&#x000A;&lt;p id=&quot;asyncDemo&quot;&gt;&lt;/p&gt;&#x000A;&lt;/body&gt;&#x000A;&lt;script type=&quot;text/javascript&quot;&gt;&#x000A;  async function htmlTest() {&#x000A;    document.getElementById(&quot;demo&quot;).innerHTML = '测试开始:' + new Date().getTime() + '\n';&#x000A;&#x000A;    const time1 = new Date().getTime()&#x000A;    objTestName.webString();&#x000A;    const time2 = new Date().getTime()&#x000A;&#x000A;    objAsyncName.asyncString()&#x000A;    const time3 = new Date().getTime()&#x000A;&#x000A;    objName.asyncTestBool()&#x000A;    const time4 = new Date().getTime()&#x000A;&#x000A;    objName.test();&#x000A;    const time5 = new Date().getTime()&#x000A;&#x000A;    objTestName.webTest();&#x000A;    const time6 = new Date().getTime()&#x000A;    objAsyncName.asyncTest()&#x000A;    const time7 = new Date().getTime()&#x000A;&#x000A;    const result = [&#x000A;      'objTestName.webString()耗时：'+ (time2 - time1),&#x000A;      'objAsyncName.asyncString()耗时：'+ (time3 - time2),&#x000A;      'objName.asyncTestBool()耗时：'+ (time4 - time3),&#x000A;      'objName.test()耗时：'+ (time5 - time4),&#x000A;      'objTestName.webTest()耗时：'+ (time6 - time5),&#x000A;      'objAsyncName.asyncTest()耗时：'+ (time7 - time6),&#x000A;    ]&#x000A;    document.getElementById(&quot;demo&quot;).innerHTML = document.getElementById(&quot;demo&quot;).innerHTML + '\n' + result.join('\n')&#x000A;  }&#x000A;&lt;/script&gt;&#x000A;&lt;/html&gt;&#x000A;```&#x000A;&#x000A;【案例二】&#x000A;&#x000A;步骤1.使用registerJavaScriptProxy或javaScriptProxy注册异步函数或异步同步共存&#x000A;```typescript&#x000A;//registerJavaScriptProxy方式注册&#x000A;Button('refresh')&#x000A;  .onClick(()=&gt;{&#x000A;    try{&#x000A;      this.controller.refresh();&#x000A;    } catch (error) {&#x000A;      console.error(`ErrorCode:${(error as BusinessError).code},Message:${(error as BusinessError).message}`)&#x000A;    }&#x000A;  })&#x000A;Button('Register JavaScript To Window')&#x000A;  .onClick(()=&gt;{&#x000A;    try {&#x000A;      //调用注册接口对象及成员函数，其中同步函数列表必填，空白则需要用[]占位；异步函数列表非必填&#x000A;      //同步、异步函数都注册&#x000A;      this.controller.registerJavaScriptProxy(this.testObjtest,&quot;objName&quot;,[&quot;test&quot;],[&quot;asyncTestBool&quot;]);&#x000A;      //只注册异步函数，同步函数列表处留空&#x000A;      this.controller.registerJavaScriptProxy(this.asyncTestObj,&quot;objAsyncName&quot;,[],[&quot;asyncTest&quot;,&quot;asyncString&quot;]);&#x000A;    } catch (error) {&#x000A;      console.error(`ErrorCode:${(error as BusinessError).code},Message:${(error as BusinessError).message}`)&#x000A;    }&#x000A;  })&#x000A;Web({src: $rawfile('index.html'),controller: this.controller}).javaScriptAccess(true)&#x000A;&#x000A;//javaScriptProxy方式注册&#x000A;//javaScriptProxy只支持注册一个对象，若需要注册多个对象请使用registerJavaScriptProxy&#x000A;Web({src: $rawfile('index.html'),controller: this.controller})&#x000A;  .javaScriptAccess(true)&#x000A;  .javaScriptProxy({&#x000A;    object: this.testObjtest,&#x000A;    name:&quot;objName&quot;,&#x000A;    methodList: [&quot;test&quot;,&quot;toString&quot;],&#x000A;    //指定异步函数列表&#x000A;    asyncMethodList: [&quot;test&quot;,&quot;toString&quot;],&#x000A;    controller: this.controller&#x000A;  })&#x000A;```&#x000A;&#x000A;步骤2.H5侧调用JSBridge函数与反例中一致&#x000A;&#x000A;#### 总结&#x000A;&#x000A;![img.png](images/web_jsbridge_async_compare.png)&#x000A;&#x000A;| **注册方法类型** | **耗时(局限不同设备和场景，数据仅供参考)** | **说明**        |&#x000A;|------------|--------------------------|---------------|&#x000A;| 同步方法       | 1398ms，2707ms，2705ms     | 同步函数调用会阻塞JS线程 |&#x000A;| 异步方法       | 2ms，2ms，4ms              | 异步函数调用不阻塞JS线程 |&#x000A;&#x000A;通过截图可看到async的异步方法不需要等待结果，所以在js单线程任务队列中不会长时间占用，同步任务需要等待原生主线程同步执行后返回结果。&#x000A;&#x000A;&gt;JSBridge接口在注册时，即会根据注册调用的接口决定其调用方式（同步/异步）。开发者需根据当前业务区分，&#x000A;&gt; 是否将其注册为异步函数。&#x000A;&gt;- 同步函数调用将会阻塞JS的执行，等待调用的JSBridge函数执行结束，适用于需要返回值，或者有时序问题等场景。&#x000A;&gt;- 异步函数调用时不会等待JSBridge函数执行结束，后续JS可在短时间后继续执行。但JSBridge函数无法直接返回值。&#x000A;&gt;- 注册在ETS侧的JSBridge函数调用时需要在主线程上执行；NDK侧注册的函数将在其他线程中执行。&#x000A;&gt;- 异步JSBridge接口与同步接口在JS侧的调用方式一致，仅注册方式不同，本部分调用方式仅作简要示范。&#x000A;&#x000A;附NDK接口实现JSBridge通信(C++侧注册异步函数):&#x000A;```c&#x000A;// 定义JSBridge函数&#x000A;static void ProxyMethod1(const char* webTag, void* userData) {&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;, &quot;Method1 webTag :%{public}s&quot;,webTag);&#x000A;}&#x000A;&#x000A;static void ProxyMethod2(const char* webTag, void* userData) {&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;, &quot;Method2 webTag :%{public}s&quot;,webTag);&#x000A;}&#x000A;&#x000A;static void ProxyMethod3(const char* webTag, void* userData) {&#x000A;    OH_LOG_Print(LOG_APP, LOG_INFO, LOG_PRINT_DOMAIN, &quot;ArkWeb&quot;, &quot;Method3 webTag :%{public}s&quot;,webTag);&#x000A;}&#x000A;&#x000A;void RegisterCallback(const char *webTag) {&#x000A;    int myUserData = 100;&#x000A;    //创建函数方法结构体&#x000A;    ArkWeb_ProxyMethod m1 = {&#x000A;        .methodName = &quot;method1&quot;,&#x000A;        .callback = ProxyMethod1,&#x000A;        .userData = (void *)&amp;myUserData&#x000A;    };&#x000A;    ArkWeb_ProxyMethod m2 = {&#x000A;        .methodName = &quot;method2&quot;,&#x000A;        .callback = ProxyMethod2,&#x000A;        .userData = (void *)&amp;myUserData&#x000A;    };&#x000A;    ArkWeb_ProxyMethod m3 = {&#x000A;        .methodName = &quot;method3&quot;,&#x000A;        .callback = ProxyMethod3,&#x000A;        .userData = (void *)&amp;myUserData&#x000A;    };&#x000A;    ArkWeb_ProxyMethod methodList[2] = {m1,m2};&#x000A;    &#x000A;    //创建JSBridge对象结构体&#x000A;    ArkWeb_ProxyObject obj = {&#x000A;        .objName = &quot;ndkProxy&quot;,&#x000A;        .methodList = methodList,&#x000A;        .size = 2,&#x000A;    };&#x000A;    // 获取ArkWeb_Controller API结构体&#x000A;    ArkWeb_AnyNativeAPI* apis = OH_ArkWeb_GetNativeAPI(ArkWeb_NativeAPIVariantKind::ARKWEB_NATIVE_CONTROLLER);&#x000A;    ArkWeb_ControllerAPI* ctrlApi = reinterpret_cast&lt;ArkWeb_ControllerAPI*&gt;(apis);&#x000A;    &#x000A;        // 调用注册接口，注册函数&#x000A;        ctrlApi-&gt;registerJavaScriptProxy(webTag, &amp;obj);&#x000A;    &#x000A;    ArkWeb_ProxyMethod asyncMethodList[1] = {m3};&#x000A;    ArkWeb_ProxyObject obj2 = {&#x000A;        .objName = &quot;ndkProxy&quot;,&#x000A;    .methodList = asyncMethodList,&#x000A;    .size = 1,&#x000A;    };&#x000A;    ctrlApi-&gt;registerAsyncJavaScriptProxy(webTag, &amp;obj2)&#x000A;}&#x000A;```&#x000A;&#x000A;&#x000A;### 预编译JavaScript生成字节码缓存（Code Cache）&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;预编译JavaScript生成字节码缓存适用于在页面加载之前提前将即将使用到的JavaScript文件编译成字节码并缓存到本地，在页面首次加载时节省编译时间。&#x000A;&#x000A;开发者需要创建一个无需渲染的离线Web组件，用于进行预编译，在预编译结束后使用其他Web组件加载对应的业务网页。&#x000A;&#x000A;注意事项：&#x000A;&#x000A;1. 仅使用HTTP或HTTPS协议请求的JavaScript文件可以进行预编译操作。&#x000A;2. 不支持使用了ES6 Module的语法的JavaScript文件生成预编译字节码缓存。&#x000A;3. 通过配置参数中响应头中的E-Tag、Last-Modified对应的值标记JavaScript对应的缓存版本，对应的值发生变动则更新字节码缓存。&#x000A;4. 不支持本地JavaScript文件预编译缓存。&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;在未使用预编译JavaScript前提下，启动加载Web页面&#x000A;&#x000A;```typescript&#x000A;import web_webview from '@ohos.web.webview';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: web_webview.WebviewController = new web_webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      // 在适当的时机加载业务用Web组件，本例以Button点击触发为例&#x000A;      Button('加载页面')&#x000A;        .onClick(() =&gt; {&#x000A;          // url请替换为真实地址&#x000A;          this.controller.loadUrl('https://www.example.com/b.html');&#x000A;        })&#x000A;      Web({ src: 'https://www.example.com/a.html', controller: this.controller })&#x000A;        .fileAccess(true)&#x000A;        .onPageBegin((event) =&gt; {&#x000A;          console.info(`load page begin: ${event?.url}`);&#x000A;        })&#x000A;        .onPageEnd((event) =&gt; {&#x000A;          console.info(`load page end: ${event?.url}`);&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;点击“加载页面”按钮，性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_js_un_pre_compile.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;使用预编译JavaScript生成字节码缓存，具体步骤如下：&#x000A;&#x000A;1. 配置预编译的JavaScript文件信息&#x000A;&#x000A;```typescript&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;&#x000A;interface Config {&#x000A;  url: string,&#x000A;  localPath: string, // 本地资源路径&#x000A;  options: webview.CacheOptions&#x000A;}&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  // 配置预编译的JavaScript文件信息&#x000A;  configs: Array&lt;Config&gt; = [&#x000A;    {&#x000A;      url: 'https://www/example.com/example.js',&#x000A;      localPath: 'example.js',&#x000A;      options: {&#x000A;        responseHeaders: [&#x000A;          { headerKey: 'E-Tag', headerValue: 'aWO42N9P9dG/5xqYQCxsx+vDOoU=' },&#x000A;          { headerKey: 'Last-Modified', headerValue: 'Web, 21 Mar 2024 10:38:41 GMT' }&#x000A;        ]&#x000A;      }&#x000A;    }&#x000A;  ]&#x000A;  // ...&#x000A;}&#x000A;```&#x000A;&#x000A;2. 读取配置，进行预编译&#x000A;&#x000A;```typescript&#x000A;Web({ src: 'https://www.example.com/a.html', controller: this.controller })&#x000A;  .onControllerAttached(async () =&gt; {&#x000A;    // 读取配置，进行预编译&#x000A;    for (const config of this.configs) {&#x000A;      let content = await getContext().resourceManager.getRawFileContentSync(config.localPath);&#x000A;&#x000A;      try {&#x000A;        this.controller.precompileJavaScript(config.url, content, config.options)&#x000A;          .then((errCode: number) =&gt; {&#x000A;            console.info('precompile successfully!' );&#x000A;          }).catch((errCode: number) =&gt; {&#x000A;          console.error('precompile failed.' + errCode);&#x000A;        })&#x000A;      } catch (err) {&#x000A;        console.error('precompile failed!.' + err.code + err.message);&#x000A;      }&#x000A;    }&#x000A;  })&#x000A;```&#x000A;&#x000A;&#x000A;点击“加载页面”按钮，性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_js_pre_compile.png)&#x000A;&#x000A;&#x000A;  &gt; 说明&#x000A;  &gt;&#x000A;  &gt; 当需要更新本地已经生成的编译字节码时，修改cacheOptions参数中的responseHeaders中的E-Tag或Last-Modified响应头对应的值，再次调用接口即可。&#x000A;&#x000A;&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 直接加载Web页面  | 3183ms | 在触发页面加载时才进行JavaScript编译，增加加载时间 |&#x000A;| 预编译JavaScript生成字节码缓存  | 268ms | 加载页面前完成预编译JavaScript，节省了跳转页面首次加载的编译时间 |&#x000A;&#x000A;&#x000A;&#x000A;### 支持自定义协议的JavaScript生成字节码缓存（Code Cache）&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;支持自定义协议的JavaScript生成字节码缓存适用于在页面加载时存在自定义协议的JavaScript文件，支持其生成字节码缓存到本地，在页面非首次加载时节省编译时间。具体操作步骤如下：&#x000A;&#x000A;1. 开发者首先需要在Web组件运行前，向Web组件注册自定义协议。&#x000A;&#x000A;2. 其次需要拦截自定义协议的JavaScript，设置ResponseData和ResponseDataID，ResponseData为JavaScript内容，ResponseDataID用于区分JavaScript内容是否发生变更。若JavaScript内容变更，ResponseDataID需要一起变更。&#x000A;&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;##### 场景一 调用ArkTS接口， webview.WebviewController.customizeSchemes(schemes: Array&lt;WebCustomScheme&gt;): void&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;直接加载包含自定义协议的JavaScript的Web页面&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;import { BusinessError } from '@kit.BasicServicesKit';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;  // 创建scheme对象，isCodeCacheSupported为false时不支持自定义协议的JavaScript生成字节码缓存&#x000A;  scheme: webview.WebCustomScheme = { schemeName: 'scheme', isSupportCORS: true, isSupportFetch: true, isCodeCacheSupported: false };&#x000A;  // 请求数据&#x000A;  @State jsData: string = 'xxx';&#x000A;&#x000A;  aboutToAppear(): void {&#x000A;    try {&#x000A;      webview.WebviewController.customizeSchemes([this.scheme]);&#x000A;    } catch (error) {&#x000A;      const e: BusinessError = error as BusinessError;&#x000A;      console.error(`ErrorCode: ${e.code}, Message: ${e.message}`);&#x000A;    }&#x000A;  }&#x000A;  build() {&#x000A;    Column({ space: 10 }) {&#x000A;      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {&#x000A;        Web({&#x000A;          // 需将'https://www.example.com/'替换为真是的包含自定义协议的JavaScript的Web页面地址&#x000A;          src: 'https://www.example.com/',&#x000A;          controller: this.controller&#x000A;        })&#x000A;          .fileAccess(true)&#x000A;          .javaScriptAccess(true)&#x000A;          .onInterceptRequest(event =&gt; {&#x000A;            const responseResource: WebResourceResponse = new WebResourceResponse();&#x000A;            // 拦截页面请求&#x000A;            if (event?.request.getRequestUrl() === 'scheme1://www.example.com/test.js') {&#x000A;              responseResource.setResponseHeader([&#x000A;                {&#x000A;                  headerKey: 'ResponseDataId',&#x000A;                  // 格式：不超过13位的纯数字。JS识别码，JS有更新时必须更新该字段&#x000A;                  headerValue: '0000000000001'&#x000A;                }&#x000A;              ]);&#x000A;              responseResource.setResponseData(this.jsData);&#x000A;              responseResource.setResponseEncoding('utf-8');&#x000A;              responseResource.setResponseMimeType('application/javascript');&#x000A;              responseResource.setResponseCode(200);&#x000A;              responseResource.setReasonMessage('OK');&#x000A;              return responseResource;&#x000A;            }&#x000A;            return null;&#x000A;          })&#x000A;      }&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_schemes_un_customize.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;支持自定义协议JS生成字节码缓存，具体步骤如下：&#x000A;&#x000A;1. 将scheme对象属性isCodeCacheSupported设置为true，支持自定义协议的JavaScript生成字节码缓存。&#x000A;&#x000A;```typescript&#x000A;scheme: webview.WebCustomScheme = { schemeName: 'scheme', isSupportCORS: true, isSupportFetch: true, isCodeCacheSupported: true };&#x000A;```&#x000A;&#x000A;2. 在Web组件运行前，向Web组件注册自定义协议。&#x000A;&#x000A;  &gt; 说明&#x000A;  &gt; 不得与Web内核内置协议相同。&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;aboutToAppear(): void {&#x000A;  try {&#x000A;    webview.WebviewController.customizeSchemes([this.scheme]);&#x000A;  } catch (error) {&#x000A;    const e: BusinessError = error as BusinessError;&#x000A;    console.error(`ErrorCode: ${e.code}, Message: ${e.message}`);&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;3. 拦截自定义协议的JavaScript，设置ResponseData和ResponseDataID。ResponseData为JS内容，ResponseDataID用于区分JS内容是否发生变更。&#x000A;&#x000A;  &gt; 说明&#x000A;  &gt; 若JS内容变更，ResponseDataID需要一起变更。&#x000A;&#x000A;```typescript&#x000A;// xxx.ets&#x000A;Web({&#x000A;  // 需将'https://www.example.com/'替换为真是的包含自定义协议的JavaScript的Web页面地址&#x000A;  src: 'https://www.example.com/',&#x000A;  controller: this.controller&#x000A;})&#x000A;  .fileAccess(true)&#x000A;  .javaScriptAccess(true)&#x000A;  .onInterceptRequest(event =&gt; {&#x000A;    const responseResource: WebResourceResponse = new WebResourceResponse();&#x000A;    // 拦截页面请求&#x000A;    if (event?.request.getRequestUrl() === 'scheme1://www.example.com/test.js') {&#x000A;      responseResource.setResponseHeader([&#x000A;        {&#x000A;          headerKey: 'ResponseDataId',&#x000A;          // 格式：不超过13位的纯数字。JS识别码，JS有更新时必须更新该字段&#x000A;          headerValue: '0000000000001'&#x000A;        }&#x000A;      ]);&#x000A;      responseResource.setResponseData(this.jsData2);&#x000A;      responseResource.setResponseEncoding('utf-8');&#x000A;      responseResource.setResponseMimeType('application/javascript');&#x000A;      responseResource.setResponseCode(200);&#x000A;      responseResource.setReasonMessage('OK');&#x000A;      return responseResource;&#x000A;    }&#x000A;    return null;&#x000A;  })&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_schemes_customize.png)&#x000A;&#x000A;&#x000A;##### 场景二 调用Native接口，int32_t OH_ArkWeb_RegisterCustomSchemes(const char * scheme, int32_t option)&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;通过网络拦截接口对Web组件发出的请求进行拦截，Demo工程构建请参考[拦截Web组件发起的网络请求](https://gitee.com/openharmony/docs/blob/master/zh-cn/application-dev/web/web-scheme-handler.md)&#x000A;&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Avg Wall Duration为两次加载页面开始到结束的平均耗时：&#x000A;&#x000A;![](images/web_schemes_un_registe.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;支持将自定义协议的JavaScript资源生成code cache，具体步骤如下：&#x000A;&#x000A;1. 注册三方协议配置时，传入ARKWEB_SCHEME_OPTION_CODE_CACHE_ENABLED参数。&#x000A;&#x000A;```c&#x000A;// 注册三方协议的配置，需要在Web内核初始化之前调用，否则会注册失败。&#x000A;static napi_value RegisterCustomSchemes(napi_env env, napi_callback_info info)&#x000A;{&#x000A;  OH_LOG_INFO(LOG_APP, &quot;register custom schemes&quot;);&#x000A;  OH_ArkWeb_RegisterCustomSchemes(&quot;custom&quot;, ARKWEB_SCHEME_OPTION_STANDARD | ARKWEB_SCHEME_OPTION_CORS_ENABLED | ARKWEB_SCHEME_OPTION_CODE_CACHE_ENABLED);&#x000A;  return nullptr;&#x000A;}&#x000A;```&#x000A;&#x000A;2. 设置ResponsesDataId。&#x000A;&#x000A;```c&#x000A;// 在worker线程中读取rawfile，并通过ResourceHandler返回给Web内核&#x000A;void RawfileRequest::ReadRawfileDataOnWorkerThread() {&#x000A;    // ...&#x000A;    if ('test-cc.js' == rawfilePath()) {&#x000A;        OH_ArkWebResponse_SetHeaderByName(response(), &quot;ResponseDataID&quot;, &quot;0000000000001&quot;, true);&#x000A;    }&#x000A;    OH_ArkWebResponse_SetCharset(response(), &quot;UTF-8&quot;);&#x000A;}&#x000A;```&#x000A;&#x000A;3. 注册三方协议的配置，设置SchemeHandler。&#x000A;&#x000A;```typescript&#x000A;// EntryAbility.ets&#x000A;import { UIAbility, AbilityConstant, Want } from '@kit.AbilityKit';&#x000A;import { webview } from '@kit.ArkWeb';&#x000A;import { window } from '@kit.ArkUI';&#x000A;import testNapi from 'libentry.so';&#x000A;&#x000A;export default class EntryAbility extends UIAbility {&#x000A;  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {&#x000A;    // 注册三方协议的配置&#x000A;    testNapi.registerCustomSchemes();&#x000A;    // 初始化Web组件内核，该操作会初始化Brownser进程以及创建BrownserContext&#x000A;    webview.WebviewController.initializeWebEngine();&#x000A;    // 设置SchemeHandler&#x000A;    testNapi.setSchemeHandler();&#x000A;  }&#x000A;  // ...&#x000A;}&#x000A;```&#x000A;&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Avg Wall Duration为两次加载页面开始到结束的平均耗时：&#x000A;&#x000A;![](images/web_schemes_registe.png)&#x000A;&#x000A;&#x000A;&#x000A;#### 总结(以Native接口性能数据举例)&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 直接加载Web页面  | 8ms | 在触发页面加载时才进行JavaScript编译，增加加载时间 |&#x000A;| 自定义协议的JavaScript生成字节码缓存  | 4ms | 支持自定义协议头的JS文件在第二次加载JS时生成code cache,节约了第三次及之后的页面加载或跳转的自定义协议JS文件的编译时间，提升了页面加载和跳转的性能 |&#x000A;&#x000A;&#x000A;&#x000A;### 离线资源免拦截注入&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;离线资源免拦截注入适用于在页面加载之前提前将即将使用到的图片、样式表和脚本资源注入到内存缓存中，在页面首次加载时节省网络请求时间。&#x000A;&#x000A;注意事项：&#x000A;&#x000A;1. 开发者需创建一个无需渲染的离线Web组件，用于将资源注入到内存缓存中，使用其他Web组件加载对应的业务网页。&#x000A;2. 仅使用HTTP或HTTPS协议请求的资源可被注入进内存缓存。&#x000A;3. 内存缓存中的资源由内核自动管理，当注入的资源过多导致内存压力过大，内核自动释放未使用的资源，应避免注入大量资源到内存缓存中。&#x000A;4. 正常情况下，资源的有效期由提供的Cache-Control或Expires响应头控制其有效期，默认的有效期为86400秒，即1天。&#x000A;5. 资源的MIMEType通过提供的参数中的Content-Type响应头配置，Content-Type需符合标准，否则无法正常使用，MODULE_JS必须提供有效的MIMEType，其他类型可不提供。&#x000A;6. 仅支持通过HTML中的标签加载。&#x000A;7. 如果业务网页中的script标签使用了crossorigin属性，则必须在接口的responseHeaders参数中设置Cross-Origin响应头的值为anoymous或use-credentials。&#x000A;8. 当调用web_webview.WebviewController.SetRenderProcessMode(web_webview.RenderProcessMode.MULTIPLE)接口后，应用会启动多渲染进程模式，此方案在此场景下不会生效。&#x000A;9. 单次调用最大支持注入30个资源，单个资源最大支持10Mb。&#x000A;&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;直接加载Web页面&#x000A;&#x000A;```typescript&#x000A;import webview from '@ohos.web.webview';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      // 在适当的时机加载业务用Web组件，本例以Button点击触发为例&#x000A;      Button('加载页面')&#x000A;        .onClick(() =&gt; {&#x000A;          this.controller.loadUrl('https://www.example.com/b.html');&#x000A;        })&#x000A;      Web({ src: 'https://www.example.com/a.html', controller: this.controller })&#x000A;        .fileAccess(true)&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_resource_un_offline.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;使用资源免拦截注入加载Web页面，请参考以下步骤：&#x000A;&#x000A;1. 创建资源配置&#x000A;&#x000A;```typescript&#x000A;interface ResourceConfig {&#x000A;  urlList: Array&lt;string&gt;;&#x000A;  type: webview.OfflineResourceType;&#x000A;  responseHeaders: Array&lt;Header&gt;;&#x000A;  localPath: string; // 本地资源存放在rawfile目录下的路径&#x000A;}&#x000A;&#x000A;const configs: Array&lt;ResourceConfig&gt; = [&#x000A;  {&#x000A;    localPath: 'example.png',&#x000A;    urlList: [&#x000A;      // 多url场景，第一个url作为资源的源&#x000A;      'https://www.example.com/',&#x000A;      'https://www.example.com/path1/example.png',&#x000A;      'https://www.example.com/path2/example.png'&#x000A;    ],&#x000A;    type: webview.OfflineResourceType.IMAGE,&#x000A;    responseHeaders: [&#x000A;      { headerKey: 'Cache-Control', headerValue: 'max-age=1000' },&#x000A;      { headerKey: 'Content-Type', headerValue: 'image/png' }&#x000A;    ]&#x000A;  },&#x000A;  {&#x000A;    localPath: 'example.js',&#x000A;    urlList: [&#x000A;      // 仅提供一个url，这个url既作为资源的源，也作为资源的网络请求地址&#x000A;      'https://www.example.com/example.js'&#x000A;    ],&#x000A;    type: webview.OfflineResourceType.CLASSIC_JS,&#x000A;    responseHeaders: [&#x000A;      // 以&lt;script crossorigin='anonymous'/&gt;方式使用，提供额外的响应头&#x000A;      { headerKey: 'Cross-Origin', headerValue: 'anonymous' }&#x000A;    ]&#x000A;  }&#x000A;];&#x000A;&#x000A;```&#x000A;&#x000A;2. 读取配置，注入资源&#x000A;&#x000A;```typescript&#x000A;Web({ src: 'https://www.example.com/a.html', controller: this.controller })&#x000A;  .onControllerAttached(async () =&gt; {&#x000A;    try {&#x000A;      const resourceMapArr: Array&lt;webview.OfflineResourceMap&gt; = [];&#x000A;      // 读取配置，从rawfile目录中读取文件内容&#x000A;      for (const config of this.configs) {&#x000A;        const buf: Uint8Array = await getContext().resourceManager.getRawFileContentSync(config.localPath);&#x000A;        resourceMapArr.push({&#x000A;          urlList: config.urlList,&#x000A;          resource: buf,&#x000A;          responseHeaders: config.responseHeaders,&#x000A;          type: config.type&#x000A;        });&#x000A;      }&#x000A;      // 注入资源&#x000A;      this.controller.injectOfflineResources(resourceMapArr);&#x000A;    } catch (err) {&#x000A;      console.error('error: ' + err.code + ' ' + err.message);&#x000A;    }&#x000A;  })&#x000A;```&#x000A;&#x000A;性能打点数据如下，getMessageData进程中的Duration为加载页面开始到结束的耗时：&#x000A;&#x000A;![](images/web_resource_offline.png)&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 直接加载Web页面  | 1312ms | 在触发页面加载时才发起资源请求，增加页面加载时间 |&#x000A;| 使用离线资源免拦截注入加载Web页面  | 74ms | 将资源预置在内存中，节省了网络请求时间 |&#x000A;&#x000A;&#x000A;&#x000A;### 资源拦截替换加速&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;资源拦截替换加速在原本的资源拦截替换接口基础上新增支持了ArrayBuffer格式的入参，开发者无需在应用侧进行ArrayBuffer到String格式的转换，可直接使用ArrayBuffer格式的数据进行拦截替换。&#x000A;&#x000A;  &gt; 说明&#x000A;  &gt;&#x000A;  &gt; 本方案与原本的资源拦截替换接口在使用上没有任何区别，开发者仅需在调用WebResourceResponse.setResponseData()接口时传入ArrayBuffer格式的数据即可。&#x000A;&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;使用字符串格式的数据做拦截替换&#x000A;&#x000A;```typescript&#x000A;import webview from '@ohos.web.webview';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;  responseResource: WebResourceResponse = new WebResourceResponse();&#x000A;  // 这里是string格式数据&#x000A;  resourceStr: string = 'xxxxxxxxxxxxxxx';&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: 'https:www.example.com/test.html', controller: this.controller })&#x000A;        .onInterceptRequest(event =&gt; {&#x000A;          if (event) {&#x000A;            if (!event.request.getRequestUrl().startsWith('https://www.example.com/')) {&#x000A;              return null;&#x000A;            }&#x000A;          }&#x000A;          // 使用string格式的数据做拦截替换&#x000A;          this.responseResource.setResponseData(this.resourceStr);&#x000A;          this.responseResource.setResponseEncoding('utf-8');&#x000A;          this.responseResource.setResponseMimeType('text/json');&#x000A;          this.responseResource.setResponseCode(200);&#x000A;          this.responseResource.setReasonMessage('OK');&#x000A;          this.responseResource.setResponseHeader([{ headerKey: 'Access-Control-Allow-Origin', headerValue: '*' }]);&#x000A;          return this.responseResource;&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;资源替换耗时如图所示，getMessageData ... someFunction took后的时间页面加载资源的耗时：&#x000A;&#x000A;![](images/web_send_response_data_string.png)&#x000A;&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;使用ArrayBuffer格式的数据做拦截替换&#x000A;&#x000A;```typescript&#x000A;import webview from '@ohos.web.webview';&#x000A;&#x000A;@Entry&#x000A;@Component&#x000A;struct Index {&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;  responseResource: WebResourceResponse = new WebResourceResponse();&#x000A;  // 这里是ArrayBuffer格式数据&#x000A;  buffer: ArrayBuffer = new ArrayBuffer(10);&#x000A;&#x000A;  build() {&#x000A;    Column() {&#x000A;      Web({ src: 'https:www.example.com/test.html', controller: this.controller })&#x000A;        .onInterceptRequest(event =&gt; {&#x000A;          if (event) {&#x000A;            if (!event.request.getRequestUrl().startsWith('https://www.example.com/')) {&#x000A;              return null;&#x000A;            }&#x000A;          }&#x000A;          // 使用ArrayBuffer格式的数据做拦截替换&#x000A;          this.responseResource.setResponseData(this.buffer);&#x000A;          this.responseResource.setResponseEncoding('utf-8');&#x000A;          this.responseResource.setResponseMimeType('text/json');&#x000A;          this.responseResource.setResponseCode(200);&#x000A;          this.responseResource.setReasonMessage('OK');&#x000A;          this.responseResource.setResponseHeader([{ headerKey: 'Access-Control-Allow-Origin', headerValue: '*' }]);&#x000A;          return this.responseResource;&#x000A;        })&#x000A;    }&#x000A;  }&#x000A;}&#x000A;```&#x000A;&#x000A;资源替换耗时如图所示，getMessageData william someFunction took后的时间页面加载资源的耗时：&#x000A;&#x000A;![](images/web_send_response_data_buffer.png)&#x000A;&#x000A;&#x000A;&#x000A;#### 总结&#x000A;&#x000A;&#x000A;| **页面加载方式** | **耗时(局限不同设备和场景，数据仅供参考)**  | **说明** |&#x000A;| ------ | ------- | ------------------------------------- |&#x000A;| 使用string格式的数据做拦截替换  | 34ms | Web组件内部数据传输仍需要转换为ArrayBuffer，增加数据处理步骤，增加启动耗时 |&#x000A;| 使用ArrayBuffer格式的数据做拦截替换  | 13ms | 接口直接支持ArrayBuffer格式，节省了转换时间，同时对ArrayBuffer格式的数据传输方式进行了优化，进一步减少耗时 |&#x000A;&#x000A;### 预加载优化滑动白块&#x000A;&#x000A;Web场景应用在加载图片资源时，需要先发起请求，然后解析渲染到屏幕上。在列表滑动过程中，如果等屏幕可视区域出现新图片时才开始发起请求，会因上述加载资源的步骤出现时间差，导致列表中图片出现白块问题，在网络情况不良或应用渲染图片阻塞时，这种情况会更加严重。本章节针对Web场景，在HTML页面中使用预加载策略，使列表滑动前预先加载可视区域外的图片资源，解决可视区域白块问题，提高用户使用体验。&#x000A;&#x000A;#### 原理介绍&#x000A;&#x000A;滑动白块的产生主要来源于页面滑动场景组件可见和组件上屏刷新之间的时间差，在这两个时间点间，由于网络图片未加载完成，该区域显示的是默认图片即图片白块。图片组件从可见到上屏刷新之间的耗时主要是由图片资源网络请求和解码渲染两部分组成，在这段时间内页面滑动距离是滑动速度(px/ms)*(下载耗时+解码耗时)(ms)，因此只要设置预加载的高度大于滑动距离，就可以保证页面基本无白块。开发者可根据`预加载高度(px)&gt;滑动速度(px/ms)*(下载耗时+解码耗时)(ms)`这一计算公式对应用进行调整，计算出Web页面在设备视窗外需要预加载的图片个数，即可视窗口根元素超过屏幕的高度。&#x000A;&#x000A;开发者可以使用IntersectionObserver接口，将视窗作为根元素并对其进行观察，当图片滑动进入视窗时替换默认地址为真实地址，触发图片加载。此时适当的扩展视窗高度，就可以实现在图片进入视窗前提前开始加载图片，解决图片未及时加载导致出现白块的问题。&#x000A;&#x000A;#### 实践案例&#x000A;&#x000A;【不推荐用法】&#x000A;&#x000A;常规案例使用懒加载的逻辑加载图片，图片组件进入可视区域后再执行加载，滑动过程中列表有大量图片未加载完成产生的白块。&#x000A;&#x000A;![img](./figures/web-sliding-white-block-optimization-1.gif)&#x000A;&#x000A;```html&#x000A;&lt;!DOCTYPE html&gt;&#x000A;&lt;html&gt;&#x000A;    &lt;head&gt;&#x000A;        &lt;title&gt;Image List&lt;/title&gt;&#x000A;    &lt;/head&gt;&#x000A;    &lt;body&gt;&#x000A;        &lt;ul&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo1.jpg&quot; alt=&quot;Photo 1&quot;&gt;&lt;/li&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo2.jpg&quot; alt=&quot;Photo 2&quot;&gt;&lt;/li&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo3.jpg&quot; alt=&quot;Photo 3&quot;&gt;&lt;/li&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo4.jpg&quot; alt=&quot;Photo 4&quot;&gt;&lt;/li&gt;&#x000A;            &lt;li&gt;&lt;img src=&quot;default.jpg&quot; data-src=&quot;photo5.jpg&quot; alt=&quot;Photo 5&quot;&gt;&lt;/li&gt;&#x000A;            &lt;!-- 添加更多的图片只需要复制并修改src和alt属性即可 --&gt;&#x000A;        &lt;/ul&gt;&#x000A;    &lt;/body&gt;&#x000A;    &lt;script&gt;&#x000A;        window.onload = function(){&#x000A;          // 可视窗口作为根元素，不进行扩展&#x000A;          const options = {root:document,rootMargin:'0% 0% 0% 0%'}&#x000A;          // 创建一个IntersectionObserver实例&#x000A;          const observer = new IntersectionObserver(function(entries,observer){&#x000A;            entries.forEach(function(entry){&#x000A;              // 检查图片是否进入可视区域&#x000A;              if(entry.isIntersecting){&#x000A;                const image = entry.target;&#x000A;                // 将数据源的src赋值给img的src&#x000A;                image.src = image.dataset.src;&#x000A;                // 停止观察该图片&#x000A;                observer.unobserve(image);&#x000A;              }&#x000A;            })&#x000A;          },options);&#x000A;          &#x000A;          document.querySelectorAll('img').forEach(img =&gt; { observer.observe(img) });&#x000A;        }&#x000A;    &lt;/script&gt;&#x000A;&lt;/html&gt;&#x000A;```&#x000A;&#x000A;【推荐用法】&#x000A;&#x000A;根据上方公式，优化案例设定在400mm/s的速度滑动屏幕，此时可计算应用需预加载0.5个屏幕高度的图片。在常规加载案例中，页面将可视窗口作为根元素，rootMargin属性均为0，可视窗口与设备屏幕高度相等。此时可通过设置`rootMargin`向下方向为50%（即0.5个屏幕高度），扩展可视窗口的高度，使图片在屏幕外提前进入可视窗口。当图片元素进入可视窗口时，会将&lt;img&gt;标签的data-src属性中保存的图片地址赋值给src属性，从而实现图片的预加载。应用会查询页面上所有具有data-src属性的&lt;img&gt;标签，并开始观察这些图片。当某张图片进入已拓展高度的可视窗口时，就会执行相应的加载操作，实现页面预渲染更多图片，解决滑动白块问题。&#x000A;&#x000A;```javascript&#x000A;// html结构与上方常规案例相同&#x000A;// 可视区域作为根元素，向下扩展50%的margin长度&#x000A;const options = {root:document,rootMargin:'0% 0% 50% 0%'};&#x000A;// 创建IntersectionObserver实例&#x000A;const observer = new IntersectionObserver(function(entries,observer){&#x000A;  // ...&#x000A;},options);&#x000A;&#x000A;document.querySelectorAll('img').forEach(img =&gt; {observer.observe(img)});&#x000A;```&#x000A;&#x000A;![img](figures/web-sliding-white-block-optimization-2.gif)&#x000A;&#x000A;#### 总结&#x000A;&#x000A;| 图片加载方式      | 说明                                     |&#x000A;|-------------|----------------------------------------|&#x000A;| 常规加载（不推荐用法） | 常规案例在列表滑动过程中，由于图片加载未及时导致出现大量白块，影响用户体验。 |&#x000A;| 预加载（推荐用法）   | 优化案例在拓展0.5个屏幕高度的可视窗口后，滑动时无明显白块，用户体验提升。 |&#x000A;&#x000A;开发者可使用公式，根据设备屏幕高度和设置滑动屏幕速度预估值，计算出视窗根元素需要扩展的高度，解决滑动白块问题。&#x000A;&#x000A;## 性能分析&#x000A;&#x000A;### 场景示例&#x000A;&#x000A;构建通过点击按钮跳转Web网页和在网页内跳转页面的场景，在点击按钮触发跳转事件、Web组件触发OnPageEnd事件处使用Hilog打点记录时间戳。&#x000A;&#x000A;#### 反例&#x000A;&#x000A;入口页通过router实现跳转&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebUninitialized.ets&#x000A;&#x000A;// ...&#x000A;Button('进入网页')&#x000A;  .onClick(() =&gt; {&#x000A;    hilog.info(0x0001, &quot;WebPerformance&quot;, &quot;UnInitializedWeb&quot;);&#x000A;    router.pushUrl({ url: 'pages/WebBrowser' });&#x000A;  })&#x000A;```&#x000A;Web页使用Web组件加载指定网页&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebBrowser.ets&#x000A;&#x000A;// ...&#x000A;Web({ src: 'https://www.example.com', controller: this.controller })&#x000A;  .domStorageAccess(true)&#x000A;  .onPageEnd((event) =&gt; {&#x000A;     if (event) {&#x000A;       hilog.info(0x0001, &quot;WebPerformance&quot;, &quot;WebPageOpenEnd&quot;);&#x000A;     }&#x000A;  })&#x000A;```&#x000A;&#x000A;#### 正例&#x000A;&#x000A;入口页提前进行Web组件的初始化和预连接&#x000A;&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebInitialized.ets&#x000A;&#x000A;import webview from '@ohos.web.webview';&#x000A;&#x000A;// ...&#x000A;Button('进入网页')&#x000A;  .onClick(() =&gt; {&#x000A;     hilog.info(0x0001, &quot;WebPerformance&quot;, &quot;InitializedWeb&quot;);&#x000A;     router.pushUrl({ url: 'pages/WebBrowser' });&#x000A;  })&#x000A;// ...&#x000A;aboutToAppear() {&#x000A;  webview.WebviewController.initializeWebEngine();&#x000A;  webview.WebviewController.prepareForPageLoad(&quot;https://www.example.com&quot;, true, 2);&#x000A;}&#x000A;```&#x000A;Web页加载的同时使用prefetchPage预加载下一页&#x000A;```javascript&#x000A;// ../src/main/ets/pages/WebBrowser.ets&#x000A;&#x000A;import webview from '@ohos.web.webview';&#x000A;&#x000A;  // ...&#x000A;  controller: webview.WebviewController = new webview.WebviewController();&#x000A;    // ...&#x000A;    Web({ src: 'https://www.example.com', controller: this.controller })&#x000A;      .domStorageAccess(true)&#x000A;      .onPageEnd((event) =&gt; {&#x000A;         if (event) {&#x000A;           hilog.info(0x0001, &quot;WebPerformance&quot;, &quot;WebPageOpenEnd&quot;);&#x000A;           this.controller.prefetchPage('https://www.example.com/nextpage');&#x000A;         }&#x000A;      })&#x000A;```&#x000A;&#x000A;### 数据对比&#x000A;&#x000A;通过分别抓取正反示例的trace数据后使用SmartPerf Host工具分析可以得出以下结论：&#x000A;&#x000A;![hilog](./figures/web-hilog.png)&#x000A;&#x000A;从点击按钮进入Web首页到Web组件触发OnPageEnd事件，表示首页加载完成。对比优化前后时延可以得出，使用提前初始化内核和预解析、预连接可以减少平均100ms左右的加载时间。&#x000A;&#x000A;![首页完成时延](./figures/web-open-time-chart.png)&#x000A;&#x000A;从Web首页内点击跳转下一页按钮到Web组件触发OnPageEnd事件，表示页面间跳转完成。对比优化前后时延可以得出，使用预加载下一页方法可以减少平均40~50ms左右的跳转时间。&#x000A;&#x000A;![跳转完成时延](./figures/web-route-time-chart.png)&#x000A;</div>&#x000A;<div class='loader-wrapper'>&#x000A;<div class='ui inline mini active loader'></div>&#x000A;</div></blob-markdown-renderer>&#x000A;</div>
<div class='file_line'></div>

</div>
</div>
<div class='tree_progress'></div>
<div class='ui small modal' id='modal-linejump'>
<div class='ui custom form content'>
<div class='field'>
<div class='ui right action input'>
<input placeholder='跳转至某一行...' type='number'>
<div class='ui orange button'>
跳转
</div>
</div>
</div>
</div>
</div>

<div class='complaint'>
<div class='ui modal small form' id='landing-comments-complaint-modal'>
<i class='iconfont icon-close close'></i>
<div class='header'>
举报
</div>
<div class='content'>
<div class='appeal-success-tip hide'>
<i class='iconfont icon-ic_msg_success'></i>
<div class='appeal-success-text'>
举报成功
</div>
<span>
我们将于2个工作日内通过站内信反馈结果给你！
</span>
</div>
<div class='appeal-tip'>
请认真填写举报原因，尽可能描述详细。
</div>
<div class='ui form appeal-form'>
<div class='inline field'>
<label class='left-part appeal-type-wrap'>
举报类型
</label>
<div class='ui dropdown selection' id='appeal-comments-types'>
<div class='text default'>
请选择举报类型
</div>
<i class='dropdown icon'></i>
<div class='menu'></div>
</div>
</div>
<div class='inline field'>
<label class='left-part'>
举报原因
</label>
<textarea class='appeal-reason' id='appeal-comment-reason' name='msg' placeholder='请说明举报原因' rows='3'></textarea>
</div>
<div class='ui message callback-msg hide'></div>
<div class='ui small error text message exceeded-size-tip'></div>
</div>
</div>
<div class='actions'>
<div class='ui button blank cancel'>
取消
</div>
<div class='ui orange icon button disabled ok' id='complaint-comment-confirm'>
发送
</div>
</div>
</div>
<script>
  var $complaintCommentsModal = $('#landing-comments-complaint-modal'),
      $complainCommentType = $complaintCommentsModal.find('#appeal-comments-types'),
      $complaintModalTip = $complaintCommentsModal.find('.callback-msg'),
      $complaintCommentsContent = $complaintCommentsModal.find('.appeal-reason'),
      $complaintCommentBtn = $complaintCommentsModal.find('#complaint-comment-confirm'),
      complaintSending = false,
      initedCommentsType = false;

function initCommentsTypeList() {
if (!initedCommentsType) {
$.ajax({
url: "/appeals/fetch_types",
method: 'get',
data: {'type': 'comment'},
success: function (data) {
var result = '';
for (var i = 0; i < data.length; i++) {
result = result + "<div class='item' data-value='" + data[i].id + "'>" + data[i].name + "</div>";
}
$complainCommentType.find('.menu').html(result);
}
});
$complainCommentType.dropdown({showOnFocus: false});
initedCommentsType = true;
}
}
$complainCommentType.on('click', function() {
$complaintCommentsModal.modal({
autofocus: false,
onApprove: function() {
return false;
},
onHidden: function() {
restoreCommonentDefault();
}
}).modal('show');
});

$complaintCommentsContent.on('change keyup', function(e) {
var content = $(this).val();
if ($.trim(content).length > 0 && $complainCommentType.dropdown('get value').length > 0 ) {
$complaintCommentBtn.removeClass('disabled');
return;
}
$complaintCommentBtn.addClass('disabled');
});


$complainCommentType.dropdown({
showOnFocus: false,
onChange: function(value, text, $selectedItem) {
if (value.length > 0 && $.trim($complaintCommentsContent.val()).length > 0) {
$complaintCommentBtn.removeClass('disabled');
return
}
$complaintCommentBtn.addClass('disabled');
}
});

function restoreCommonentDefault() {
$complainCommentType.dropdown('restore defaults');
$complaintCommentsContent.val('');
$('.exceeded-size-tip').text('').hide();
$complaintModalTip.text('').hide();
setTimeout(function() {
setCommentSendTip(false);
}, 1500);
}

$complaintCommentBtn.on('click',function(e){
var reason = $complaintCommentsContent.val();
var appealableId = $('#landing-comments-complaint-modal').attr('data-id');
if (complaintSending) {
return;
}
var appealType = $complainCommentType.dropdown('get value');
var formData = new FormData();
formData.append('appeal_type_id', appealType);
formData.append('reason', reason);
formData.append('appeal_type','Note');
formData.append('target_id',appealableId);
$.ajax({
type: 'POST',
url: "/appeals",
cache: false,
contentType: false,
processData: false,
data: formData,
beforeSend: function() {
setCommentSendStatus(true);
},
success: function(res) {
if (res.status == 200) {
setCommentSendTip(true);
setTimeout(function() {
$complaintCommentsModal.modal('hide');
restoreCommonentDefault();
}, 3000);
}
setCommentSendStatus(false);
},
error: function(err) {
showCommonTips(err.responseJSON.message, 'error');
setCommentSendStatus(false);
}
})
});

function showCommonTips(text, type) {
$complaintModalTip.text(text).show();
if (type == 'error') {
$complaintModalTip.removeClass('success').addClass('error');
} else {
$complaintModalTip.removeClass('error').addClass('success');
}
}

function setCommentSendStatus(value) {
complaintSending = value;
if (complaintSending) {
$complaintCommentBtn.addClass('loading');
$complaintCommentsContent.attr('readonly', true);
$complainCommentType.attr('readonly', true);
} else {
$complaintCommentBtn.removeClass('loading');
$complaintCommentsContent.attr('readonly', false);
$complainCommentType.attr('readonly', false);
}
}

function setCommentSendTip(value) {
if (value) {
$('.appeal-success-tip').removeClass('hide');
$('.appeal-tip').addClass('hide');
$('.appeal-form').addClass('hide');
$('#landing-comments-complaint-modal .actions').addClass('hide');
} else {
$('.appeal-success-tip').addClass('hide');
$('.appeal-tip').removeClass('hide');
$('.appeal-form').removeClass('hide');
$('#landing-comments-complaint-modal .actions').removeClass('hide');
}
}
</script>

<div class='ui small modal' id='misjudgment_appeal_modal'>
<i class='close icon'></i>
<div class='header dividing ui'>
误判申诉
</div>
<div class='content'>
<p>此处可能存在不合适展示的内容，页面不予展示。您可通过相关编辑功能自查并修改。</p>
<p>如您确认内容无涉及 不当用语 / 纯广告导流 / 暴力 / 低俗色情 / 侵权 / 盗版 / 虚假 / 无价值内容或违法国家有关法律法规的内容，可点击提交进行申诉，我们将尽快为您处理。</p>
<div class='buttons'>
<div class='ui button blank cancel'>取消</div>
<div class='ui button orange submit'>提交</div>
</div>
</div>
</div>
<style>
  #misjudgment_appeal_modal .buttons {
    float: right;
    margin-top: 30px;
    margin-bottom: 20px; }
    #misjudgment_appeal_modal .buttons .cancel {
      margin-right: 20px; }
</style>
<script>
  var $misjudgmentAppealModal = $('#misjudgment_appeal_modal');
  $('.cancel').on('click',function(){
    $misjudgmentAppealModal.modal('hide');
  });
  var $jsSubmitAppeal = $misjudgmentAppealModal.find('.submit')
  $jsSubmitAppeal.on('click', function(e) {
    e.preventDefault();
    $(this).addClass('loading').addClass('disabled');
    var type = $(this).attr('data-type');
    var id = $(this).attr('data-id');
    var projectId = $(this).attr('data-project-id');
    var appealType = $(this).attr('data-appeal-type');
    $.ajax({
      type: "PUT",
      url: "/misjudgment_appeal",
      data: {
        type: type,
        id: id,
        project_id: projectId,
        appeal_type: appealType
      },
      success: function(data) {
        Flash.info('提交成功');
        $jsSubmitAppeal.removeClass('loading');
        $misjudgmentAppealModal.modal('hide');
        location.reload()
      },
      error: function(e) {
        Flash.error('提交失败:'+e.responseText);
        $jsSubmitAppeal.removeClass('loading').removeClass('disabled');
        location.reload()
      }
    });
  })
</script>

</div>
<script>
  "use strict";
  $('.js-check-star').checkbox('set unchecked')
</script>

</div>
</div>
</div>
<div class='four wide column' style='display: none;'>
<div class='project__right-side'>
<div class='side-item intro'>
<div class='header'>
<h4>简介</h4>
</div>
<div class='content'>
<span class='git-project-desc-text'>看置顶Issue，加入HarmonyOS NEXT应用开发案例交流微信群！</span>
<a class='hide spread' href='javascript:void(0);'>
展开
<i class='caret down icon'></i>
</a>
<a class='retract hide' href='javascript:void(0);'>
收起
<i class='caret up icon'></i>
</a>
<div class='intro-list'>
<div class='d-flex d-flex-between dropdown item js-project-label_show label-list-line-feed project-label-list ui' data-labels='[]' data-url='/harmonyos-cases/cases/update_description'>
<div class='mixed-label'>
<a title="HarmonyOSNEXT" class="project-label-item-box" target="_blank" href="/explore/topic/HarmonyOSNEXT"><div class='project-label-item'>HarmonyOSNEXT</div>
</a><a title="开发案例" class="project-label-item-box" target="_blank" href="/explore/topic/%E5%BC%80%E5%8F%91%E6%A1%88%E4%BE%8B"><div class='project-label-item'>开发案例</div>
</a></div>

<div class='default'>暂无标签</div>
</div>
<div class='hide item'>
<i class='iconfont icon-link'></i>
<span class='git-project-homepage'>
<a rel="nofollow" id="homepage" target="_blank" href=""></a>
</span>
</div>
<div class='item'>
<i class='iconfont icon-tag-program'></i>
<span class='summary-languages'>
JavaScript
<span class='text-muted'>
等 6 种语言
<i class='icon dropdown'></i>
</span>
</span>
<div class='ui popup summary-languages-popup'>
<div class='row'>
<div class='lang'>
<a href="/explore/all?lang=TypeScript">TypeScript</a>
</div>
<div class='lang-bar'>
<div class='bar' style='width: 51.7%;'></div>
</div>
<a class="percentage" href="/explore/all?lang=TypeScript">51.7%</a>
</div>
<div class='row'>
<div class='lang'>
<a href="/explore/all?lang=C%2B%2B">C++</a>
</div>
<div class='lang-bar'>
<div class='bar' style='width: 40.5%;'></div>
</div>
<a class="percentage" href="/explore/all?lang=C%2B%2B">40.5%</a>
</div>
<div class='row'>
<div class='lang'>
<a href="/explore/all?lang=CMake">CMake</a>
</div>
<div class='lang-bar'>
<div class='bar' style='width: 2.6%;'></div>
</div>
<a class="percentage" href="/explore/all?lang=CMake">2.6%</a>
</div>
<div class='row'>
<div class='lang'>
<a href="/explore/all?lang=HTML">HTML</a>
</div>
<div class='lang-bar'>
<div class='bar' style='width: 2.5%;'></div>
</div>
<a class="percentage" href="/explore/all?lang=HTML">2.5%</a>
</div>
<div class='row'>
<div class='lang'>
<a href="/explore/all?lang=C">C</a>
</div>
<div class='lang-bar'>
<div class='bar' style='width: 2.3%;'></div>
</div>
<a class="percentage" href="/explore/all?lang=C">2.3%</a>
</div>
<div class='row'>
<div class='lang'>
<a href="/explore/all?lang=Other">Other</a>
</div>
<div class='lang-bar'>
<div class='bar' style='width: 0.4%;'></div>
</div>
<a class="percentage" href="/explore/all?lang=Other">0.4%</a>
</div>
</div>
</div>

<div class='item box-licence'>
<i class='iconfont icon-licence'></i>
<span id='license-popup'>
MulanPSL-2.0
</span>
<div class='ui popup dark'>使用 MulanPSL-2.0 开源许可协议</div>
</div>
<!-- - page = @project.page -->
<!-- - if page&.status? -->
<!-- .item -->
<!-- %i.iconfont.icon-giteepage -->
<!-- Pages： -->
<!-- = link_to page.domain_url, page.domain_url, target: '_blank' -->
</div>
</div>
<div class='content intro-form'>
<div class='ui small input'>
<textarea name='project[description]' placeholder='描述' rows='5'></textarea>
</div>
<div class='ui small input'>
<input data-regex-value='(^$)|(^(http|https):\/\/(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).*)|(^(http|https):\/\/[a-zA-Z0-9]+([_\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,10}(:[0-9]{1,10})?(\?.*)?(\/.*)?$)' name='project[homepage]' placeholder='主页(eg: https://gitee.com)' type='text'>
</div>
<button class='ui orange button mt-1 btn-save'>
保存更改
</button>
<div class='ui blank button btn-cancel-edit'>
取消
</div>
</div>
</div>
<div class='side-item release'>
<div class='header'>
<h4>
发行版
<span class='text-muted'>
(4)
</span>
</h4>
<a class="ui link button pull-right" href="/harmonyos-cases/cases/releases">全部</a>
</div>
<div class='content ml-3'>
<i class='iconfont icon-release'></i>
<div class='desc'>
<a href="/harmonyos-cases/cases/releases/tag/0.0.4">v0.0.4</a>
</div>
<span class='timeago' datetime='2024-06-20 14:15' title='2024-06-20 14:15:42 +0800'></span>
</div>
</div>
<div class='side-item compass'>
<div class='header mb-1 d-align-center'>
<h4 class='limit-length compass-label mr-1'></h4>
<a class="ui link button compass-qa" href="https://compass.gitee.com/zh/docs/dimensions-define"><i class='iconfont icon-help-circle'></i>
</a></div>
<div class='content'>
<div class='compass-echart-container'>
<div data-url='/harmonyos-cases/cases/compass/chart_data' id='compass-metrics'>
<div class='wrap'></div>
<div class='ui popup radar-popup'>
<h4 class='title'>开源评估指数源自 OSS-Compass 评估体系，评估体系围绕以下三个维度对项目展开评估：</h4>
<div class='project-radar-list'>
<div class='descript-contianer'>
<div class='descript-title'>
<p class='mb-1'>1. 开源生态</p>
<ul class='mb-1 mt-1'>
<li>生产力：来评估开源项目输出软件制品和开源价值的能力。</li>
<li>创新力：用于评估开源软件及其生态系统的多样化程度。</li>
<li>稳健性：用于评估开源项目面对多变的发展环境，抵御内外干扰并自我恢复的能力。</li>
</ul>
<p>2. 协作、人、软件</p>
<ul>
<li>协作：代表了开源开发行为中协作的程度和深度。</li>
<li>人：观察开源项目核心人员在开源项目中的影响力，并通过第三方视角考察用户和开发者对开源项目的评价。</li>
<li>软件：从开源项目对外输出的制品评估其价值最终落脚点。也是开源评估最“古老”的主流方向之一“开源软件” 的具体表现。</li>
</ul>
<p>3. 评估模型</p>
<ul>
基于“开源生态”与“协作、人、软件”的维度，找到与该目标直接或间接相关的可量化指标，对开源项目健康与生态进行量化评估，最终形成开源评估指数。
</ul>
</div>
</div>
</div>
<div class='finaltime'></div>
</div>
<div class='legend-box ml-1'>
<div class='dimension d-flex'></div>
<div class='compass-type d-flex'></div>
</div>
</div>
</div>
<script src="/static/javascripts/echarts.min.js"></script>
<script src="/static/javascripts/echarts-gl.min.js"></script>
<script src="https://cn-assets.gitee.com/assets/skill_radar/rep_compass_chart-a170f1ecfff8cd448229c0a3b82b074a.js"></script>

</div>
</div>
<div class='side-item contrib' data-url='/harmonyos-cases/cases/contributors_count?ref=master' id='contributor'>
<div class='header'>
<h4>
贡献者
<span class='text-muted' id='contributor-count'></span>
</h4>
<a class="ui link button pull-right" href="/harmonyos-cases/cases/contributors?ref=master">全部</a>
</div>
<div class='content' id='contributor-list'></div>
<div class='ui active centered inline loader' id='contributor-loader'></div>
</div>
<div class='side-item events' data-url='/harmonyos-cases/cases/events.json' id='proj-events'>
<div class='header'>
<h4>近期动态</h4>
</div>
<div class='content'>
<div class='ui comments' id='event-list'></div>
<a class="loadmore hide" href="javascript:void(0);">加载更多
<i class='icon dropdown'></i>
</a><center>
<div class='text-muted nomore hide'>不能加载更多了</div>
<div class='ui inline loader active'></div>
</center>
</div>
</div>
</div>
<div class='ui modal tiny' id='edit-project-description'>
<i class='iconfont icon-close close'></i>
<div class='header'>编辑仓库简介</div>
<div class='content'>
<div class='item mb-2'>
<div class='title label'>简介内容</div>
<div class='ui small input'>
<textarea maxlength='200' name='project[description]' placeholder='描述' rows='5'>看置顶Issue，加入HarmonyOS NEXT应用开发案例交流微信群！</textarea>
</div>
</div>
<div class='item mb-2'>
<div class='title label'>主页</div>
<div class='ui small input'>
<input data-regex-value='(^$)|(^(http|https):\/\/(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).*)|(^(http|https):\/\/[a-zA-Z0-9]+([_\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,10}(:[0-9]{1,10})?(\?.*)?(\/.*)?$)' name='project[homepage]' placeholder='主页(eg: https://gitee.com)' type='text' value=''>
</div>
</div>
</div>
<div class='actions'>
<button class='ui button blank cancel'>取消</button>
<button class='ui button orange btn-save'>保存更改</button>
</div>
</div>

<style>
  #license-popup {
    color: #005980;
    cursor: pointer; }
</style>
<script>
  window.gon.projectRightSide = {
    homepage: "",
    description: "看置顶Issue，加入HarmonyOS NEXT应用开发案例交流微信群！",
    url: '/harmonyos-cases/cases/update_description',
    i18n: {
      invalidHomepage: '不是有效的 http 地址',
      descriptionLimitExceeded: '简介长度不得超过%{limit}个字符',
      noDescription: '暂无描述',
      noPermission: '无权限操作！',
      requestError: '修改发生错误，请稍后重试！'
    }
  }
  window.gon.cloneArrSelectedLabel = [] || []
  $(function () {
    var $editModal = $('#edit-project-description')
    $editModal.modal({
      onShow: function () {
        window.globalUtils.getFocus($editModal.find('textarea'))
      }
    })
    $('.project__right-side').on('click', '.header .btn-edit', function () {
      $editModal.modal('show')
    })
    $('#license-popup').popup({ position: 'bottom center', lastResort: 'bottom center' })
  
    $('.js-project-label_show').projectLabel({
      i18n: {
        empty: "标签名不能为空",
        verify: "标签名只允许包含中文、字母、数字或者中划线(-)，不能以中划线开头，且长度少于35个字符",
        max: "最多选择 5 个标签"
      }
    })
  })
</script>

</div>
<div class='project-right-side-contaner' id='code-parsing'>
<div class='d-flex-between mb-2'>
<div class='title fs-16 d-align-center'>
<img class='mr-1' height='32' src='/static/images/mjc_icon@2x.png' width='32'>
<span class='ai-file-name'>马建仓 AI 助手</span>
</div>
<div>
<i class='iconfont icon-close close gitee-icon-close'></i>
</div>
</div>
<div class='code-parsing-content'>
<div class='sub_title'></div>
<div class='markdown-body'></div>
<div class='bottom-content'>
<div class='js-code-parsing-img'></div>
<div class='ai_code_btns_simple'>
<div class='ai_code_btns_simple_container'>
<div class='mr-1 test-more'>尝试更多</div>
<div class='btn_box' data-text='代码解读' data-value='parsing'>
<div class='btn_box_title'>代码解读</div>
</div>
<div class='btn_box' data-text='代码找茬' data-value='analysis'>
<div class='btn_box_title'>代码找茬</div>
</div>
<div class='btn_box' data-text='代码优化' data-value='optimize'>
<div class='btn_box_title'>代码优化</div>
</div>
</div>
</div>
</div>
</div>
<div class='skeleton'>
<div class='line line1'></div>
<div class='line line2'></div>
<div class='line line3'></div>
<div class='line line4'></div>
<div class='line line1'></div>
<div class='line line2'></div>
<div class='line line3'></div>
<div class='line line4'></div>
<div class='line line1'></div>
<div class='line line2'></div>
<div class='line line3'></div>
<div class='line line4'></div>
</div>
<div class='resize-handle'>
<div class='resize-handle-line'></div>
</div>
<script src="/static/javascripts/markdown-it.min.js"></script>
<script src="https://cn-assets.gitee.com/assets/ai_code_parsing/app-642ecd30110bdb891918afedc215072c.js"></script>
<script>
  $(function() {
    var maxWidthPercentage = 0.5;
    $("#code-parsing").resizable({
      handles: 'e, w', // 通过左边调整大小
      minWidth: 350, // 设置 代码解析框 的最小宽度
      resize: function(event, ui) {
        // 当调整大小时，确保 文件详情 的宽度不小于最小宽度
        var parentWidth = $(this).parent().width();
        var newWidthDiv2 = ui.size.width;
        var newWidthDiv1 = parentWidth - newWidthDiv2;
        // 计算最大宽度
        var maxWidthDiv2 = parentWidth * maxWidthPercentage;
        // 确保 代码解析框 不超过最大宽度
        newWidthDiv2 = Math.min(newWidthDiv2, maxWidthDiv2);
        // 确保 文件详情 至少有最小宽度
        newWidthDiv1 = Math.max(parentWidth - newWidthDiv2, 750);

        var percentageCode = (newWidthDiv2 / parentWidth) * 100;
        var percentageProject = (newWidthDiv1 / parentWidth) * 100;
  
        $('#code-parsing').css('width',percentageCode+"%")
        $('#git-project-container').attr('style', 'width: ' + percentageProject + '% !important;');
      }
    });
})
</script>

</div>
</div>
</div>
<script>
  (function() {
    $(function() {
      Tree.init();
      return TreeCommentActions.init();
    });

}).call(this);
</script>
<script>
  function scrollToReadmeBox() {
    var readmeBox = document.getElementById('git-readme');
    if (readmeBox) {
      const topPos = readmeBox.offsetTop;
      window.scrollTo({ top: topPos, behavior: "smooth" });
    }
  }
  $(".box-licence").click(function(event) {
    $('.lisence-content').show()
    $('.lisence-edit').show()
    $('.readme-content').hide()
    $('.readme-edit').hide()
    $('.file_title_license').addClass('active-title')
    $('.file_title_readme').removeClass('active-title')
    scrollToReadmeBox()
  });
</script>
<script src="/static/javascripts/file-icons.js"></script>
<link rel="stylesheet" media="all" href="https://cn-assets.gitee.com/assets/markdown_preview-759e5a584b0bd13e42c55a89a695ffcd.css" />
<script src="https://cn-assets.gitee.com/assets/markdown_preview-8c0d07e8cadfa41d1efa5b5a3877da70.js"></script>
<script src="https://cn-assets.gitee.com/webpacks/vendors_lib-7ff466a6da368d391eda.js" defer="defer"></script>
<script src="https://cn-assets.gitee.com/webpacks/markdown_render-04231c0a01e1b0107fb6.bundle.js" defer="defer"></script>
<script src="https://cn-assets.gitee.com/webpacks/gitee-linker.b5c93d77567006097fca.js"></script>

</div>
<script>
  (function() {
    var donateModal;

    Gitee.modalHelper = new GiteeModalHelper({
      alertText: '提示',
      okText: '确定'
    });
  
    donateModal = new ProjectDonateModal({
      el: '#project-donate-modal',
      alipayUrl: '/harmonyos-cases/cases/alipay',
      wepayUrl: '/harmonyos-cases/cases/wepay',
      nameIsBlank: '名称不能为空',
      nameTooLong: '名称过长（最多为 36 个字符）',
      modalHelper: Gitee.modalHelper
    });
  
    if (null === 'true') {
      donateModal.show();
    }
  
    $('#project-donate').on('click', function() {
      return donateModal.show();
    });

}).call(this);
</script>
<script>
  Tree.initHighlightTheme('white')
</script>


</div>
<div class='gitee-project-extension'>
<div class='extension lang'>JavaScript</div>
<div class='extension public'>1</div>
<div class='extension https'>https://gitee.com/harmonyos-cases/cases.git</div>
<div class='extension ssh'>git@gitee.com:harmonyos-cases/cases.git</div>
<div class='extension namespace'>harmonyos-cases</div>
<div class='extension repo'>cases</div>
<div class='extension name'>Cases</div>
<div class='extension branch'>master</div>
</div>
<style>
  .gfm-team_member[data-username="test073001_admin_admin_admin_admin"] {
    padding: 0 4px;
    background: rgba(44,126,248,0.10);
    border-radius: 2px;
  }
</style>

<script>
  $(function() {
    GitLab.GfmAutoComplete.dataSource = "/harmonyos-cases/cases/autocomplete_sources"
    GitLab.GfmAutoComplete.Emoji.assetBase = '/assets/emoji'
    GitLab.GfmAutoComplete.setup();
  });
</script>

<footer id='git-footer-main'>
<div class='ui container'>
<div class='logo-row'>
<a href="https://gitee.com"><img alt='Gitee - 基于 Git 的代码托管和研发协作平台' class='logo-img' src='/static/images/logo-black.svg?t=158106666'>
</a></div>
<div class='name-important'>
深圳市奥思网络科技有限公司版权所有
</div>
<div class='ui two column grid d-flex-center'>
<div class='eight wide column git-footer-left'>
<div class='ui four column grid' id='footer-left'>
<div class='column'>
<div class='ui link list'>
<div class='item'>
<a class="item" href="/all-about-git">Git 大全</a>
</div>
<div class='item'>
<a class="item" rel="nofollow" href="https://help.gitee.com/learn-Git-Branching/">Git 命令学习</a>
</div>
<div class='item'>
<a class="item" rel="nofollow" href="https://copycat.gitee.com/">CopyCat 代码克隆检测</a>
</div>
<div class='item'>
<a class="item" href="/appclient">APP与插件下载</a>
</div>
</div>
</div>
<div class='column'>
<div class='ui link list'>
<div class='item'>
<a class="item" href="/gitee_reward">Gitee Reward</a>
</div>
<div class='item'>
<a class="item" href="/gitee-stars">Gitee 封面人物</a>
</div>
<div class='item'>
<a class="item" href="/gvp">GVP 项目</a>
</div>
<div class='item'>
<a class="item" rel="nofollow" href="https://blog.gitee.com/">Gitee 博客</a>
</div>
<div class='item'>
<a class="item" href="/enterprises#nonprofit-plan">Gitee 公益计划</a>
</div>
<div class='item'>
<a class="item" href="https://gitee.com/features/gitee-go">Gitee 持续集成</a>
</div>
</div>
</div>
<div class='column'>
<div class='ui link list'>
<div class='item'>
<a class="item" href="/api/v5/swagger">OpenAPI</a>
</div>
<div class='item'>
<a class="item" href="https://help.gitee.com">帮助文档</a>
</div>
<div class='item'>
<a class="item" href="/self_services">在线自助服务</a>
</div>
<div class='item'>
<a class="item" href="/help/articles/4378">更新日志</a>
</div>
</div>
</div>
<div class='column'>
<div class='ui link list'>
<div class='item'>
<a class="item" href="/about_us">关于我们</a>
</div>
<div class='item'>
<a class="item" rel="nofollow" href="https://www.oschina.net/news/131099/oschina-hiring">加入我们</a>
</div>
<div class='item'>
<a class="item" href="/terms">使用条款</a>
</div>
<div class='item'>
<a class="item" href="/oschina/git-osc/issues">意见建议</a>
</div>
<div class='item'>
<a class="item" href="/links.html">合作伙伴</a>
</div>
</div>
</div>
</div>
</div>
<div class='eight wide column right aligned followus git-footer-right'>
<div class='qrcode mr-1'>
<div class='qrcode-box'>
<img alt="技术交流QQ群" src="https://cn-assets.gitee.com/assets/contact_qr-5e2c2a8da453396590e56a545bce4974.jpg" />
</div>
<p class='mt-1 mini_app-text'>技术交流QQ群</p>
</div>
<div class='qrcode'>
<div class='qrcode-box'>
<img alt="微信服务号" class="weixin-qr" src="https://cn-assets.gitee.com/assets/qrcode-weixin@2x-b74cc97a2ea80123ea53a737f709836d.png" />
</div>
<p class='mt-1 weixin-text'>微信服务号</p>
</div>
<div class='phone-and-qq column'>
<div class='ui list official-support-container'>
<div class='item'></div>
<div class='item mail-and-zhihu'>
<a rel="nofollow" href="mailto: client@oschina.cn"><i class='iconfont icon-msg-mail'></i>
<span id='git-footer-email'>client#oschina.cn</span>
</a></div>
<div class='item tel'>
<a>
<i class='iconfont icon-tel'></i>
<span>企业版在线使用：400-606-0201</span>
</a>
</div>
<div class='item tel'>
<a class='d-flex'>
<i class='iconfont icon-tel mt-05 mr-05'></i>
<span>专业版私有部署：</span>
<div>
<div>13670252304</div>
<div>13352947997</div>
</div>
</a>
</div>
</div>
</div>
</div>
</div>
</div>
<div class='bottombar'>
<div class='ui container'>
<div class='ui d-flex d-flex-between'>
<div class='seven wide column partner d-flex'>
<div class='open-atom d-flex-center'>
<img class="logo-openatom mr-1" alt="开放原子开源基金会" src="https://cn-assets.gitee.com/assets/logo-openatom-d083391cc8a54e283529f3fc11cc38ca.svg" />
<a target="_blank" rel="nofollow" href="https://www.openatom.org/">开放原子开源基金会</a>
<div class='sub-title ml-1'>合作代码托管平台</div>
</div>
<div class='report-12377 d-flex-center ml-3'>
<img class="report-12377__logo mr-1" alt="违法和不良信息举报中心" src="https://cn-assets.gitee.com/assets/12377@2x-1aa42ed2d2256f82a61ecf57be1ec244.png" />
<a target="_blank" rel="nofollow" href="https://12377.cn">违法和不良信息举报中心</a>
</div>
<div class='copyright ml-3'>
<a rel="nofollow" href="http://beian.miit.gov.cn/">粤ICP备12009483号</a>
</div>
</div>
<div class='nine wide column right aligned'>
<i class='icon world'></i>
<a href="/language/zh-CN">简 体</a>
/
<a href="/language/zh-TW">繁 體</a>
/
<a href="/language/en">English</a>
</div>
</div>
</div>
</div>
</footer>

<script>
  var officialEmail = $('#git-footer-email').text()
  $('#git-footer-main .icon-popup').popup({ position: 'bottom center' })
  $('#git-footer-email').text(officialEmail.replace('#', '@'))
  window.gon.popover_card_locale = {
    follow:"关注",
    unfollow:"已关注",
    gvp_title: "GVP - Gitee 最有价值开源项目",
    project: "项目",
    org: "开源组织",
    member: "",
    author: "作者",
    user_blocked: "该用户已被屏蔽或已注销",
    net_error: "网络错误",
    unknown_exception: "未知异常"
  }
  window.gon.select_message = {
    placeholder: "请输入个人空间地址或完整的邮箱地址"
  }
</script>
<script src="https://cn-assets.gitee.com/webpacks/popover_card-d759637c3dbef944c008.bundle.js"></script>
<link rel="stylesheet" media="all" href="https://cn-assets.gitee.com/webpacks/css/gitee_nps-ae0dbee40f6ddc72015a.css" />
<script src="https://cn-assets.gitee.com/webpacks/gitee_nps-fb459ed1da83f9bc24dc.bundle.js"></script>
<script src="https://cn-assets.gitee.com/webpacks/gitee_icons-a30057b5990085b2c57b.bundle.js"></script>



<div class='side-toolbar'>
<div class='button toolbar-help'>
<i class='iconfont icon-help'></i>
</div>
<div class='ui popup left center dark'>点此查找更多帮助</div>
<div class='toolbar-help-dialog'>
<div class='toolbar-dialog-header'>
<h3 class='toolbar-dialog-title'>搜索帮助</h3>
<form class="toolbar-help-search-form" action="/help/load_keywords_data" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="&#x2713;" />
<div class='ui icon input fluid toolbar-help-search'>
<input name='keywords' placeholder='请输入产品名称或问题' type='text'>
<i class='icon search'></i>
</div>
</form>

<i class='iconfont icon-close toolbar-dialog-close-icon'></i>
</div>
<div class='toolbar-dialog-content'>
<div class='toolbar-help-hot-search'>
<div class='toolbar-roll'>
<a class="init active" title="Git 命令在线学习" href="https://oschina.gitee.io/learn-git-branching/?utm_source==gitee-help-widget"><i class='Blue icon icon-command iconfont'></i>
<span>Git 命令在线学习</span>
</a><a class="init " title="如何在 Gitee 导入 GitHub 仓库" href="https://gitee.com/help/articles/4261?utm_source==gitee-help-widget"><i class='icon icon-clipboard iconfont orange'></i>
<span>如何在 Gitee 导入 GitHub 仓库</span>
</a></div>
<div class='toolbar-list'>
<div class='toolbar-list-item'>
<a href="/help/articles/4114">Git 仓库基础操作</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4166">企业版和社区版功能对比</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4191">SSH 公钥设置</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4194">如何处理代码冲突</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4232">仓库体积过大，如何减小？</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4279">如何找回被删除的仓库数据</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4283">Gitee 产品配额说明</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4284">GitHub仓库快速导入Gitee及同步更新</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4328">什么是 Release（发行版）</a>
</div>
<div class='toolbar-list-item'>
<a href="/help/articles/4354">将 PHP 项目自动发布到 packagist.org</a>
</div>
</div>
</div>
<div class='toolbar-help-search-reseult'></div>
</div>
</div>
<script>
  var opt = { position: 'left center'};
  var $helpSideToolbar = $('.button.toolbar-help');
  var $toolbarRoll = $('.toolbar-roll');

$(function() {
if (true) {
$helpSideToolbar.popup(opt).popup({lastResort:'left center'})
} else {
$helpSideToolbar.popup({lastResort:'left center'}).popup('show', opt);
setTimeout(function() {
$helpSideToolbar.popup('hide', opt);
}, 3000);
}

    if ($toolbarRoll.length) {
      setInterval(function() {
        var $nextActiveLink = $toolbarRoll.find('a.active').next();
        if (!$nextActiveLink.length) {
          $nextActiveLink = $toolbarRoll.find('a:first-child');
        }
        $nextActiveLink.attr('class', 'active').siblings().removeClass('active init');
      }, 5000);
    }
})
</script>

<div class='ui popup dark left center transition hidden js-feedback-popup'>发送反馈</div>
<div class='button' id='feedback-btn'>
<i class='iconfont icon-feedback'></i>
</div>
<div class='popup button' id='project-user-message'>
<i class='iconfont icon-message'></i>
</div>
<div class='ui popup dark'>给仓库拥有者发送私信</div>
<div class='popup button' id='home-comment'>
<i class='iconfont icon-comment'></i>
</div>
<div class='ui popup dark'>评论</div>
<div class='toolbar-appeal popup button'>
<i class='iconfont icon-report'></i>
</div>
<div class='ui popup dark'>
仓库举报
</div>
<script>
  $('.toolbar-appeal').popup({ position: 'left center' });
</script>

<div class='button gotop popup' id='gotop'>
<i class='iconfont icon-top'></i>
</div>
<div class='ui popup dark'>回到顶部</div>
</div>
<div class='ui modal tiny form' id='send-message-modal'>
<i class='iconfont icon-close close'></i>
<div class='header'>发送私信</div>
<div class='content'>
<div class='ui message hide'></div>
<div class='field'>
<textarea class='content-input' maxlength='255' placeholder='文明发言，真诚提问，请输入要发送的内容'></textarea>
</div>
<div class='field captcha-field'>
<div class='ui input right labeled'>
<input placeholder='请输入验证码' type='text'>
<div class='ui basic label captcha-content'>
<img class='captcha_img'>
</div>
</div>
</div>
</div>
<div class='actions'>
<div class='ui button blank cancel'>取消</div>
<div class='ui orange icon button disabled ok'>发送</div>
</div>
</div>
<script>
  var $mountedElem = $('#project-user-message'),
      $messageModal = $('#send-message-modal'),
      $modalTips = $messageModal.find('.message'),
      $contentInput = $messageModal.find('.content-input'),
      $captchaImage = $messageModal.find('.captcha_img'),
      $captchaInput = $messageModal.find('.captcha-field input'),
      $sendMessageBtn = $messageModal.find('.ok.button'),
      messageSending = false

$mountedElem.on('click', function() {
$captchaImage.trigger('click')
$messageModal.modal('show')
})

$messageModal.modal({
onApprove: function() {
sendMessage()
return false
},
onHidden: function() {
$modalTips.hide()
}
})

$captchaImage.on('click', function() {
$captchaInput.val('')
})

$contentInput.on('change keydown', function(e) {
var content = $(this).val()
if ($.trim(content).length == 0) {
$sendMessageBtn.addClass('disabled')
return
}
$sendMessageBtn.removeClass('disabled')
if ((e.ctrlKey || e.metaKey) && e.keyCode == 13) {
$sendMessageBtn.trigger('click')
}
})

function sendMessage() {
if (messageSending) return
$.ajax({
url: '/notifications/messages',
data: {
link: true,
content: $contentInput.val(),
receiver_id: '5416512',
receiver_username: '',
captcha: $captchaInput.val()
},
type: 'POST',
dataType: 'JSON',
beforeSend: function() {
setSendStatus(true)
},
success: function(res) {
if (res.status != 200) {
showSendTips(res.message || '可能由于网络原因，留言发送失败，请稍后再试', 'error')
} else {
$contentInput.val('')
showSendTips('私信发送成功')
setTimeout(function() { $messageModal.modal('hide') }, 500)
}
setSendStatus(false)
},
error: function(err) {
try {
showSendTips(err.responseJSON.message, 'error')
} catch(e) {
showSendTips('可能由于网络原因，留言发送失败，请稍后再试', 'error')
} finally {
setSendStatus(false)
}
}
})
}

function showSendTips(text, type) {
$modalTips.html(text).show()
if (type == 'error') {
$modalTips.removeClass('success').addClass('error')
} else {
$modalTips.removeClass('error').addClass('success')
}
}

function setSendStatus(value) {
messageSending = value
if (messageSending) {
$sendMessageBtn.addClass('loading')
$contentInput.attr('readonly', true)
} else {
$sendMessageBtn.removeClass('loading')
$contentInput.attr('readonly', false)
}
}
</script>

<div class='ui modal small form' id='landing-complaint-modal'>
<i class='iconfont icon-close close'></i>
<div class='header'>
举报
</div>
<div class='content'>
<div class='appeal-success-tip hide'>
<i class='iconfont icon-ic_msg_success'></i>
<div class='appeal-success-text'>
举报成功
</div>
<span>
我们将于2个工作日内通过站内信和邮件方式反馈结果给你！
</span>
</div>
<div class='appeal-tip'>
请认真填写举报原因，如举报内容涉及 版权/产权 方面问题，请尽可能提供完整证据和材料。
</div>
<div class='ui form appeal-form'>
<div class='inline field'>
<label class='left-part appeal-type-wrap'>
举报类型
</label>
<div class='ui dropdown selection' id='appeal-types'>
<div class='text default'>
请选择举报类型
</div>
<i class='dropdown icon'></i>
<div class='menu'></div>
</div>
</div>
<div class='inline field'>
<label class='left-part'>
举报原因
</label>
<textarea class='appeal-reason' name='msg' placeholder='请说明举报原因' rows='3'></textarea>
</div>
<div class='inline field appeal-file-wrap'>
<label class='left-part appeal-file-text'>
举报材料
</label>
<div id='appeal-file-container'>
<div class='ui fluid action input'>
<input disabled id='appeal-file' placeholder='支持 png/jpg/jpeg/doc/docx/zip/pdf，大小不超过 10M' type='text'>
<div class='ui button'>
<input accept='image/png, image/jpeg, application/pdf, application/msword, aplication/zip, application/vnd.openxmlformats-officedocument.wordprocessingml.document' class='file-upload' type='file'>
浏览...
</input>
</div>
</div>
</div>
</div>
<div class='ui message callback-msg hide'></div>
<div class='ui small error text message exceeded-size-tip'></div>
</div>
</div>
<div class='actions'>
<div class='ui button blank cancel'>
取消
</div>
<div class='ui orange icon button disabled ok'>
发送
</div>
</div>
</div>
<script>
  var $elm = $('.toolbar-appeal'),
      $complaintModal = $('#landing-complaint-modal'),
      $complainType = $complaintModal.find('#appeal-types'),
      $complaintModalTip = $complaintModal.find('.callback-msg'),
      $complaintContent = $complaintModal.find('.appeal-reason'),
      $complaintBtn = $complaintModal.find('.ok.button'),
      complaintSending = false,
      fileObject = '';

$('#appeal-types').dropdown({showOnFocus: false});
$elm.on('click', function() {
$.ajax({
url: "/appeals/fetch_types",
method: 'get',
data:{'type': 'project'},
success:function(data){
var result = '';
for(var i=0;i<data.length;i++){
result = result + "<div class='item' data-value='"+data[i].id+"'>"+data[i].name+"</div>"
}
$('#appeal-types .menu').html(result)
}
})
$complaintModal.modal({
autofocus: false,
onApprove: function() {
sendAppeal();
return false;
},
onHidden: function() {
restoreDefault();
}
}).modal('show');
})

$complaintContent.on('change keyup', function(e) {
var content = $(this).val();
if ($.trim(content).length > 0 && $complainType.dropdown('get value').length > 0 ) {
$complaintBtn.removeClass('disabled');
return;
}
$complaintBtn.addClass('disabled');
})

$('#appeal-file-container .file-upload').on('change', function () {
var reader = new FileReader();
fileObject = this.files[0];
if (fileObject) {
var fileObjectName = fileObject.name.split('.');
var fileExt = fileObjectName[fileObjectName.length - 1];
if (fileObjectName.length < 2 || ['zip', 'png', 'jpg', 'jpeg', 'doc', 'docx', 'pdf'].indexOf(fileExt.toLowerCase()) < 0) {
fileObject = '';
$('.file-upload').val('');
$('.exceeded-size-tip').text("请选择上传 png/jpg/jpeg/doc/docx/zip/pdf 类型的文件").show();
return;
}
if (fileObject.size > 10*1024*1024) {
fileObject = '';
$('.file-upload').val('');
$('.exceeded-size-tip').text("上传文件大小不能超过 10M").show();
return;
}
reader.readAsDataURL(fileObject);
reader.onload = function() {
var data = reader.result;
$('.exceeded-size-tip').text('').hide();
$('#appeal-file').val(fileObject.name);
}
}
})

$('#appeal-types').dropdown({
showOnFocus: false,
onChange: function(value, text, $selectedItem) {
if (value.length > 0 && $.trim($complaintContent.val()).length > 0) {
$complaintBtn.removeClass('disabled');
return
}
$complaintBtn.addClass('disabled');
}
})

function restoreDefault() {
$('#appeal-types').dropdown('restore defaults');
$('.appeal-reason').val('');
$('#appeal-file').val('');
$('.exceeded-size-tip').text('').hide();
$('#appeal-file-container .file-upload').val('');
$complaintModalTip.text('').hide();
setTimeout(function() {
setSendTip(false);
}, 1500);
}

function sendAppeal() {
var appealType = $complainType.dropdown('get value');
var reason = $complaintContent.val();
if (complaintSending) {
return;
}
var formData = new FormData();
formData.append('appeal_type_id', appealType);
formData.append('reason', reason);
formData.append('file', fileObject);
formData.append('appeal_type', 'Project')
$.ajax({
type: 'POST',
url: "/appeals?target_id=32931089",
cache: false,
contentType: false,
processData: false,
data: formData,
beforeSend: function() {
setSendStatus(true);
},
success: function(res) {
if (res.status == 200) {
setSendTip(true);
setTimeout(function() {
$complaintModal.modal('hide');
restoreDefault();
}, 3000);
}
setSendStatus(false);
},
error: function(err) {
showTips(err.responseJSON.message, 'error');
setSendStatus(false);
}
})
}

function showTips(text, type) {
$complaintModalTip.text(text).show();
if (type == 'error') {
$complaintModalTip.removeClass('success').addClass('error');
} else {
$complaintModalTip.removeClass('error').addClass('success');
}
}

function setSendStatus(value) {
complaintSending = value;
if (complaintSending) {
$complaintBtn.addClass('loading');
$complaintContent.attr('readonly', true);
$complainType.attr('readonly', true);
} else {
$complaintBtn.removeClass('loading');
$complaintContent.attr('readonly', false);
$complainType.attr('readonly', false);
}
}

function setSendTip(value) {
if (value) {
$('.appeal-success-tip').removeClass('hide');
$('.appeal-tip').addClass('hide');
$('.appeal-form').addClass('hide');
$('#landing-complaint-modal .actions').addClass('hide');
} else {
$('.appeal-success-tip').addClass('hide');
$('.appeal-tip').removeClass('hide');
$('.appeal-form').removeClass('hide');
$('#landing-complaint-modal .actions').removeClass('hide');
}
}
</script>

<style>
  .side-toolbar .bdsharebuttonbox a {
    font-size: 24px;
    color: white !important;
    opacity: 0.9;
    margin: 6px 6px 0px 6px;
    background-image: none;
    text-indent: 0;
    height: auto;
    width: auto;
  }
</style>
<style>
  #udesk_btn a {
    margin: 0px 20px 217px 0px !important;
  }
  #ent-sale-img-wrap {
    margin: 0px 15px 294px 0px !important;
  }
</style>
<script>
  (function() {
    $('#project-user-message').popup({
      position: 'left center'
    });
  
  }).call(this);
</script>
<script>
  Gitee.initSideToolbar({
    hasComment: true,
    commentUrl: '/harmonyos-cases/cases#tree_comm_title'
  })
</script>
<link rel="stylesheet" media="all" href="https://cn-assets.gitee.com/webpacks/css/side_toolbar_feedback-5dcc1be9cca438cc952f.css" />
<script src="https://cn-assets.gitee.com/webpacks/side_toolbar_feedback-1f9bc4a6213ac171e57b.bundle.js"></script>





<script>
  (function() {
    this.__gac = {
      domain: 'www.oschina.net'
    };
  
  }).call(this);
</script>

<script src="https://cn-assets.gitee.com/assets/bdstatic/app-070a9e339ac82bf2bf7ef20375cd4121.js"></script>
<script src="https://hm.baidu.com/hm.js?b8881e4f5af7675e2aab15239c9bc43a" async="async"></script>
<script src="https://cn-assets.gitee.com/webpacks/build_status-a0b08cd330f9f9ab2e6c.bundle.js"></script>
<script src="https://cn-assets.gitee.com/webpacks/scan_status-9d8541af0799261fce2a.bundle.js"></script>
<script src="https://cn-assets.gitee.com/webpacks/mermaid_render-a13de7e2b5d6f4663bb5.bundle.js"></script>
<script src="https://cn-assets.gitee.com/webpacks/check_runs-8fe2f388fec18d6b424e.bundle.js"></script>
</body>
</html>
