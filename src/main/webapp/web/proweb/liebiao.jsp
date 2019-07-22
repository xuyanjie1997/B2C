<!DOCTYPE html> 
<html>
	<head>
		<meta charset="UTF-8">
        <meta name="author" content="order by dede58.com"/>
		<title>商品列表</title>
		<link rel="stylesheet" type="text/css" href="/xshop/web/proweb/css/style.css">
		<%@ include file="/web/header.jsp"%>
	</head>
	<body>

	<div>   
        <%@ include file="/web/proweb/head.jsp" %> 
    </div>

    <div>   
        <%@ include file="/web/proweb/head2.jsp" %> 
    </div>

	<div class="danpin center" id="liebiao">
	<!-- 	拼接列表数据处 -->
	</div>

	<div class="clear">	
		<div id="pageInfoGC" style="text-align: right;padding-right: 30px"></div>
	</div>
	
	<div class="clear"></div>
	
	<div>   
        <%@ include file="/web/proweb/foot.jsp" %> 
    </div>
	
<script type="text/javascript" src="/xshop/web/common/layui/layui.all.js"></script>
<script type="text/javascript" src="/xshop/web/common/js/common.js"></script>
<script type="text/javascript">
	
	<%
		String code = request.getParameter("code");
		Integer type = Integer.parseInt(request.getParameter("type"));
		if(code != null && type == 2){//	判断上一网页传入的参数
	%>
	var parcode = '<%=request.getParameter("code")%>';
	var limit = $("input[name='pageLimit']").val();
	sss();
	<%}else if(code != null && type == 1){%>
	var parcode = '<%=request.getParameter("code")%>';
	var limit = $("input[name='pageLimit']").val();
	showone();
	<%}else{%>
	showdescr2();
	<%}%>
	
	//	查找二级分类下所有商品
	function sss(){
		ajax("/descr/getList.do" , {dicCode:parcode,pageLimit:limit} , "json" , function(data){
			var curr = $("input[name='pageIndex']").val();
		    var limit = $("input[name='pageLimit']").val();
		    setPageInfo('pageInfoGC',data.count2,curr,limit,function(obj, first){
	 	        $("input[name='pageIndex']").val(obj.curr);
		        $("input[name='pageLimit']").val(obj.limit); 
	 	        var cu =  obj.curr;
	 	        var li = obj.limit;
		        if(!first){ 
		        	ajax("/descr/getList.do" , {dicCode:parcode,pageLimit:li,pageIndex:cu} , "json" , pinjie)
		        }
		    }) 
		    pinjie(data);
		})
	}
	
	//	拼接div标签
	function pinjie(data){
		console.log(data);
	        var html = "";
		    html += "<div class='biaoti center' >列表详情</div><div class='main center'>"
			$.each(data.list2 , function(i,dom){
				var code = dom.code;
				ajax("/pic/findPic.do" , {goodsCode:code} , "json" , function(data2){
					$.each(data2.pic , function(j,ddd){
						var p = dom.price
						p = parseFloat(p).toFixed(2);
						html += "<div class='mingxing fl mb20' style='border:2px solid #fff;width:230px;cursor:pointer;' onmouseout='this.style.border=\"2px solid #fff\"' onmousemove=\"this.style.border='2px solid red'\">";
						html += "<div class='sub_mingxing'><a href='/xshop/web/proweb/xiangqing.jsp?code="+code+"' target='_blank'><img src='/image/"+ddd.url+"' alt=''></a></div>";
						html += "<div class='pinpai'><a href='/xshop/web/proweb/xiangqing.jsp?code="+code+"' target='_blank'>"+dom.name+"</a></div>";
						html += "<div class='youhui'>"+dom.description+"</div>";
						html += "<div class='jiage'>"+p+"元</div></div>";						
						$("#liebiao").html(html);
					})
				})	
			});	
		}
	
	// 	搜索按钮，模糊查询
	function showdescr2(){
		var count = '<%=request.getAttribute("count")%>';
		var list = '<%=request.getAttribute("list")%>';
 		console.log(list);
		var curr = $("input[name='pageIndex']").val();
	    var limit = $("input[name='pageLimit']").val();
	    setPageInfo('pageInfoGC',count,curr,limit,function(obj, first){
	        $("input[name='pageIndex']").val(obj.curr);
	        $("input[name='pageLimit']").val(obj.limit);
	        if(!first){ 
	        	$('input[value="搜索"]').click();
	        }      
	    }) 
		var html = "";
	    html += "<div class='biaoti center' >列表详情</div><div class='main center'>"
		$.each(JSON.parse(list),function(i,dom){
			var code = dom.code;
			ajax("/pic/findPic.do" , {goodsCode:code} , "json" , function(data2){
				$.each(data2.pic , function(j,ddd){
					var p = dom.price
					p = parseFloat(p).toFixed(2);
					html += "<div class='mingxing fl mb20' style='border:2px solid #fff;width:230px;cursor:pointer;' onmouseout='this.style.border=\"2px solid #fff\"' onmousemove=\"this.style.border='2px solid red'\">";
					html += "<div class='sub_mingxing'><a href='/xshop/web/proweb/xiangqing.jsp?code="+code+"' target='_blank'><img src='/image/"+ddd.url+"' alt=''></a></div>";
					html += "<div class='pinpai'><a href='/xshop/web/proweb/xiangqing.jsp?code="+code+"' target='_blank'>"+dom.name+"</a></div>";
					html += "<div class='youhui'>"+dom.description+"</div>";
					html += "<div class='jiage'>"+p+"元</div></div>";
					$("#liebiao").html(html);
				})
			})	
		});	
	    
	}
	
	//	展示一级分类下所有商品
	function showone(){
		ajax("/descr/mohuyiji.do" , {dicCode:parcode,pageLimit:limit} , "json" , function(data){
			var curr = $("input[name='pageIndex']").val();
		    var limit = $("input[name='pageLimit']").val();
		    setPageInfo('pageInfoGC',data.count2,curr,limit,function(obj, first){
	 	        $("input[name='pageIndex']").val(obj.curr);
		        $("input[name='pageLimit']").val(obj.limit); 
	 	        var cu =  obj.curr;
	 	        var li = obj.limit;
		        if(!first){ 
		        	ajax("/descr/mohuyiji.do" , {dicCode:parcode,pageLimit:li,pageIndex:cu} , "json" , pinjie)
		        }
		    }) 
		    pinjie(data);
		})
	}
	
	</script>
	</body>
</html>