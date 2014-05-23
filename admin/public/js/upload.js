/**
 * 文件上传控制JS
 * 
 * @author suning <suning@corp.the9.com>
 * 
 * $Id: upload.js 225 2009-09-16 09:29:47Z suning $
 */

// 全局变量
var cmsswf;
var upload_cache;
var imgpath = '/public/images/';
var isUpload = false;
var ppids = [];
var ppids_err = 0;

/**
 * 文件队列
 * @param {Object} o
 */
function fileQueued(o)
{
	var size = forDight(o.size / 1024, 2) + 'KB';
	o.name = o.name.replace(/&/g, "&amp;");
	var html = '<li id="' + o.id + '">' + o.name + ' ['+size+'] <a href="javascript://" class="red" onclick="remove(this, \'' + o.id + '\')">移除</a></li>';
	$("#uptable").append(html);
	$("#upbtn").removeAttr('disabled');
}

/**
 * 上传进度
 * @param {Object} file
 * @param {Object} bytesComplete
 * @param {Object} bytesTotal
 */
function uploadProgress(file, bytesComplete, bytesTotal)
{	
	
}

/**
 * 上传成功
 * @param {Object} file
 * @param {Object} server
 */
function uploadSuccess(file, server)
{	
	$("#" + file.id + " a").css('color', 'green').text('上传成功');
	var fcount = cmsswf.getStats();
	if (fcount.files_queued > 0) {
		cmsswf.startUpload();
	} else {
		location.reload();
	}
}

/**
 * 删除上传文件
 * @param {Object} o
 * @param {Object} id
 */
function remove(o, id)
{
	cmsswf.cancelUpload(id);
	$('#' + id).remove();
	var fcount = cmsswf.getStats();
	if (fcount.files_queued < 1) {
		$("#upbtn").attr('disabled', 'disabled');
	}
}

/**
 * 转换数字格式
 * @param {Object} num
 * @param {Object} len
 */
function forDight(num, len)  
{  
   return Math.round(num * Math.pow(10, len)) / Math.pow(10, len);
}

/**
 * 初始化Flash
 */
window.onload = function() 
{
	var settings = {
		flash_url : "/public/swf/swfupload.swf",
		upload_url: "/plugins/at/html.php?do=Upload",
		file_size_limit : "5 MB",
		post_params: {"PHPSESSID": PHPSESSID},
		file_types : "*",
		file_types_description : "所有文件",
		file_upload_limit : 100,
		file_queue_limit : 0,
		debug: false,
		button_image_url: "/public/images/upload_button.png",
		button_width: "67",
		button_height: "24",
		button_placeholder_id: "spanButtonPlaceHolder",
		button_text: '<span class="theFont">选择文件</span>',
		button_text_style: ".theFont { font-size: 12;color: #9E4200; }",
		button_text_left_padding: 8,
		button_text_top_padding: 3,		
		file_queued_handler : fileQueued,
		file_queue_error_handler : fileQueueError,
		file_dialog_complete_handler : fileDialogComplete,
		upload_start_handler : uploadStart,
		upload_progress_handler : uploadProgress,
		upload_success_handler : uploadSuccess,
		upload_complete_handler : uploadComplete
	}
	cmsswf = new SWFUpload(settings);
}
function fileQueueError() {}
function uploadStart(file) {}
function fileDialogComplete(numFilesSelected, numFilesQueued) {}
function uploadComplete(file) {}

$("#upbtn").click(function() {
	if ($(this).is(':disabled')) {
		return false;
	}
	var fcount = cmsswf.getStats();
	if (fcount.files_queued < 1) {
		return false;
	}
	$("#uptable").find("a").removeAttr('onclick');
	cmsswf.addPostParam('base_url', $("#base_url").val());
	$(this).val('上传中...').attr('disabled', 'disabled');
	cmsswf.startUpload();
});