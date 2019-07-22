<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>订单商品</title>
</head>
<body>

	<form class="layui-form">
			<div class="layui-form-item">
				<label class="layui-form-label">订单编号</label>
				<div class="layui-input-inline">
					 <input type="text" name="orderCode"  value="<%=request.getParameter("code")%>" autocomplete="off"  readonly class="layui-input">
				</div>
				<label class="layui-form-label">商品编号</label>
				<div class="layui-input-inline">
					   <select  name="goodsCode"  lay-search >
					  </select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">数量</label>
				<div class="layui-input-inline">
					<input type="text" name="amount" placeholder="请输入数量" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">价格</label>
				<div class="layui-input-inline">
					<input type="text" name="price" placeholder="请输入总价格" autocomplete="off" class="layui-input">
					
				</div>
			</div>
			<div class="layui-input-inline">
			<span> 
				<input type="button" class="layui-btn" lay-submit lay-filter="add" value="添加" /> 
			</span>
			</div>
	</form>
	
	<div class="layui-form">
		<table class="layui-table">
			<colgroup>
				<col ><col ><col >
				<col ><col><col ><col >
			</colgroup>
			<thead>
				<tr>
					<th>序号</th><th>订单编号</th><th>商品名称</th>
					<th>数量</th><th>价格</th><th>操作</th>
				</tr>
			</thead>
			<tbody id="per_tbody"></tbody>
		</table>
	</div>

<script type="text/javascript">

init();
function init(){
	var code = '<%=request.getParameter("code")%>';
	ajax('/ordergoods/selectList.do',{orderCode:code},'json',function(data){
		var html = "";
		$.each(data.list,function(i,dom){
			var orderCode = dom.orderCode;
			var goodsCode = dom.goodsCode;
			var amount = dom.amount;
			var price = dom.price;
			var id = dom.id;
			var d = {id:id,orderCode:orderCode,goodsCode:goodsCode,amount:amount,price:price}
			html += getlaytpl('#t_per',d)
		})
		$('#per_tbody').html(html)
	})
}

	form.render()
	
    ajax("/descr/selectAll.do",'',"json",function(data){
	var html = '';
	$.each(data,function(i,d){
		html+=laytpl($('#opt2').html()).render(d);
	})
	$("select[name='goodsCode']").html(html);
	form.render()
});
	
	formSubmit('/ordergoods/add.do', 'submit(add)', 'text',function(data) {
		if (data == 1) {
			layer.msg('添加订单商品成功');
			init();
		} else if(data == 2){
			layer.msg('添加了相同商品，数量已修改');
			init();
		}else{
			layer.msg('添加失败');
		}
	});

	function del(id){
		openConfirm(function(index){
			ajax('/ordergoods/delete.do', {id:id}, 'text', function(data){
		        if (data == 1) {
		            layer.msg('删除成功');
		            init();
		        } else{
		        	layer.msg('删除失败');
		        }
		    })
		})
	}
	
</script>

 <script type="text/html" id="opt2" >
    <option value='{{ d.code }}'>{{ d.name }}</option>
 </script>

<script id="t_per" type="text/html">
	<tr>
		<td>{{d.id}}</td>
		<td>{{d.orderCode}}</td>
		<td>{{d.goodsCode}}</td>
		<td>{{d.amount}}</td>
		<td>{{d.price}}</td>
		<td>
				 <a href="javascript:del('{{ d.id }}')" class="layui-btn layui-btn-danger">
        			删除 </a>;
		</td>
	</tr>
</script>
</body>
</html>