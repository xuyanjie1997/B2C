<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>订单详情维护</title>
</head>
<body>
 <fieldset class="layui-elem-field" style="margin: 20px;padding:15px;">
        <legend>订单维护--修改信息</legend>
    
    <form class="layui-form" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">编号</label>
            <div class="layui-input-inline">
                <input type="text" name="code"  autocomplete="off"  readonly class="layui-input">
            </div>
        </div>
       
        <div class="layui-form-item">
            <label class="layui-form-label">用户编号</label>
            <div class="layui-input-inline">
                <input type="text" name="usercode"  autocomplete="off"  readonly class="layui-input">
            </div>
        </div>
        
        <div class="layui-form-item">
			<span class="layui-form-label">地址</span>
			<div class="layui-input-inline">
				 <input type="text" name="address"  autocomplete="off"  class="layui-input">
			</div>
		</div>	

		<div class="layui-form-item">
			<span class="layui-form-label">时间</span>
			<div class="layui-input-inline">
				<input type="text" id="t2" name="time" class="layui-input"   >
			</div>
		</div>	
		
		<div class="layui-form-item">
			<span class="layui-form-label">状态</span>
			<div class="layui-input-inline">
				<select  name="state"  lay-search >
					<option value=''></option>
						<option value='未发货'>未发货(1)</option>
						<option value='已发货'>已发货(2)</option>
						<option value='已收货'>已收货(3)</option>
				 </select>
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
        var code = '<%=request.getParameter("code")%>';
    	$.ajax({
            url:con.app+'/ordermsg/selectModel.do',
            data : {id:code},
            dataType : 'json',
            type : 'post',
            success : function(data) {
            $("input[name='code']").val(data.code);
            $("input[name='usercode']").val(data.usercode);
            $("input[name='address']").val(data.address);
            $("input[name='time']").val(data.time);
            $("select[name='state']").val(data.state)
            form.render();
            }
        })
    }

    var form = layui.form;
    form.render()
    
   var laydate = layui.laydate;
    laydate.render({
    	elem : '#t2',
    	type : 'datetime',
    	format : 'yyyy-MM-dd HH:mm:ss'
    });

    formSubmit('/ordermsg/update.do', 'submit(upd)', 'text', function(data) {
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