package com.tmall.handler;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-18 9:15
 * Versions:1.0.0
 * Description:
 */
public class UserLoginInterceptor implements HandlerInterceptor {
    @Resource
    private ModelAndView mv;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if(request.getSession(false) == null || request.getSession(false).getAttribute("user") == null){
            request.getRequestDispatcher("/loginPage").forward(request, response);
            return false;
        }
        if(request.getRequestURI().indexOf("/user/evaluate/success") == -1){
            mv.clear();
        }
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
        //清除确认支付后的session
        if(request.getRequestURI().indexOf("/user/affirmPay") != -1){
            request.getSession(false).removeAttribute("address");
            request.getSession(false).removeAttribute("totalPrice");
        }
    }
}
