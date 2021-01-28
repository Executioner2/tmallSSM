package com.tmall.dao;

import com.tmall.domain.Order;
import com.tmall.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:42
 * Versions:1.0.0
 * Description:
 */
public interface OrderDao {
    List<Order> listOrder(@Param("user") User user, @Param("status") String status);

    int orderDeliver(Order order);

    int addOrder(Order order);  //创建订单

    Integer checkUserOrderLegal(Map<String, Object> param);  //检查用户订单合法性

    Order queryOrder(Order order); //订单查询

    int updateOrderStatus(@Param("order") Order order, @Param("date")Date date);

    int userOrderDelete(Order order); //用户订单删除
}
