<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>动态表格测试</title>
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
				<input type="button" class="layui-btn" onclick="refresh()" value="查询" /> 
				<input type="reset" class="layui-btn" value="重置" /> 
				<input type="button" class="layui-btn" value="添加" onclick="openAdd()" />
				</span>
			</div>
			
			<div class="layui-form-item">
				<input type="button" class="layui-btn" onclick="exportExcel()" value="导出文件" /> 
				<input type="button" class="layui-btn" onclick="exportTemp()" value="下载模板" /> 
				<input type="button" class="layui-btn"  value="上传文件" /> 
			</div>
			
			<input type="hidden" name="pageIndex" value="1" />
			<input type="hidden" name="pageLimit" value="10" />
		</form>
	</fieldset>
	</div></div></div>

	<table class="layui-hide" id="test" lay-filter="test"></table>
                       
<script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>

<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
    <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
    <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
    <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
  </div>
</script>

<script type="text/javascript">

refresh();
function refresh(){
	layui.use('table', function(){
		  var table = layui.table;
		  
		  table.render({
		    elem: '#test'
		    ,url:'/xshop/descr/selectList.do'
		    ,toolbar: '#toolbarDemo'
		    ,title: '商品信息表'
		    ,where: {name:$("input[name='name']").val() , code: $("input[name='code']").val()} 
		    ,request: {
		    	pageName: 'pageIndex' //	页码的参数名称，默认：page
		    	,limitName: 'pageLimit' //	每页数据量的参数名，默认：limit
		    } 
		    ,cols: [[
		      {type: 'checkbox', fixed: 'left'}
		      ,{field:'id', title:'ID', width:80, fixed: 'left', unresize: true, sort: true}
		      ,{field:'code', title:'商品编号', width:80, edit: 'text'}
		      ,{field:'name', title:'商品名', width:150, edit: 'text'}
		      ,{field:'amount', title:'数量', width:80, edit: 'text', sort: true}
		      ,{field:'price', title:'价格', width:100, sort: true}
		      ,{field:'description', title:'描述'}
		      ,{field:'state', title:'状态' , width:80}
		      ,{field:'dicCode', title:'上级类', width:80, sort: true}
		      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:190 , fixed: 'right'}
		    ]]
		    ,page: true
		  });
		  
		  //	头工具栏事件
		  table.on('toolbar(test)', function(obj){
		    var checkStatus = table.checkStatus(obj.config.id);
		    switch(obj.event){
		      case 'getCheckData':
		        var data = checkStatus.data;
		        layer.alert(JSON.stringify(data));
		      break;
		      case 'getCheckLength':
		        var data = checkStatus.data;
		        layer.msg('选中了：'+ data.length + ' 个');
		      break;
		      case 'isAll':
		        layer.msg(checkStatus.isAll ? '全选': '未全选');
		      break;
		    };
		  });
	});
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

function exportExcel(){
	location.href="/xshop/descr/exportExcel.do";
}

function exportTemp(){
	location.href="/xshop/descr/exportTemp.do";
}

</script>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit" href="javascript:openUpd('{{ d.code }}')"> 编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" href="javascript:del('{{ d.code }}')"> <i class="layui-icon layui-icon-delete"></i> </a></a>
  <input type='button' value='商品图片' class='layui-btn layui-btn-xs' onclick='openPic("{{ d.code }}")'/>
</script>

</body>
</html>