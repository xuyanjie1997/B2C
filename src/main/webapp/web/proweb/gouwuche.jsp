<!DOCTYPE html> 
<html>
	<head>
		<meta charset="UTF-8">
        <meta name="author" content="order by dede58.com"/>
		<title>我的购物车</title>
		<link rel="stylesheet" type="text/css" href="/xshop/web/proweb/css/style.css">
		<%@ include file="/web/header.jsp"%>
	</head>
	<body>
	<!-- start header -->
	<div>   
        <%@ include file="/web/proweb/head.jsp" %> 
    </div>
	<!--end header -->

<!-- start banner_x -->
		<!-- start banner_x -->
		<div class="banner_x center">
			<a href="./index.jsp" target="_blank"><div class="logo fl"></div></a>	
			<div class="wdgwc fl ml40">我的购物车</div>
			<div class="wxts fl ml20">温馨提示：产品是否购买成功，以最终下单为准哦，请尽快结算</div>
			<div class="clear"></div>
		</div>
		<div class="xiantiao"></div>
		<div class="gwcxqbj">
			<div class="gwcxd center">
				<div class="top2 center">
					<div class="sub_top fl">
						<input type="checkbox" value="quanxuan" class="quanxuan" onchange="selall(this)"/>全选
					</div>
					<div class="sub_top fl">商品名称</div>
					<div class="sub_top fl">单价</div>
					<div class="sub_top fl">数量</div>
					<div class="sub_top fl">小计</div>
					<div class="sub_top fr">操作</div>
					<div class="clear"></div>
				</div>
				
			<div id="carlist">
	
<!-- 				<div class="content2 center" id="con0"> -->
<!-- 				</div>	 -->
<!-- 				<div class="content2 center" id="con1"> -->
<!-- 				</div>	 -->
<!-- 				<div class="content2 center" id="con2"> -->
<!-- 				</div>	 -->

			</div>		
			
			</div>	
				
			<div class="jiesuandan mt20 center">
				<div class="tishi fl ml20">
					<ul>
						<li><a href="./index.jsp">继续购物</a></li>
						<li>|</li>
						<li>共<span id="count"></span>件商品，已选择<span id="yixuanze"></span>件</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="jiesuan fr">
					<div class="jiesuanjiage fl">合计（不含运费）：<span id="heji"></span></div>
					<div class="jsanniu fr">
						<input class="jsan" type="button" name="jiesuan" value="去结算"/></div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
			
		</div>

<div class="clear"></div>

		<div>   
        <%@ include file="/web/proweb/foot.jsp" %> 
    </div>

<script type="text/javascript">

<%
	Object obj2 = session.getAttribute("prouser");
	UserModel u = (UserModel)obj2;
%>
var code = '<%=u.getUsercode()%>';
// alert(code);
  
$("input[name='jiesuan']").click(function(){
	var quanxuan = $("input[name='quanxuan']:checked");
	var ids=[];
	quanxuan.each(function(i,d){
		ids.push($(this).val())
	})
// 	alert(ids.length);
	var zongjia = $("#heji").text();
	if(ids.length == 0){
		layer.msg("您还没选择任何一种商品");
		return;
	}
	 location.href = "/xshop/web/proweb/queren.jsp?ids="+ids+"";
})
  
init();
function init(){
	var priceall = 0;
	var h1 = "";
	ajax("/car/selectByUser.do" , {usercode:code} , 'json' , function(data){
		console.log(data)
		$.each(data.list , function(i , dom){
			var num = dom.num;
			var id = dom.id;
			var price = dom.descr[0].price;
// 			var gc = dom.goodsCode;
// 			alert(gc)
			h1 += "<div class='content2 center' id='con"+i+"'>"
			h1 += "<div class='sub_content fl'><input type='checkbox' value='"+id+"' name='quanxuan' onchange='heji()' /></div>";
			h1 += "<div class='sub_content fl'><img src='/image/"+dom.pic[0].url+"' alt='null' width='75px' height='75px'></div>";
			h1 += "<div class='sub_content fl ft20'>"+dom.descr[0].name+"</div>";
			h1 += "<div class='sub_content fl'>"+price+"</div>";
			h1 += "<div class='sub_content fl'><input class='shuliang' type='number' value='"+num+"' step='1' min='1' onchange='chnum(this,"+id+")' ></div>";
			h1 += "<div class='sub_content fl' id='cost"+i+"'>"+getValue(price,num)+"</div>";
			h1 += "<div class='sub_content fl'><a href='javascript:del("+id+")'>×</a></div><div class='clear'></div></div>";	
			priceall += price*num;
		})
		$("#count").html(data.list.length);
		$("#carlist").html(h1);
		heji();
	})
}

function getValue(price,num){
	return new Number(parseFloat(price)*parseFloat(num)).toFixed(2);
}

function chnum(obj,id){
	var val = obj.value;
// 	alert(val)
	ajax("/car/chnum" , {id:id,num:val} , "text" , function(data){
		if(data == 1){
			obj.value = val;
			var cost = $(obj).parent().prev().text();
			$(obj).parent().next().text(getValue(cost,val));
			heji();
		}
	})
}

function selall(obj){
	$("input[type='checkbox']").prop('checked',$(obj).prop('checked'))
	heji();
}

function heji(){
	var quanxuan = $("input[name='quanxuan']:checked");
// 	alert(quanxuan.length);
	$("#yixuanze").html(quanxuan.length);
	var zongjia = 0.0;
	quanxuan.each(function(i,d){
		var cost = $(this).parent().next().next().next().next().next().text();
		zongjia += parseFloat(cost);
	})
	$("#heji").html(zongjia.toFixed(2));
}

function del(id){
	ajax("/car/del.do" , {id:id} , "text" , function(data){
		if(data == 1){
			layer.msg("该商品已成功从您的购物车删除");		
			init();
		}else{
			layer.msg("操作失败，请联系管理员");		
		}
	})
}

</script>
	</body>
</html>
