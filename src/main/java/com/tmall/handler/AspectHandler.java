package com.tmall.handler;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tmall.dao.OrderDao;
import com.tmall.utils.PageUtil;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-08 15:26
 * Versions:1.0.0
 * Description:
 */
@Aspect
public class AspectHandler {
    @Resource
    private PageUtil pageUtil;
    @Resource
    private OrderDao orderDao;

    /**
     * 设置分页的切面
     * @param pjp
     * @return
     * @throws Throwable
     */
    @Around("setProductListPointcut() || setCategoryListPointcut() || setPropertyListPointcut()" +
            "|| setUserListPointcut() || setOrderListPointcut() || setReviewListPointcut()")
    public Object listAspect(ProceedingJoinPoint pjp) throws Throwable {
        Map<String, Object> map;
        String[] strings = {"products", "categories", "properties", "users", "orders", "reviews"};

        Object[] objects = pjp.getArgs();
        PageHelper.clearPage();
        if(objects == null || objects.length == 0){
            PageHelper.offsetPage(0, 5);
            pageUtil.setCount(5);
        }else{
            objects[0] = (objects[0] == null ? 0 : objects[0]);
            PageHelper.offsetPage((int)objects[0],  (int)objects[1]);
            pageUtil.setCount((int)objects[1]);
        }

        map = (Map<String, Object>) pjp.proceed();
        List<Object> object = null;
        for (int i = 0; i < strings.length; i++) {
            if(map.get(strings[i]) != null){
                object = (List<Object>) map.get(strings[i]);
                break;
            }
        }

        PageInfo pageInfo = new PageInfo(object);
        pageInfo.setPageNum(pageInfo.getPageNum() == 0 ? 1 : pageInfo.getPageNum());
        pageUtil.setPageInfo(pageInfo);
        map.put("pageUtil", pageUtil);
        return map;
    }

    /**
     * 检查用户订单合法性
     * @return
     *//*
    @Around("execution(* *..OrderServiceImpl.userOrder*(..))")
    public Object userOrder(ProceedingJoinPoint pjp) throws Throwable {
        Object[] objects = pjp.getArgs();
        Map<String, Object> param = new HashMap<>();
        if (objects.length < 3){
            return null;
        }
        for (int i = 0; i < objects.length; i++) {
            if (objects[i] == null){
                return null;
            }
        }
        param.put("id", ((Order)objects[1]).getId());
        param.put("uid", ((User)objects[2]).getId());
        param.put("status",objects[0]);

        Integer result = orderDao.checkUserOrderLegal(param);
        if(result == null || result == 0){
            return null;
        }
        return pjp.proceed();
    }*/

    @Pointcut("execution(* *..ProductServiceImpl.list*(..))")
    private void setProductListPointcut(){}

    @Pointcut("execution(* *..CategoryServiceImpl.listCategory(..))")
    private void setCategoryListPointcut(){}

    @Pointcut("execution(* *..PropertyServiceImpl.list*(..))")
    private void setPropertyListPointcut(){}

    @Pointcut("execution(* *..OrderServiceImpl.list*(..))")
    private void setOrderListPointcut(){}

    @Pointcut("execution(* *..UserServiceImpl.list*(..))")
    private void setUserListPointcut(){}

    @Pointcut("execution(* *..ReviewServiceImpl.list*(..))")
    private void setReviewListPointcut(){}



}
