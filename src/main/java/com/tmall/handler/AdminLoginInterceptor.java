package com.tmall.handler;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:58
 * Versions:1.0.0
 * Description:登录拦截器，禁止非法访问需要登录才能访问的页面
 */
public class AdminLoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        /*这里写判断是否是合法登录用户*/
        if(request.getSession().getAttribute("adminUser") == null){
            if(request.getRequestURI().indexOf("admin/user/login") != -1){
                return true;
            }else if(request.getRequestURI().indexOf("admin/register") != -1){
                return true;
            }else if(request.getRequestURI().indexOf("admin/user/add") != -1){
                return true;
            }else if(request.getRequestURI().indexOf("admin/loginPage") != -1){
                return true;
            }else if(request.getRequestURI().indexOf("admin/adminUser/checkKey") != -1){
                return true;
            }else if(request.getRequestURI().indexOf("admin/name/check") != -1){
                return true;
            }else{
                request.getRequestDispatcher("/admin/loginPage").forward(request, response);
                return false;
            }
        }
        return true;
    }
}
