var form_list = {};
function start_submit()
{
	$("form[name^=submitbox]").each(function() {
		form_list[$(this).attr('name')] = {
			'form': $(this).get(0),
			'submited' : false,
			'pos': $(this).attr('item')
		};
	});
	$("#submit_res").html('<li>运单处理中, 请不要关闭浏览器...</li>');
	form_list.submitbox1.submited = true;
	form_list.submitbox1.form.submit();
}

function submit_next(pos)
{
	$("#submit_res").append('<li>运单' + pos + '处理完毕</li>');
	var name = 'submitbox' + (++pos);
	if (form_list[name]) {
		form_list[name].submited = true;
		form_list[name].form.submit();
	} else {
		$("#submit_res").append('<li>运单全部处理完毕</li>');
	}
	location = 'user.php?do=bill';
	return false;
}

(function($) {
	$(".mybox a.addnew").live('click', function() {
		var tr = $(this).parent().parent().clone();
		tr.find("input").val('');
		$(this).removeClass().addClass('itemremove').text('删除');
		tr.appendTo($(this).parent().parent().parent());		
	});

	$(".mybox a.itemremove").live('click', function() {
		$(this).parent().parent().remove();
	});

	$("#add_bill").click(function() {
		var flag = true;
		$("input").each(function() {
			var val = $.trim($(this).val()),
				name = $(this).attr('name');
			if (val == '' && name != 'FromCompany' && name != 'ToCompany') {
				flag = false;
				return;
			}
		});

		if (flag == false) {
			alert('请填写空白字段');
			return false;
		}
		$(this).hide();
		start_submit();
		return false;
	});

	// 展开
	$("#content>dl>dt").click(function() {
		var dd = $(this).next();
		if (dd.is(":visible")) {
			$(this).text($(this).text().replace('[-]', '[+]').replace('收起', '展开'));
			dd.slideUp();
		} else {
			$(this).text($(this).text().replace('[+]', '[-]').replace('展开', '收起'));
			dd.slideDown();
		}
	});

})(jQuery);