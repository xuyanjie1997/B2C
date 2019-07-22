<%@page import="com.xyj.shop.user.model.UserModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>订单商品</title>
</head>
<body>
	
	<h1 id="h1"></h1>
	<div class="layui-form">
		<table class="layui-table">
			<colgroup>
				<col ><col ><col >
				<col ><col><col ><col >
			</colgroup>
			<thead>
				<tr>
					<th>商品名称</th><th>商品图片</th>
					<th>数量</th><th>价格</th>
				</tr>
			</thead>
			<tbody id="tbody"></tbody>
		</table>
	</div>

<script type="text/javascript">

<%
Object obj2 = session.getAttribute("prouser");
UserModel u = (UserModel)obj2;
if(u == null){
%>
$("#h1").html("您还没有登录！");
<%}else{%>

form.render()

init();
function init(){
	var code = '<%=request.getParameter("code")%>';
	ajax('/ordergoods/selectByOrder.do',{orderCode:code},'json',function(data){
		console.log(data)
		var html = "";
		$.each(data.list,function(i,dom){
			var goodsName = dom.delist[0].name;
			var picUrl = dom.pic[0].url;
			var amount = dom.amount;
			var price = dom.price;
			var d = {goodsName:goodsName,picUrl:picUrl,amount:amount,price:price}
			html += getlaytpl('#t_per',d)
		})
		$('#tbody').html(html)
	})
}

	form.render()
	
<%}%>
</script>

<script id="t_per" type="text/html">
	<tr>
		<td>{{d.goodsName}}</td>
		<td><img src='/image/{{d.picUrl}}' alt='null' width='75px' height='75px'></td>
		<td>{{d.amount}}</td>
		<td>{{d.price}}</td>
	</tr>
</script>
</body>
</html>