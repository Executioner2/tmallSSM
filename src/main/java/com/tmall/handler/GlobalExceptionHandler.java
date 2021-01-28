package com.tmall.handler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:53
 * Versions:1.0.0
 * Description: 全局异常处理类
 */
@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler
    public ModelAndView doOtherException(Exception e){
        ModelAndView mv = new ModelAndView();
        mv.addObject("ex",e);
        mv.setViewName("globalException");
        return mv;
    }
}
