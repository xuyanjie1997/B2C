<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page isELIgnored="false"%> 
<title>商品详细信息</title>
</head>
<body>
<fieldset class="layui-elem-field" style="margin: 20px;padding:15px;">
        <legend>商品信息--添加信息</legend>
		<form class="layui-form" lay-filter="addupd" method="post">
			<div class="layui-form-item">
				<label class="layui-form-label">一级分类</label>
				<div class="layui-input-inline">
						<select name="FirstCate" lay-search lay-filter="FirstCate">
							<option value=""></option>
						<c:forEach items="${cate}" var="item">
							<option value='${item.code}'>${item.name}</option>
						</c:forEach>
						</select>
				</div>
				<label class="layui-form-label">二级分类</label>
				<div class="layui-input-inline">
						<select name="SecondCate" lay-search lay-filter="SecondCate">
						<option value=""></option>
						<c:forEach items="${cate2}" var="item2">
							<option value='${item2.code}'>${item2.name}</option>
						</c:forEach>
						</select>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">商品编号</label>
				<div class="layui-input-inline">
					<input type="text" name="code" placeholder="请输入商品编号"
						autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">商品名称</label>
				<div class="layui-input-inline">
					<input type="text" name="name" placeholder="请输入商品名称"
						autocomplete="off" class="layui-input">
				</div>
			</div>
				<div class="layui-form-item">
					<label class="layui-form-label">商品单价</label>
					<div class="layui-input-inline">
						<input type="text" name="price" placeholder="请输入商品单价"
							autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-label">商品库存</label>
					<div class="layui-input-inline">
						<input type="text" name="amount" placeholder="请输入商品库存"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			<div class="layui-form-item">
				<label class="layui-form-label">商品状态</label>
				<div class="layui-input-inline">
					<select name="state">
						<option value="上架">上架
						<option value="下架">下架
					</select>
				</div>
				<label class="layui-form-label">商品描述</label>
				<div class="layui-input-inline">
					  <input type="text" name="description" placeholder="请输入商品描述" 
					  autocomplete="off" class="layui-input" />
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"></label>
				<div class="layui-input-inline">
					<input type="button" class="layui-btn" lay-submit lay-filter="addupd" value="确定" />
					<input type="button" class="layui-btn" onclick="closeThis()" value="取消" />
				</div>
			</div>
			<input type="hidden" name="type" value="${model.id}" />
		</form>
	</fieldset>

  <script type="text/javascript">
  
  form.render()
  
  form.on('select(FirstCate)',function(seldata){
	  var a = seldata.value;
	  ajax("/descr/selecttwo.do",{fristcate:a},"json",function(data){
		  	var html = '';
		  	$.each(data,function(i,d){		
		  			html+=laytpl($('#opt1').html()).render(d); 
		  	})
		  	$("select[name='SecondCate']").html(html);
		  	form.render()
		  })
  });
  
    init();
    function  init() {
    	var id = $("input[name='type']").val();
		if(id != ''){
			$("input[name='code']").val("${model.code}");
			$("input[name='code']").prop("readonly",true);
			$("input[name='name']").val("${model.name}");
			$("input[name='price']").val("${model.price}");
			$("input[name='amount']").val("${model.amount}");
			$("input[name='description']").val("${model.description}");
			$("select[name='state']").val("${model.state}");
			$("select[name='FirstCate']").val("${ca1}");
			$("select[name='SecondCate']").val("${model.dicCode}");
			form.render();
		}
	}
        
    formSubmit('/descr/addupdsave.do', 'submit(addupd)', 'text', function(data) {
    	if (data == 0) {
            layer.msg('添加成功');
            closeThis(3000);
        } else if (data == 1) {
            layer.msg('商品已存在');
        } else if(data == 2){
            layer.msg('添加失败');
        }else if(data == 3){
        	layer.msg('修改成功');
        	closeThis(3000);
        }else{
        	layer.msg('操作失败');
        }
    });

    </script>
      <script type="text/html" id="opt1" >
    	<option value='{{d.code}}'>{{d.name}}</option>
   </script>

</body>
</html>