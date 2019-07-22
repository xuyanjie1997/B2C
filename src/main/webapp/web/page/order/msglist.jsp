<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/web/header.jsp"%>
<title>订单详细信息</title>
</head>
<body>
<div class="layui-collapse">
  <div class="layui-colla-item">
    <h2 class="layui-colla-title">订单详细信息-查询条件</h2>
    <div class="layui-colla-content layui-show">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px; padding: 5px">
		<legend>订单详细信息-查询条件</legend>
		<form class="layui-form">
			<div class="layui-form-item">
				<label class="layui-form-label">编号</label>
				<div class="layui-input-inline">
					<input type="text" name="code" placeholder="请输入编号" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">用户名</label>
				<div class="layui-input-inline">
					<input type="text" name="usercode" placeholder="请输入名称" autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">地址</label>
				<div class="layui-input-inline">
					<input type="text" name="address" placeholder="请输入地址" autocomplete="off" class="layui-input">
				</div>
			<div class="layui-form-item">
				<label class="layui-form-label">状态</label>
				<div class="layui-input-inline">
					<select  name="state" lay-search>
						<option value=''></option>
						<option value='1'>未发货(1)</option>
						<option value='2'>已发货(2)</option>
						<option value='3'>已收货(3)</option>
					</select>
				</div>
			</div>
				<div class="layui-input-inline">
				<span> 
						<input type="button" class="layui-btn" lay-submit lay-filter="search" value="查询" /> 
						<input type="reset"	class="layui-btn" value="重置" />
				</span>
			</div></div>
			<input type="hidden" name="pageIndex" value="1" />
			<input type="hidden" name="pageLimit" value="10" />
		</form>
	</fieldset>
	</div></div></div>
	<div class="layui-form">
		<table class="layui-table">
			<colgroup>
				<col width="5%"><col width="5%"><col width="10%">
				<col width="10%"><col width="5%"><col width="25%">
				<col width="5%"><col width="5%">
			</colgroup>
			<thead>
				<tr>
					<th>序号</th><th>编号</th><th>用户编号</th>
					<th>时间</th><th>收件人</th><th>地址</th>
					<th>联系电话</th><th>状态</th><th>操作</th>
				</tr>
			</thead>
			<tbody id="gc_tbody3"></tbody>
		</table>
		<div id="pageInfoGC" style="text-align: right;padding-right: 30px"></div>
	</div>
	
	<script type="text/javascript" src="<%=path%>/layui/layui.all.js"></script>
<script type="text/javascript">

formSubmit('/ordermsg/selectList.do','submit(search)','json',function(data) {// console.log(data)
    var curr = $("input[name='pageIndex']").val();
    var limit = $("input[name='pageLimit']").val();
    setPageInfo('pageInfoGC',data.count,curr,limit
    		,function(obj, first){
        $("input[name='pageIndex']").val(obj.curr);
        $("input[name='pageLimit']").val(obj.limit);
        if(!first){refresh();}//首次不执行
    })
    var html = "" ;//	加载表格中数据
    $.each(data.list,function(i, dom) {
    	var code = dom.code?dom.code:'';
        var usercode = dom.usercode?dom.usercode:'';
        var time = dom.time?dom.time:'';
        var attn = dom.attn?dom.attn:'';
        var address = dom.address?dom.address:'';
        var tel = dom.tel?dom.tel:'';
        var state = dom.state?dom.state:'';
        var d={i:(i+1+(curr-1)*limit),usercode:usercode,code:code,time:time,attn:attn,address:address,tel:tel,state:state};
        html += getlaytpl('#tradd3',d);
    });
    $("#gc_tbody3").html(html);
});

refresh();
function refresh(){
    $("input[value='查询']").click();
}

function openUpd(code){
	openLayer('/web/page/order/msgupd.jsp?code='+code,refresh)
}

function openGoods(code){
	openLayer('/web/page/order/ordergoods.jsp?code='+code,refresh)
}

</script>
<script id="tradd3" type="text/html">
<tr>
<td>{{ d.i }}</td><td>{{ d.code }}</td><td>{{ d.usercode }}</td>
<td>{{ d.time }}</td><td>{{ d.attn }}</td><td>{{ d.address }}</td>
<td>{{ d.tel }}</td><td>{{ d.state }}</td>
<td>
    <input type='button' value='修改' class='layui-btn' 
           onclick='openUpd("{{ d.code }}")'/>&nbsp;
			<input type='button' value='订单商品' class='layui-btn' 
           onclick='openGoods("{{ d.code }}")'/>
</td>
</tr>
</script>
	
</body>
</html>