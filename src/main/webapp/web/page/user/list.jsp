<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/web/header.jsp"%>
<title>用户信息</title>
</head>
<body>
<div class="layui-collapse">
  <div class="layui-colla-item">
    <h2 class="layui-colla-title">用户信息-查询条件</h2>
    <div class="layui-colla-content layui-show">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px; padding: 5px">
		<legend>用户信息-查询条件</legend>
		<form class="layui-form">
			<div class="layui-form-item">
				<label class="layui-form-label">账号</label>
				<div class="layui-input-inline">
					<input type="text" name="usercode" placeholder="请输入项目编号" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">用户名</label>
				<div class="layui-input-inline">
					<input type="text" name="name" placeholder="请输入项目名称" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label"></label> 
				<span> 
				<input type="button" class="layui-btn" lay-submit lay-filter="search" value="查询" /> 
				<input type="reset" class="layui-btn" value="重置" /> 
				<input type="button" class="layui-btn" value="添加" onclick="openAdd()" />
				</span>
			</div>
			<input type="hidden" name="pageIndex" value="1" />
			<input type="hidden" name="pageLimit" value="10" />
		</form>
	</fieldset>
	</div></div></div>
	<div class="layui-form">
		<table class="layui-table">
			<colgroup>
				<col width="15%"><col width="17%"><col width="20%">
				<col width="13%"><col width="35%">
			</colgroup>
			<thead>
				<tr>
					<th>序号</th><th>账号</th><th>姓名</th>
					<th>是否管理员</th><th>操作</th>
				</tr>
			</thead>
			<tbody id="user_tbody3"></tbody>
		</table>
		<div id="pageInfoUser" 
		style="text-align: right;padding-right: 30px"></div>
	</div>
<script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>
<script type="text/javascript">

formSubmit('/user/selectList.do','submit(search)','json'
		,function(data) {// console.log(data)
    var curr = $("input[name='pageIndex']").val();
    var limit = $("input[name='pageLimit']").val();
    setPageInfo('pageInfoUser',data.count,curr,limit
    		,function(obj, first){
        $("input[name='pageIndex']").val(obj.curr);
        $("input[name='pageLimit']").val(obj.limit);
        if(!first){refresh();}//首次不执行
    })
    var html = "" ;//	加载表格中数据
    $.each(data.list,function(i, dom) {
    	var usercode = dom.usercode?dom.usercode:'';
        var name = dom.name?dom.name:'';
        var isAdmin = dom.isAdmin?dom.isAdmin:'';
        var d={i:(i+1+(curr-1)*limit),name:name,usercode:usercode,isAdmin:isAdmin};
        html += getlaytpl('#tradd3',d);
    });
    $("#user_tbody3").html(html);
});

refresh();
function refresh(){
    $("input[value='查询']").click();
}
function openAdd(){
	openLayer('/web/page/user/add.jsp',refresh)
}
function openUpd(usercode){
	openLayer('/web/page/user/upd.jsp?usercode='+usercode,refresh)
}
function openUserPas(usercode){
    openLayer('/web/page/user/passupd.jsp?usercode='+usercode,refresh)
}
function del(usercode){
	openConfirm(function(index){
		ajax('/user/delete.do', {id:usercode}, 'text', function(data){
	        if (data == 1) {
	            layer.msg('删除成功');
	            $("input[name='pageIndex']").val(1);
	            refresh();
	        } if(data == 2){
	        	layer.msg('账号正在被占用，无法删除！');
	        }
	    })
	})
}
</script>
<script id="tradd3" type="text/html">
<tr>
<td>{{ d.i }}</td><td>{{ d.usercode }}</td><td>{{ d.name }}</td>
<td>{{ d.isAdmin }}</td>
<td>
    <input type='button' value='修改' class='layui-btn' 
           onclick='openUpd("{{ d.usercode }}")'/>&nbsp;
    <a href="javascript:del('{{ d.usercode }}')" 
       class="layui-btn layui-btn-sm layui-btn-danger">
        <i class="layui-icon layui-icon-delete"></i> </a>&nbsp;
    <input type='button' class='layui-btn' value='重置密码' 
        onclick='openUserPas("{{ d.usercode }}")'/>
</td>
</tr>
</script>
</body>
</html>