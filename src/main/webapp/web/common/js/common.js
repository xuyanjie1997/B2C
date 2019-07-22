var con = {
	app : "/xshop",
	jsp_login : "/web/login.jsp",
	jsp_reg : "/web/reg.jsp",
	logout : "/user/logout.do",
}; 

var form = layui.form;
var $ = layui.jquery;
var layer = layui.layer;
var element = layui.element;
var laypage = layui.laypage;
var laytpl = layui.laytpl;
var laydate = layui.laydate


function toJsp(url) {
	location.href = con.app + url;
}

function goJspLogin() {
	toJsp(con.jsp_login);
}
function goJspReg() {
	toJsp(con.jsp_reg)
}
function openConfirm(func, title) {
	layer.confirm(title ? title : "确定进行吗?", {
		icon : 3,
		title : '提示'
	}, func);
}

function formSubmit(url, submit, dataType, func) {
	form.on(submit, function(data) {
		ajax(url, data.field, dataType, func);
	});
}
function ajax(url, field, dataType, func) {
	$.ajax({
		url : con.app + url,
		data : field,
		dataType : dataType,
		type : 'post',
		success : func
	});
}
function openLayer(url, end) {
	layer.open({
		type : 2,
		area : [ '800px', '450px' ],
		fixed : false, // 不固定
		maxmin : true,
		end : end,
		content : con.app + url
	});
}
function closeThis(time) {
	setTimeout(function() {// 先得到当前iframe层的索引
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}, time ? time : 200)
}
function setPageInfo(elem, count, curr, limit, jump) {
	laypage
			.render({
				elem : elem,// id
				count : count,// 数据总数
				curr : curr,// 当前页
				limit : limit,// 每页显示的条数
				limits : [ 5, 10, 15, 20, 25 ],// 	每页条数的选择项
				layout : [ 'count', 'prev', 'page', 'next', 'limit', 'refresh',
						'skip' ],//	底部分页布局格式
				jump : jump
			});
}
function getlaytpl(sel, data) {
	return laytpl($(sel).html()).render(data);
}
