<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="sql"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fn"%> 
<%@ page isELIgnored="false"%> 
<title>商品分类信息</title>
</head>
<body>
 <fieldset class="layui-elem-field" style="margin: 20px;padding:15px;">
        <legend>分类信息--维护信息</legend>
    
    <form class="layui-form" method="post">

			<div class="layui-form-item">
				<span class="layui-form-label">上级分类</span>
				<div class="layui-input-inline">
					<select name="parentCode" lay-search>
					<c:forEach items="${cate}" var="item">
						<option value='${item.code}'>${item.name}</option>
					</c:forEach>
					</select>
				</div>
			</div>

			<div class="layui-form-item">
            <label class="layui-form-label">当前分类编号</label>
            <div class="layui-input-inline">
                <input type="text" name="code" lay-verify="required" placeholder="请输入编号" autocomplete="off"
                    class="layui-input">
            </div>
        </div>
       
        <div class="layui-form-item">
            <label class="layui-form-label">分类名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" placeholder="请输入商品名" autocomplete="off"
                    class="layui-input">
            </div>
        </div>
        

		<div class="layui-form-item">
			<span class="layui-form-label">分类描述</span>
			<div class="layui-input-inline">
				 <input type="text" name="descr" placeholder="请输入商品信息" autocomplete="off"
                    class="layui-input">
			</div>
		</div>			
        
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-inline">
                <input type="button" class="layui-btn" lay-submit lay-filter="add" value="确定" />
                <input type="button" class="layui-btn" onclick="closeThis()" value="取消" />
            </div>
        </div>
        <input type="hidden" name="type" value="${model.code}"  />
    </form>
    </fieldset>
    <script type="text/javascript">

//	Ajax加载下拉框    
//     ajax("/goodscate/selectcate.do",'',"json",function(data){
//     	var html = '';
//     	$.each(data,function(i,d){
//     		html+=laytpl($('#opt').html()).render(d);
//     	})
//     	$("select[name='parentCode']").html(html);
//     	form.render()
//     });
    
    init();
    function  init() {
    	var code = $("input[name='type']").val();
		if(code != ''){
			$("input[name='code']").val("${model.code}");
			$("input[name='code']").prop("readonly",true);
			$("input[name='name']").val("${model.name}");
			$("input[name='descr']").val("${model.descr}");
			$("select[name='parentCode']").val("${model.parentCode}");
			if("${model.parentCode}" == "AAA" || "${model.parentCode}" == "ALL"){
				$("select[name='parentCode']").prop("disabled",true);
			}
		}
	}
    
    form.render()
    
    formSubmit('/goodscate/addupdsave.do', 'submit(add)', 'text', function(data) {
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
    <script type="text/html" id="opt" >
    	<option value='{{d.code}}'>{{d.name}}</option>
    </script>
</body>
</html>