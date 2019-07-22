<!DOCTYPE html>  
<html>
	<head>
		<meta charset="UTF-8">
        <meta name="author" content="order by dede58.com"/>
		<title>立即购买</title>
		<link rel="stylesheet" type="text/css" href="./css/style.css">
		<%@ include file="/web/header.jsp"%>
	</head>
	<body>

	<div>   
        <%@ include file="/web/proweb/head.jsp" %> 
    </div>

<!-- start banner_x -->
	<div>   
        <%@ include file="/web/proweb/head2.jsp" %> 
    </div>	
<!-- end banner_x -->

	
	<!-- xiangqing -->
	<form action="post" method="">
	<div class="xiangqing">
		<div class="neirong w">
			<div class="xiaomi6 fl">商品详情</div>
			<nav class="fr">
			<ul>
				<li><a href="">概述</a></li>
				<li>|</li>
				<li><a href="">设计</a></li>
				<li>|</li>
				<li><a href="">参数</a></li>
				<li>|</li>
				<li><a href="">厂家</a></li>
				<li>|</li>
				<li><a href="">用户评价</a></li>
			</ul>
				<div class="clear"></div>
			</nav>
			<div class="clear"></div>
		</div>	
	</div>
	
	<div class="jieshao mt20 w" id="model">
		
	</div>
	</form>
	
	<!-- footer -->
	   <div>   
        <%@ include file="/web/proweb/foot.jsp" %> 
    </div>
<script type="text/javascript">

var goodscode = '<%=request.getParameter("code")%>';
ajax("/descr/selectModel.do" , {goodscode:goodscode} , "json" , showmodel)

function showmodel(data){
	var html = "";	
// 	var d={price:data.price};
	var p = data.price
	p = parseFloat(p).toFixed(2);
	ajax("/pic/findPic.do" , {goodsCode:goodscode} , "json" , function(data2){
		$.each(data2.pic , function(j,ddd){
			html += "<div class='left fl'><img src='/image/"+ddd.url+"' width='600px' height='600px'></div><div class='right fr'>";
			html += "<div class='h3 ml20 mt20'>"+data.name+"</div><div class='jianjie mr40 ml20 mt10'>"+data.description+"</div>";
			html += "<div class='jiage ml20 mt10'>"+p+"元</div>";
			html += "<div class='xqxq mt20 ml20'><div class='top1 mt10'><div class='left1 fl'>"+data.name+"</div><div class='right1 fr'>"+p+"元</div>";
			html += "<div class='clear'></div></div><div class='bot mt20 ft20 ftbc'>总计："+p+"元</div></div>"; 
			html += "<div class='xiadan ml20 mt20'>";
			html += "<input class='jrgwc' type='button' name='jrgwc' onclick='addcar(\""+data.code+"\")' value='加入购物车' /></div></div><div class='clear'></div>";
			$("#model").html(html);
		})
})	
}

function addcar(code){
	ajax('/car/add.do' , {goodsCode:code} , 'json' , function(data){
		if(data == 1){
			layer.msg("添加成功，您可以去购物车查看");
		}else if(data == 2){
			layer.msg("您还未登录");
		}else{
			layer.msg("遇到错误，添加失败，请联系管理员");
		}
	})
}

</script>

</body>
</html>