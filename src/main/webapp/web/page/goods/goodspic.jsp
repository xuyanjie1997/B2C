<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/web/header.jsp"%>
<title>商品信息</title>
</head>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px; padding: 15px">
  <legend>上传图片</legend>

<div class="layui-upload">
  <button type="button" class="layui-btn layui-btn-normal" id="testList">
 		<i class="layui-icon">&#xe67c;</i>选择图片</button> 
 	<button type="button" class="layui-btn" id="testListAction">开始上传</button>
  <div class="layui-upload-list">
    <table class="layui-table">
      <thead>
        <tr>
       		 <th>文件名</th>
       		 <th>大小</th>
       		 <th>状态</th>
			<th>操作</th>
      </tr></thead>
      <tbody id="demoList"></tbody>
    </table>
  </div>
</div> 

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px; padding: 15px">
		<legend>图片列表</legend>
		<div class="layui-upload-list">
			<table class="layui-table">
				<thead>
					<tr>
						<th >文件名</th>
						<th >图片文件</th>
						<th >操作</th>
					</tr>
				</thead>
				<tbody id="demoList2"></tbody>
			</table>
		</div>
	</fieldset>

</fieldset> 

<script type="text/javascript">

var upload = layui.upload;
var code = '<%=request.getParameter("code")%>' ;
//	多文件列表示例
var demoListView = $('#demoList')
,uploadListIns = upload.render({
  elem: '#testList'
  ,url: con.app + '/pic/upload.do'
  ,data: {code:code}
  ,accept: 'images'
  ,multiple: true
  ,auto: false
  ,bindAction: '#testListAction'
  ,choose: function(obj){   
    var files = this.files = obj.pushFile(); //	将每次选择的文件追加到文件队列
    //	读取本地文件
    obj.preview(function(index, file, result){
      var tr = $(['<tr id="upload-'+ index +'">'
        ,'<td>'+ file.name +'</td>'
        ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
        ,'<td>等待上传</td>'
        ,'<td>'
          ,'<button class="layui-btn demo-reload layui-hide">重传</button>'
          ,'<button class="layui-btn layui-btn-danger demo-delete">删除</button>'
        ,'</td>'
      ,'</tr>'].join(''));
      
      //	单个重传
      tr.find('.demo-reload').on('click', function(){
        obj.upload(index, file);
      });
      
      //	删除
      tr.find('.demo-delete').on('click', function(){
        delete files[index]; //	删除对应的文件
        tr.remove();
        uploadListIns.config.elem.next()[0].value = ''; //	清空 input file 值，以免删除后出现同名文件不可选
      });
      
      demoListView.append(tr);
    });
  }
  ,done: function(res, index, upload){
    if(res.code == 0){ //	上传成功
    init();
      var tr = demoListView.find('tr#upload-'+ index)
      ,tds = tr.children();
      tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
      tds.eq(3).html(''); //	清空操作
      return delete this.files[index]; //	删除文件队列已经上传成功的文件
    }
    this.error(index, upload);
  }
  ,error: function(index, upload){
    var tr = demoListView.find('tr#upload-'+ index)
    ,tds = tr.children();
    tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
    tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //	显示重传
  }
});

init();
function init(){
	ajax('/pic/getList.do', {code:code} , 'json', function(data){
		var html = "";
		$.each(data.list,function(i,dom){
			var id = dom.id;
			html += "<tr><td>"+dom.url+"</td><td>"
		    +'<img src="/image/'+ dom.url +'" alt="'+ dom.url +'" class="layui-upload-img">'
		    +"</td><td><input type='button' class='layui-btn' onclick='delPic("+dom.id+")' value='删除' />"
		    if(dom.type == "1"){
		    	html += "";
		    }else{
		    	html += "<input type='button' class='layui-btn' onclick='setMain("+dom.id+")' value='设为主图' />";
		    }
			html += "</td></tr>";
		})
		$("#demoList2").html(html);
    })
}

function delPic(id){
    openConfirm(function(index){
        ajax('/pic/del.do', {id:id} , 'text', function(data){
            if (data == "1") {
                layer.msg('删除成功');
                init();
            } else {
                layer.msg('删除失败');
            }
        })
    })
}

function setMain(id){
    ajax('/pic/setMain.do', {id:id} , 'text', function(data){
        if (data == "1") {
            layer.msg('当前图片设置成功');
            init();
        } else {
            layer.msg('遇到错误，设置失败');
        }
    })
}

</script>

</body>
</html>