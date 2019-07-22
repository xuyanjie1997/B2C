<!DOCTYPE html> 
<html>
	<head>
		<meta charset="UTF-8">
        <meta name="author" content="order by dede58.com"/>
		<title>XShop商城-个人中心</title>
		<link rel="stylesheet" type="text/css" href="./css/style.css">
		<%@ include file="/web/header.jsp"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
	<%@ page isELIgnored="false"%> 
	</head>
	<body>

	<div>   
        <%@ include file="/web/proweb/head.jsp" %> 
    </div>

	<div>   
        <%@ include file="/web/proweb/head2.jsp" %> 
    </div>

	<div class="xiantiao"></div>
		<div class="gwcxqbj">
			<div class="gwcxd center">
				<div class="top2 center">
					<div class="sub_top fl">数量</div>
					<div class="sub_top fl">商品名</div>
					<div class="sub_top fl">单价</div>
					<div class="sub_top fl">小计</div>
					<div class="clear"></div>
				</div>
				
			<div id="carlist0">
	
			</div>
			
<div class="xiantiao"></div>

			<div class="layui-form-item">
				<label class="layui-form-label">收件人</label>
				<div class="layui-input-block">
					<input type="text" name="attn" required lay-verify="required" placeholder="请输入收件人姓名" autocomplete="off" class="layui-input">
				</div>			
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">收货地址</label>
					<div class="layui-input-block">
					<input type="text" name="address" required lay-verify="required" placeholder="请输入收货地址" autocomplete="off" class="layui-input">
				</div>	
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">联系电话</label>
				<div class="layui-input-block">
					<input type="text" name="tel" required lay-verify="required" placeholder="请输入联系电话" autocomplete="off" class="layui-input">
				</div>			
			</div>
			
			<div class="jiesuandan mt20 center">
				<div class="tishi fl ml20">
					<ul>
						<li>共<span id="count0"></span>件商品</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="jiesuan fr">
					<div class="jiesuanjiage fl">合计（不含运费）：<span id="heji0"></span></div>
					<div class="jsanniu fr">
						<input class="jsan" type="button" name="xiadan" value="下单" onclick="xiadan()" /></div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
			
		</div>

	 <div>   
        <%@ include file="/web/proweb/foot.jsp" %> 
    </div>
<script type="text/javascript">

<%
Object obj2 = session.getAttribute("prouser");
UserModel u = (UserModel)obj2;
%>
var code = '<%=u.getUsercode()%>';
var ids = '<%=request.getParameter("ids")%>';

init();
//	回显需要结算的商品信息
function init(){
	var idarr = ids.split(",");
	var h1 = "";
	var priceall = 0;
	ajax("/car/selectByUser" , {usercode:code} , "json" , function(data){
		$.each(data.list,function(i , dom){
			var num = dom.num;
			var id = dom.id;
			var price = dom.descr[0].price;
			var bool = false;
			$.each(idarr,function(j , d){
				if(id == d){
					bool = true;
				}
			});
			if(bool == false){
				return;
			}
			h1 += "<div class='content2 center' >"
			h1 += "<div class='sub_content fl' >"+num+"</div>";
			h1 += "<div class='sub_content fl'><img src='/image/"+dom.pic[0].url+"' alt='null' width='75px' height='75px'></div>";
			h1 += "<div class='sub_content fl ft20'>"+dom.descr[0].name+"</div>";
			h1 += "<div class='sub_content fl' id='danjia'>"+price+"</div>";
			h1 += "<div class='sub_content fl' id='cost"+i+"'>"+getValue(price,num)+"</div>";
			h1 += "<div class='clear'></div></div>";	
			priceall += price*num;
		})
		$("#count0").html(idarr.length);
		$("#carlist0").html(h1);
		$("#heji0").html(priceall.toFixed(2));
	})
}

//	计算小计
function getValue(price,num){
	return new Number(parseFloat(price)*parseFloat(num));
}

//	下单按钮，执行添加订单，添加订单商品，删除购物车的操作
function xiadan() {
	var idarr = ids.split(",");
	var attn = $("input[name='attn']").val();
	var address = $("input[name='address']").val();
	var tel = $("input[name=tel]").val();
	var heji = $("#heji0").text();
	ajax("/ordermsg/add.do", {attn : attn,address : address,tel : tel,usercode : code, heji : heji}, "text", function(ordercode) {
		var oc = ordercode;
		ajax("/car/selectByUser", {usercode : code}, "json", function(data) {
			$.each(data.list, function(i, dom) {
				var num = dom.num;
				var id = dom.id;
				var gc = dom.goodsCode;
				var danjia = dom.descr[0].price;
				var price = getValue(danjia, num);
				$.each(idarr, function(j, d) {
					if (id == d) {						
						ajax("/ordergoods/add.do", {orderCode : oc,goodsCode : gc,amount : num,price : price}, "json", function(ddd) {
							if(ddd == 1){
								layer.msg("订单和商品添加成功");
							}else{
								layer.msg("下单失败");
							}
						})
						delbyid(id);
					}
				})
			})
		})
	})
	 window.location = "/xshop/web/proweb/dingdanzhongxin.jsp";
}
	
//	删除下单完成后，购物车中已结算的记录
function delbyid(id){
	ajax("/car/del.do" , {id:id} , "text" , function(data){
	})
}
	
</script>

	</body>
</html>