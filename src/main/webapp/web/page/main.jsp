<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/web/header.jsp"%>
	<title>主页</title>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">XShop后台管理系统</div>
			<ul class="layui-nav layui-layout-left"></ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item">
				    <a href="javascript:;"> 
				        <img src="<%=path%>/img/timg.jpg"
				        class="layui-nav-img"/>用户[${user.name}]
				    </a>
					<dl class="layui-nav-child">
						<dd>
							<a href="javascript:openUser()">基本资料</a>
						</dd>
					</dl>
				</li>
				<li class="layui-nav-item">
				    <a href="javascript:logout()">注销</a>
				</li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->

				<ul class="layui-nav layui-nav-tree" >
				<li class="layui-nav-item layui-nav-itemed ">
					<a href=""  >企业文化</a>
				</li>
					<li class="layui-nav-item ">
					    <a href="javascript:;">用户信息</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="/web/page/user/list.jsp"
								class="site-demo-active">用户信息维护</a>				
							</dd>
						</dl>
					</li>
					<li class="layui-nav-item">
					    <a href="javascript:;">商品信息</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" data-url="/web/page/goods/catelist.jsp"
								class="site-demo-active">商品分类维护</a>	
							</dd>
							<dd>
                                <a href="javascript:;"  data-url="/web/page/goods/descrlist.jsp"
                                class="site-demo-active">商品信息维护</a>
                            </dd>
                            <dd>
                                <a href="javascript:;"  data-url="/web/page/goods/test_table.jsp"
                                class="site-demo-active">商品信息维护</a>
                            </dd>
						</dl>
					</li>
					<li class="layui-nav-item">
					    <a href="javascript:;">订单信息</a>
						<dl class="layui-nav-child">
							<dd>
                                <a href="javascript:;"  data-url="/web/page/order/msglist.jsp"
                                class="site-demo-active">订单信息维护</a>
                            </dd>
						</dl>
					</li>
					<li class="layui-nav-item">
					    <a href="javascript:;">动态表格</a>
						<dl class="layui-nav-child">
                            <dd>
                                <a href="javascript:;"  data-url="/web/page/goods/test_table.jsp"
                                class="site-demo-active">商品动态表格测试</a>
                            </dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>
		<div class="layui-body"><!-- 内容主体区域 -->
			<iframe name="rightframe" width="99%" height="98%" src="/xshop/web/common/img/hexinjiazhiguan.jpg"></iframe>
		</div>
		<div class="layui-footer">© xshop.com - 鲁ICP证110507号 鲁ICP备10046444号 鲁公网安备11010802020134号 鲁网文[2014]0059-0009号</div>
	</div>
<script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>
<script>
	$('.site-demo-active').click(function() {
		window.open(con.app + $(this).data('url'), "rightframe");
	});
	function openURL(url){
		window.open(con.app + url, "rightframe");
	}
// 	$('.site-demo-active:first').click();
	
	function openUser(){
		openLayer('/web/page/user/userupd.jsp?usercode=${user.usercode}'
			,function(){location.reload();})
	}
	function logout(){
		openConfirm(function(index) {
			layer.close(index);
			toJsp("/user/logout.do");
		}, '注销当前用户?');
	}
</script>
</body>
</html>