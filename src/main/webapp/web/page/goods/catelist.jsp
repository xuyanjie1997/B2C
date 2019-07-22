<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/web/header.jsp"%>
<title>商品分类信息</title>
</head>
<body>
<div class="layui-collapse">
  <div class="layui-colla-item">
    <h2 class="layui-colla-title">商品分类信息-查询条件</h2>
    <div class="layui-colla-content layui-show">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px; padding: 5px">
		<legend>商品分类信息-查询条件</legend>
		<form class="layui-form">
			<div class="layui-form-item">
				<label class="layui-form-label">编号</label>
				<div class="layui-input-inline">
					<input type="text" name="code" placeholder="请输入编号" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">名称</label>
				<div class="layui-input-inline">
					<input type="text" name="name" placeholder="请输入名称" autocomplete="off" class="layui-input">
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
				<col width="10%"><col width="12%"><col width="20%">
				<col width="23%"><col width="15%"><col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>序号</th><th>编号</th><th>名称</th>
					<th>描述</th><th>上级编号</th><th>操作</th>
				</tr>
			</thead>
			<tbody id="gc_tbody3"></tbody>
		</table>
		<div id="pageInfoGC" style="text-align: right;padding-right: 30px"></div>
	</div>
<script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>
<script type="text/javascript">

formSubmit('/goodscate/selectList.do','submit(search)','json'
		,function(data) {// console.log(data)
    var curr = $("input[name='pageIndex']").val();
    var limit = $("input[name='pageLimit']").val();
    setPageInfo('pageInfoGC',data.count,curr,limit
    		,function(obj, first){
        $("input[name='pageIndex']").val(obj.curr);
        $("input[name='pageLimit']").val(obj.limit);
        if(!first){refresh();}//首次不执行
    })
    var html = "" ;//	加载表格中数据
    $.each(data.list,function(i, dom) {
    	var code = dom.code?dom.code:'';
        var name = dom.name?dom.name:'';
        var descr = dom.descr?dom.descr:'';
        var parentCode = dom.parentCode?dom.parentCode:'';
        var d={i:(i+1+(curr-1)*limit),name:name,code:code,descr:descr,parentCode:parentCode};
        html += getlaytpl('#tradd3',d);
    });
    $("#gc_tbody3").html(html);
});

refresh();
function refresh(){
    $("input[value='查询']").click();
}
function openAdd(){
	openLayer('/goodscate/addorupd.do',refresh)
}
function openUpd(code){
	openLayer('/goodscate/addorupd.do?code='+code,refresh)
}
function del(code){
	openConfirm(function(index){
		ajax('/goodscate/delete.do', {id:code}, 'text', function(data){
	        if (data == 1) {
	            layer.msg('删除成功');
	            $("input[name='pageIndex']").val(1);
	            refresh();
	        } else if(data == 9){
	        	layer.msg('删除失败,该分类下存在商品');
	        }else if(data == 8){
	        	layer.msg('此分类不支持删除');
	        }
	    })
	})
}
</script>
<script id="tradd3" type="text/html">
<tr>
<td>{{ d.i }}</td><td>{{ d.code }}</td><td>{{ d.name }}</td>
<td>{{ d.descr }}</td><td>{{ d.parentCode }}</td>
<td>
    <input type='button' value='修改' class='layui-btn' 
           onclick='openUpd("{{ d.code }}")'/>&nbsp;
    <a href="javascript:del('{{ d.code }}')" 
       class="layui-btn layui-btn-sm layui-btn-danger">
        <i class="layui-icon layui-icon-delete"></i> </a>&nbsp;
</td>
</tr>
</script>
</body>
</html>