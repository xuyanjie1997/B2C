<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>用户维护</title>
</head>
<body>

<fieldset class="layui-elem-field" 
          style="margin:20px; padding: 20px;">
	<legend>用户维护-添加信息</legend>

	<div class="layui-field-box">
		<form class="layui-form layui-form-pane" method="post">
				<div class="layui-form-item">
					<label class="layui-form-label">账号</label>
					<div class="layui-input-inline">
						<input type="text" name="usercode" class="layui-input" lay-verify="required" placeholder="请输入账号" required	autocomplete="off">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">密码</label>
					<div class="layui-input-inline">
						<input type="password" name="password" class="layui-input"	lay-verify="required" placeholder="请输入密码" required	autocomplete="off">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">用户名</label>
					<div class="layui-input-inline">
						<input type="text" name="name" class="layui-input" 	lay-verify="required" placeholder="请输入姓名" required	autocomplete="off">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">权限</label>
					<div class="layui-input-inline">
						<select name="isAdmin" lay-verify="required">
							<option value="0">普通用户(0)</option>
							<option value="1">管理员(1)</option>
						</select>
					</div>
				</div>

				<div class="layui-form-item">
				<div class="layui-input-inline">
					<input value="保存"  type="button"  class="layui-btn"   lay-submit lay-filter="reg" /> 
					<input value="重置"  type="reset"  class="layui-btn layui-btn-primary" />
				</div>
			</div>
		</form>
	</div>
</fieldset>
<script type="text/javascript">


	var form = layui.form;
	form.render()

	formSubmit('/user/reg.do', 'submit(reg)', 'text',
			function(data) {
		if (data == 0) {
			layer.msg('添加用户成功');
			closeThis(3000);     
		} else if (data == 1) {
			layer.msg('账号已存在');
		} else {
			layer.msg('添加失败');
		}
	});
</script>

</body>
</html>