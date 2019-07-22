<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>注册</title>
</head>
<body>

<fieldset class="layui-elem-field" 
          style="margin:20px; padding: 20px;">
	<legend>注册</legend>
	
	<div class="layui-field-box">

		<form class="layui-form layui-form-pane" method="post">
				<div class="layui-form-item">
					<label class="layui-form-label">账号</label>
					<div class="layui-input-inline">
						<input type="text" name="usercode" class="layui-input"
							lay-verify="required" placeholder="请输入账号" required
							autocomplete="off">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">密码</label>
					<div class="layui-input-inline">
						<input type="password" name="password" class="layui-input"
							lay-verify="required" placeholder="请输入密码" required
							autocomplete="off">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">用户名</label>
					<div class="layui-input-inline">
						<input type="text" name="name" class="layui-input"
							lay-verify="required" placeholder="请输入姓名" required
							autocomplete="off">
					</div>
				</div>
				
				<div class="layui-form-item">
				<!-- <label class="layui-form-label"></label> -->
				<div class="layui-input-inline">
					<input value="注册"  type="button" 
					       class="layui-btn" 
					       lay-submit lay-filter="reg" /> 
					<input value="重置"  type="reset" 
					       class="layui-btn layui-btn-primary" />
				</div>
				<input value="返回登录" type="button" 
				       class="layui-btn" onclick="goJspLogin()" />
			</div>
			<input type="hidden" name="isAdmin" value="1" />
		</form>
	</div>
</fieldset>
<script type="text/javascript">

var form = layui.form;
form.render()

	formSubmit('/user/reg.do', 'submit(reg)', 'text',
			function(data) {
		if (data == 0) {
			layer.msg('注册成功');
			$("input[type='reset']").click();
		} else if (data == 1) {
			layer.msg('账号已存在');
		} else {
			layer.msg('注册失败');
		}
	});
</script>

</body>
</html>