package com.zkty.modules.loaded.jsapi;


import androidx.annotation.Nullable;

import com.zkty.modules.dsbridge.CompletionHandler;


public class __xengine__module_yjzdbill extends xengine__module_yjzdbill {

	@Override
	public void _noArgNoRet(CompletionHandler<Nullable> handler) {
		System.out.println("_noArgNoRet");
		handler.complete();
	}

	@Override
	public void _noArgRetPrimitive(CompletionHandler<String> handler) {
		System.out.println("_noArgRetPrimitive");
		handler.complete("hello");
	}

	@Override
	public void _noArgRetSheetDTO(CompletionHandler<SheetDTO> handler) {
		System.out.println("_noArgRetSheetDTO");
		SheetDTO dto = new SheetDTO();
		dto.title="Hello";
		handler.complete(dto);
	}

	@Override
	public void _haveArgNoRet(SheetDTO dto, CompletionHandler<Nullable> handler) {
		System.out.println( dto);
		handler.complete();
	}

	@Override
	public void _haveArgRetPrimitive(SheetDTO dto, CompletionHandler<String> handler) {
		System.out.println( dto);
		handler.complete("hello world.");
	}

	@Override
	public void _haveArgRetSheetDTO(SheetDTO dto,CompletionHandler<SheetDTO> handler ) {
		System.out.println( dto);
		SheetDTO dd = new SheetDTO();
		dd.title="hello";
		dd.content="content";
		handler.complete(dd);
	}

	@Override
	public void _showActionSheet(SheetDTO dto, CompletionHandler<Nullable> handler) {
		System.out.println( dto);
		handler.complete();
	}
}
