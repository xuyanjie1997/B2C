<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>商品详细信息</title>
</head>
<body>

<div class="layui-collapse">
  <div class="layui-colla-item">
    <h2 class="layui-colla-title">商品详细信息-查询条件</h2>
    <div class="layui-colla-content layui-show">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px; padding: 5px">
		<legend>商品详细信息-查询条件</legend>
		<form class="layui-form">
			<div class="layui-form-item">
				<label class="layui-form-label">编号</label>
				<div class="layui-input-inline">
					<input type="text" name="code" placeholder="请输入项目编号" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">名称</label>
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
				<col width="5%"><col width="10%"><col width="10%">
				<col width="8%"><col width="15%"><col width="7%">
				<col width="10%"><col width="10%"><col width="30%">
			</colgroup>
			<thead>
				<tr>
					<th>序号</th><th>编号</th><th>名称</th>
					<th>价格</th><th>描述</th><th>数量</th>
					<th>状态</th><th>字典编号</th><th>操作</th>
				</tr>
			</thead>
			<tbody id="gc_tbody3"></tbody>
		</table>
		<div id="pageInfoGC" style="text-align: right;padding-right: 30px"></div>
	</div>
	
<script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>
<script type="text/javascript">

formSubmit('/descr/selectList.do','submit(search)','json'
		,function(data) {// console.log(data)
    var curr = $("input[name='pageIndex']").val();
    var limit = $("input[name='pageLimit']").val();
    setPageInfo('pageInfoGC',data.count2,curr,limit
    		,function(obj, first){
        $("input[name='pageIndex']").val(obj.curr);
        $("input[name='pageLimit']").val(obj.limit);
        if(!first){refresh();}//首次不执行
    })
    var html = "" ;//	加载表格中数据
    $.each(data.list2,function(i, dom) {
    	var id = dom.id;
    	var code = dom.code?dom.code:'';
        var name = dom.name?dom.name:'';
        var state = dom.state?dom.state:'';
        var price = dom.price?dom.price:0;
        var amount = dom.amount?dom.amount:0;
        var description = dom.description?dom.description:'';
        var dicCode = dom.dicCode?dom.dicCode:'';
        var d={i:(i+1+(curr-1)*limit),name:name,code:code,price:price,description:description,state:state,amount:amount,dicCode:dicCode};
        html += getlaytpl('#tradd3',d);
    });
    $("#gc_tbody3").html(html);
});

refresh();
function refresh(){
    $("input[value='查询']").click();
}
function openAdd(){
	openLayer('/descr/addorupd.do',refresh)
}
function openUpd(code){
	openLayer('/descr/addorupd.do?code='+code,refresh)
}
function openPic(code) {
	openLayer('/web/page/goods/goodspic.jsp?code='+code,refresh)
}
function del(code){
	openConfirm(function(index){
		ajax('/descr/delete.do', {id:code}, 'text', function(data){
	        if (data == 1) {
	            layer.msg('删除成功');
	            $("input[name='pageIndex']").val(1);
	            refresh();
	        } else{
	        	layer.msg('删除失败');
	        }
	    })
	})
}

</script>
<script id="tradd3" type="text/html">
<tr>
<td>{{ d.i }}</td><td>{{ d.code }}</td><td>{{ d.name }}</td>
<td>{{ d.price }}</td><td>{{ d.description }}</td><td>{{ d.amount }}</td>
<td>{{ d.state }}</td><td>{{ d.dicCode }}</td>
<td>
    <input type='button' value='修改' class='layui-btn' 
           onclick='openUpd("{{ d.code }}")'/>&nbsp;
    <a href="javascript:del('{{ d.code }}')" 
       class="layui-btn layui-btn-sm layui-btn-danger">
        <i class="layui-icon layui-icon-delete"></i> </a>&nbsp;
	<input type='button' value='商品图片' class='layui-btn' 
           onclick='openPic("{{ d.code }}")'/>
</td>
</tr>
</script>
	
</body>
</html>