package com.banggo.scheduler.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.banggo.united.client.mvc.JsonView;
import com.banggo.united.client.mvc.RedirectView;
import com.banggo.united.client.mvc.View;
import com.banggo.united.client.mvc.ViewResolver;

public class ViewResolverImpl implements ViewResolver {

	@Override
	public View resolveView(HttpServletRequest paramHttpServletRequest,
			HttpServletResponse paramHttpServletResponse) {
// if end with html return  RedirectView
		
		if (paramHttpServletRequest.getRequestURI().endsWith(".htm")){
			return new JsonView();
		}else{
			return new RedirectView();
		}
	}
}
