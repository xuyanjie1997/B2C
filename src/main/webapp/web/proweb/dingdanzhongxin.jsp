<!DOCTYPE html> 
<html>
	<head>
		<meta charset="UTF-8">
        <meta name="author" content="order by dede58.com"/>
		<title>订单中心</title>
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
	
<!-- self_info -->
	<div class="grzxbj">
		<div class="selfinfo center">
		<div class="lfnav fl">
			<div class="ddzx">订单中心</div>
			<div class="subddzx">
				<ul>
					<li><a href="" style="color:#ff6700;font-weight:bold;">我的订单</a></li>
					<li><a href="">团购订单</a></li>
					<li><a href="">评价晒单</a></li>
				</ul>
			</div>
			<div class="ddzx">个人中心</div>
			<div class="subddzx">
				<ul>
					<li><a href="/xshop/web/proweb/self_info.jsp">我的个人中心</a></li>
					<li><a href="">消息通知</a></li>
					<li><a href="">优惠券</a></li>
					<li><a href="">收货地址</a></li>
				</ul>
			</div>
		</div>
		<div class="rtcont fr">
			<div class="ddzxbt">交易订单</div>

	<div class="layui-form">
		<table class="layui-table">
			<colgroup>
				<col width="5%"><col width="15%"><col width="10%"><col width="7%">
				<col width="15%"><col width="10%"><col width="10%"><col width="8%"><col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>序号</th><th>订单编号</th><th>时间</th><th>收件人</th>
					<th>地址</th><th>联系电话</th><th>成交价</th><th>状态</th><th>操作</th>
				</tr>
			</thead>
			<tbody id="gc_tbody3"></tbody>
		</table>
		<div id="pageInfoGC" style="text-align: right;padding-right: 30px"></div>
	</div>		
		</div>
		<div class="clear"></div>
		</div>
	</div>
	
	<div>   
        <%@ include file="/web/proweb/foot.jsp" %> 
    </div>
    
  <script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>
    <script type="text/javascript">
    
    <%
    Object obj2 = session.getAttribute("prouser");
    UserModel u = (UserModel)obj2;
    %>
    var code = '<%=u.getUsercode()%>';

    refresh();
    function refresh(){
    	ajax("/ordermsg/selectByUser.do" , {usercode:code} , "json" , function(data){
    		   var curr = $("input[name='pageIndex']").val();
    	        var limit = $("input[name='pageLimit']").val();
    	        setPageInfo('pageInfoGC',data.count,curr,limit,function(obj, first){
    	            $("input[name='pageIndex']").val(obj.curr);
    	            $("input[name='pageLimit']").val(obj.limit);
    	            if(!first){refresh();}//首次不执行
    	        })
    	 var html = "" ;//	加载表格中数据
         $.each(data.list,function(i, dom) {
         	var code = dom.code?dom.code:'';
             var time = dom.time?dom.time:'';
             var attn = dom.attn?dom.attn:'';
             var address = dom.address?dom.address:'';
             var tel = dom.tel?dom.tel:'';
             var heji = dom.heji.toFixed(2);
             var state = dom.state?dom.state:'';
             var d={i:(i+1+(curr-1)*limit),code:code,time:time,attn:attn,address:address,tel:tel,heji:heji,state:state};
             html += getlaytpl('#tradd3',d);
         });
         $("#gc_tbody3").html(html);
    	})
         
    }

    function openGoods(code){
    	openLayer('/web/proweb/dingdanshangpin.jsp?code='+code,refresh)
    }

    </script>
    <script id="tradd3" type="text/html">
    <tr>
    <td>{{ d.i }}</td><td>{{ d.code }}</td>
    <td>{{ d.time }}</td><td>{{ d.attn }}</td><td>{{ d.address }}</td>
    <td>{{ d.tel }}</td><td>{{ d.heji }}</td><td>{{ d.state }}</td>
    <td>
    			<input type='button' value='查看商品' class='layui-btn layui-btn-danger' 
               onclick='openGoods("{{ d.code }}")'/>
    </td>
    </tr>
    </script>
    
    </script>
	</body>
</html>