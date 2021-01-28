package com.tmall.service;

import com.tmall.domain.OrderItem;
import com.tmall.domain.User;

import java.util.List;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-20 12:18
 * Versions:1.0.0
 * Description:
 */
public interface OrderItemService {
    //加入购物车
    boolean joinShopping(OrderItem orderItem);

    List<OrderItem> shoppingShow(User user);

    boolean updateOrderItemNumber(OrderItem orderItem);

    boolean userOrderItemDelete(Integer id, Integer uid);

    List<OrderItem> userSettlement(Integer[] oiids);
}
