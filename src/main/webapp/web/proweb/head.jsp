	<%@page import="com.xyj.shop.user.model.UserModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!-- start header -->   
		<header>  
			<div class="top center">
				<div class="left fl">
					<ul>
						<li><a href="/xshop/web/proweb/index.jsp">XShop商城</a></li>
						<li>|</li>
						<li><a href="javascript:huanying();">官方微博</a></li>
						<li>|</li>
						<li><a href="javascript:huanying();">官方微信</a></li>
						<li>|</li>
						<li><a href="javascript:huanying();">Twitter</a></li>
						<li>|</li>
						<li><a href="javascript:huanying();">更多产品</a></li>
						<li>|</li>
						<li><a href="javascript:huanying();">关于我们</a></li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="right fr">
				<%
						Object obj0 = session.getAttribute("prouser");
						if(obj0 == null){
					%>
						<div class="gouwuche fr"><a href="javascript:nouser();">购物车</a></div>
					<% } else{%>	
						<div class="gouwuche fr"><a href="javascript:gouwuche();">购物车</a></div>
					<% } %>	
					<div class="fr">
						<ul>
					<%
						Object obj = session.getAttribute("prouser");
						if(obj == null){
					%>
							<li><a href="/xshop/web/proweb/login.jsp" >登录</a></li>
							<li>|</li>
							<li><a href="/xshop/web/proweb/register.jsp" target="_blank" >注册</a></li>
							<% }else { UserModel user = (UserModel)obj; %>
							<li><a href="javascript:huanying();" >您好，[<%=user.getName() %>]</a></li>
							<li>|</li>
							<li><a href="javascript:dingdan();">我的订单</a></li>
							<li>|</li>
							<li><a href="javascript:zhuxiao();"  >注销</a></li>
						<% } %>			
							<li>|</li>
							<li><a href="javascript:huanying();">消息通知</a></li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
		</header>
	<!--end header -->
<script type="text/javascript" src="/xshop/web/common/layui/layui.all.js"></script>
<script type="text/javascript" src="/xshop/web/common/js/common.js"></script>
<script type="text/javascript">

	function zhuxiao(){
		openConfirm(function(index) {
			ajax('/user/prologout.do', "", 'text', function(data){
		        if (data == 1) {
		            layer.msg('账号注销成功,请重新登录！');
		            window.location = "/xshop/web/proweb/login.jsp";
		        } else{
		        	layer.msg('注销失败，请联系管理员！');
		        }
		    })
		}, '注销当前用户?');
	}
	
	function nouser(){
		alert('请先登录，再使用购物车功能！');
	}
	
	function gouwuche(){
		 window.location = "/xshop/web/proweb/gouwuche.jsp";
	}
	
	function dingdan(){
		 window.location = "/xshop/web/proweb/dingdanzhongxin.jsp";
	}
	
	function huanying(){
		layer.msg("你好啊，欢迎来到XShop商城！");
	}
	
</script>