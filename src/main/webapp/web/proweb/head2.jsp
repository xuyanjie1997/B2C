<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


		<div class="banner_x center">
			<a href="/xshop/web/proweb/index.jsp" target="_blank"><div class="logo fl"></div></a>
			<div class="nav fl" >
				<ul id="fenlei">
				
<!-- 					<li><a href="">鞋子</a></li> -->
<!-- 					<li><a href="">衣服</a></li> -->

				</ul>
			</div>
			<div class="search fr">
				<form action="/xshop/descr/chaxun.do" method="post" >
					<div class="text fl">
						<input type="text" class="shuru" name="sousuo"  placeholder="羽绒服限时5折优惠">
					</div>
					<div class="submit fl">
						<input type="submit" class="sousuo" value="搜索" />
					</div>
<!-- 				<input type="hidden" name="pageIndex" value="1" /> -->
<!-- 				<input type="hidden" name="pageLimit" value="5" /> -->
				
						<input type="hidden" name="pageIndex" value="${empty pi?'1':pi }" />
						<input type="hidden" name="pageLimit" value="${empty pl?'5':pl }" />
					<div class="clear"></div>
				</form>
				<div class="clear"></div>
			</div>
			
		</div>
		
<script type="text/javascript" src="/xshop/web/common/layui/layui.all.js"></script>
<script type="text/javascript" src="/xshop/web/common/js/common.js"></script>
<script type="text/javascript">	
ajax("/goodscate/getCateUp.do" , {parentCode:'ALL'} , 'json' , showcate);
function showcate(data){
	var html = "";
	$.each(data , function(i,dom){
		var code = dom.code;
		var t1 = "<li><a href='javascript:fenlei(\""+code+"\",1)'>"+dom.name+"</a>"
		var t2 = "<div class='pop'><div class='left fl'  id='div_"+code+"'></div></div><div class='clear'></div>";
		html += t1+"</li>";
	});
	$("#fenlei").html(html);
}


</script>
		