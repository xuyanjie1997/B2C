<!DOCTYPE html> 
<html>
	<head>
		<meta charset="UTF-8">
        <meta name="author" content="order by dede58.com"/>
		<title>会员登录</title>
		<link rel="stylesheet" type="text/css" href="./css/login.css">
		<%@ include file="/web/header.jsp"%>
	</head>
	<body>
		<!-- login -->
		<div class="top center">
			<div class="logo center">
				<a href="./index.jsp" target="_blank">
					<img src="/xshop/web/proweb/image/logo_top.png" >
				</a>
				<span style="font-family:STKaiti;font-size:160%;color:green">全国最小的购物网站</span>
			</div>
		</div>
		
		<form  method="post" class="form layui-form layui-form-pane" >
		<div class="login">
			<div class="login_center">
				<div class="login_top">
					<div class="left fl">会员登录</div>
					<div class="right fr">您还不是我们的会员？<a href="./register.jsp" target="_self">立即注册</a></div>
					<div class="clear"></div>
					<div class="xian center"></div>
				</div>
				<div class="login_main center">
					<div class="username">用户名:&nbsp;<input class="shurukuang" type="text" name="usercode" placeholder="请输入你的用户名"/></div>
					<div class="username">密&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;<input class="shurukuang" type="password" name="password" placeholder="请输入你的密码"/></div>
					<div class="username">
						<div class="left fl">验证码:&nbsp;<input class="yanzhengma" type="text" name="authcode" placeholder="请输入验证码"/></div>
						<div class="right fl"><img
							src="/xshop/AuthCodeServlet"
							onclick="this.src='/xshop/AuthCodeServlet?'+Math.random(); "></div>
						<div class="clear"></div>
					</div>
				</div>
				<div>
					<input class="layui-btn layui-btn-fluid layui-btn-warm" type="button" value="立即登录" lay-submit lay-filter="login">
				</div>	
			</div>
		</div>
		</form>
		<footer>
			<div class="copyright">简体 | 繁体 | English | 常见问题</div>
			<div class="copyright">XShop版权所有-鲁ICP备10046444-<img src="./image/ghs.png" alt="">鲁公网安备11010802020134号-鲁ICP证110507号</div>
		</footer>

<script type="text/javascript">

	formSubmit('/user/prologin.do','submit(login)','text',function(data){
		if (data == 0) {
			location.href = con.app + "/web/proweb/index.jsp";
		} else if (data == 1) {
			layer.msg('账号不存在');
		} 
		 if(data == 3){
			layer.msg('验证码错误');
		}else if(data == 4) {
			layer.msg('密码错误');
		}
	});
</script>
</body>
</html>