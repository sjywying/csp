$(function() {

			renderSubmitBtn();
			returnBtnFun();
			submit();

		});
/*这里没有list页面，使用edit页面代替,这样可以重置页面的状态,避免一些复杂的处理*/
var listUrl = base + "/app_info.do?method=edit&appId="+ page.appId;
		
function returnBtnFun() {
	$("#returnBtn").click(function() {
				window.location.href =listUrl ;
			});
}

function renderSubmitBtn() {

	if ($("#hidden1").val() == "false")
		$("#submitBtn").val("添加");
}
function sendReq() {

	var url = base + "/app_info.do?method=add";
	var data = $("#form1").serialize();
	
	//alert(data);
	var successFun = function(data) {
		popInfo(data);

	};

	$.post(url, data, successFun, "json");
}

function popInfo(data) {
	// alert("popInfo");
	var res = data.result;
	var operate = data.operate;
	var resDesc, operateDesc;
	if (res == "1")
		resDesc = "成功";
	else
		resDesc = "失败";

	if (operate == "update")
		operateDesc = "更新";
	else
		operateDesc = "保存";

	// alert(content);
	// alert(TINY.box.show);
	var content = operateDesc + resDesc + "!";
	//指定秒数
	var n = 2;
	TINY.box.show(content, 0, 100, 35, 0, n);
	setTimeout(function(){
		window.location.href = listUrl;
	
	},1000 * n);	
}

function submit() {
	$("#submitBtn").click(function() {
				sendReq();

			});
}
