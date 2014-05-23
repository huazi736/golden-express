(function($) {
	var now = 1;
	$("#add_box").click(function() {
		now++;
		var box = $("#mybox > div.ship_box:eq(0)").clone();
		$("#mybox a.close").hide();
		box.find("a.close").show();
		box.find("input").each(function() {
			var name = $(this).attr('name').replace('1', now);
			$(this).attr('name', name);
		});
		box.find("tr.start").nextAll().remove();
		box.find("input").not("[type=radio]").not("[type=hidden]").val('');
		box.find("input[name^=weight]:eq(0)").val('0');
		box.find("input[name^=bulk]:eq(0)").val('0');
		box.find("span.count").text(now);
		box.find("a.itemremove").removeClass().addClass('addnew').text('新增');
		box.appendTo("#mybox");
		$("#mybox b._boxcount").text(now);
	});

	$("#mybox a.close").live('click', function() {
		if ($("#mybox > div.ship_box").size() > 2) {
			$("#mybox > div.ship_box:last").prev().find("a.close").show();
		}
		$(this).parent().parent().remove();
		now--;
		$("#mybox b._boxcount").text(now);
	});

	$("#mybox a.addnew").live('click', function() {
		var tr = $(this).parent().parent().clone();
		tr.find("input").val('');
		$(this).removeClass().addClass('itemremove').text('删除');
		tr.appendTo($(this).parent().parent().parent());		
	});

	$("#mybox a.itemremove").live('click', function() {
		$(this).parent().parent().remove();
	});
	
	$("#submit_box").click(function() {
		if ($("select").val() == '0') {
			alert('请选择仓库');
			return false;
		}
		var flag = true;
		$("input").each(function() {
			var val = $.trim($(this).val());
			if (val == '') {
				flag = false;
				return;
			}
		});

		if (flag == false) {
			alert('请填写空白字段');
			return false;
		}
		document.submitbox.submit();
		return false;
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
		$(this).attr('disabled', 'disabled');
		document.submitbox.submit();
		return false;
	});

})(jQuery);