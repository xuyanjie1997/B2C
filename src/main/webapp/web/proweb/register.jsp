<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
	<head>
		<meta charset="UTF-8">
		<title>用户注册</title>
		<link rel="stylesheet" type="text/css" href="./css/login.css">
		<%@ include file="/web/header.jsp"%>
	</head>
	<body>
		<form  method="post" class="layui-form layui-form-pane" >
		<div class="regist">
			<div class="regist_center">
				<div class="regist_top">
					<div class="left fl">会员注册</div>
					<div class="right fr"><a href="./index.jsp" target="_self">XShop商城</a></div>
					<div class="clear"></div>
					<div class="xian center"></div>
				</div>
				<div class="regist_main center">
					<div class="username">用&nbsp;&nbsp;户&nbsp;&nbsp;名:&nbsp;&nbsp;<input class="shurukuang" type="text" name="usercode" placeholder="请输入你的用户名"/></div>
					<div class="username">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;&nbsp;<input class="shurukuang" type="password" name="password" placeholder="请输入你的密码"/></div>
					
					<div class="username">确认密码:&nbsp;&nbsp;<input class="shurukuang" type="password" name="repassword" placeholder="请确认你的密码"/></div>
					<div class="username">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:&nbsp;&nbsp;<input class="shurukuang" type="text" name="name" placeholder="请填写您的真实姓名"/></div>
					<div class="username">
						<div class="left fl">验&nbsp;&nbsp;证&nbsp;&nbsp;码:&nbsp;&nbsp;<input class="yanzhengma" type="text" name="authcode" placeholder="请输入验证码"/></div>
						<div class="right fl"><img
							src="/xshop/AuthCodeServlet"
							onclick="this.src='/xshop/AuthCodeServlet?'+Math.random(); "></div>
						<div class="clear"></div>
					</div>
				</div>
				<div>
					<input type="hidden" name="isAdmin" value="0">
					<input class="layui-btn layui-btn-fluid layui-btn-warm"  type="button"  value="立即注册"  lay-submit lay-filter="register" > 
				</div>	
			</div>
		</div>
	</form>
		
<script type="text/javascript">

var form = layui.form;
form.render()

	formSubmit('/user/proreg.do', 'submit(register)', 'text',function(data) {
		if (data == 0) {
			layer.msg('注册成功,您可以使用您的帐号了！');
		} else if (data == 1) {
			layer.msg('账号已存在');
		} else if(data == 3){
			layer.msg('验证码错误');
		}else if(data == 5){
			layer.msg("两次输入的密码要一致！");
		}else{
			layer.msg("未知错误，操作失败")
		}
	});
</script>
		
	</body>
</html>