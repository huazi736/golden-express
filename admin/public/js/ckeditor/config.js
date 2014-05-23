/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.language = 'zh-cn';
	config.skin = 'kama';
	config.filebrowserBrowseUrl = url_js + 'ckfinder/ckfinder.html',
	config.filebrowserImageBrowseUrl = url_js + 'ckfinder/ckfinder.html?Type=Images',
	config.filebrowserFlashBrowseUrl = url_js + 'ckfinder/ckfinder.html?Type=Flash',
	config.filebrowserUploadUrl = url_js + 'ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
	config.filebrowserImageUploadUrl = url_js + 'ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Images',
	config.filebrowserFlashUploadUrl = url_js + 'ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Flash'
};
