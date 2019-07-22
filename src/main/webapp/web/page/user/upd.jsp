<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>用户维护</title>
</head>
<body>
 <fieldset class="layui-elem-field" style="margin: 20px;padding:15px;">
        <legend>部门维护--修改信息</legend>
    <form class="layui-form" lay-filter="formA" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-inline">
                <input type="text" name="usercode" readonly lay-verify="required" placeholder="请输入账号" autocomplete="off"
                    class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline">
                <input type="text" name="name" placeholder="请输入用户名" autocomplete="off"
                    class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限</label>
            <div class="layui-input-inline">
                <input type="text" name="isAdmin" placeholder="是否具有管理员权限" autocomplete="off"
                    class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-inline">
                <input type="button" class="layui-btn" lay-submit lay-filter="upd" value="确定" />
                <input type="button" class="layui-btn" onclick="closeThis()" value="取消" />
            </div>
        </div>
    </form>
    </fieldset>
<script type="text/javascript">

init();
function init(){
    var usercode = '<%=request.getParameter("usercode")%>';
	$.ajax({
        url:con.app+'/user/selectModel.do',
        data : {usercode:usercode},
        dataType : 'json',
        type : 'post',
        success : function(data) {
        	form.val("formA", 
        		{name: data.name,usercode:data.usercode,isAdmin:data.isAdmin})
        }
    })
}
formSubmit('/user/update.do', 'submit(upd)', 'text', function(data) {
	if (data == 1) {
        layer.msg('修改成功');
        closeThis(3000);
    } else {
        layer.msg('修改失败');
    }
});
</script>
</body>
</html>