package com.tmall.service;

import com.tmall.domain.Order;
import com.tmall.domain.User;

import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-15 9:41
 * Versions:1.0.0
 * Description:
 */
public interface OrderService {
    Map<String, Object> listOrder(Integer pageNum, Integer count, User user, String status);

    boolean orderDeliver(Order order);

    Map<String, Object> orderAdd(Order order, Integer[] oiids, User user);

    Order userOrderPayPage(Order order);

    boolean userOrderUpdateStatus(Order order);

    boolean userOrderDelete(Order order);

    Order queryOrder(Order order);
}
