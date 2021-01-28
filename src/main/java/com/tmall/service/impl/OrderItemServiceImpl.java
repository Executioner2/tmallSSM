package com.tmall.service.impl;

import com.tmall.dao.OrderItemDao;
import com.tmall.domain.OrderItem;
import com.tmall.domain.User;
import com.tmall.service.OrderItemService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-20 12:19
 * Versions:1.0.0
 * Description:
 */
@Service
public class OrderItemServiceImpl implements OrderItemService {
    @Resource
    private OrderItemDao orderItemDao;

    @Override
    @Transactional
    public boolean joinShopping(OrderItem orderItem) {
        boolean flag;
        Integer result = orderItemDao.checkRepetition(orderItem.getUser().getId(), orderItem.getProduct().getId());
        if(result == null){
            flag = orderItemDao.addOrderItem(orderItem) == 0 ? false : true;
        }else{
            orderItem.setNumber(orderItem.getNumber() + result);
            flag = orderItemDao.updateOrderItemNumber(orderItem) == 0 ? false : true;
        }
        return flag;
    }

    @Override
    public List<OrderItem> shoppingShow(User user) {
        return orderItemDao.listOrderItem(null, user.getId(), null);
    }

    @Override
    @Transactional
    public boolean updateOrderItemNumber(OrderItem orderItem) {
        return orderItemDao.updateOrderItemNumber(orderItem) == 0 ? false : true;
    }

    @Override
    @Transactional
    public boolean userOrderItemDelete(Integer id, Integer uid) {
        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        param.put("uid", uid);
        return orderItemDao.deleteOrderItem(param) == 0 ? false : true;
    }

    @Override
    public List<OrderItem> userSettlement(Integer[] oiids) {
        return orderItemDao.listOrderItem(null, null, oiids);
    }
}
