$(function() {

			renderSubmitBtn();
			returnBtnFun();
			submit();

		});
/*����û��listҳ�棬ʹ��editҳ�����,������������ҳ���״̬,����һЩ���ӵĴ���*/
var listUrl = base + "/app_info.do?method=edit&appId="+ page.appId;
		
function returnBtnFun() {
	$("#returnBtn").click(function() {
				window.location.href =listUrl ;
			});
}

function renderSubmitBtn() {

	if ($("#hidden1").val() == "false")
		$("#submitBtn").val("����");
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
		resDesc = "�ɹ�";
	else
		resDesc = "ʧ��";

	if (operate == "update")
		operateDesc = "����";
	else
		operateDesc = "����";

	// alert(content);
	// alert(TINY.box.show);
	var content = operateDesc + resDesc + "!";
	//ָ������
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