package com.tmall.service.impl;

import com.tmall.dao.OrderDao;
import com.tmall.dao.OrderItemDao;
import com.tmall.dao.ProductDao;
import com.tmall.domain.Order;
import com.tmall.domain.OrderItem;
import com.tmall.domain.User;
import com.tmall.service.OrderService;
import com.tmall.utils.PageUtil;
import com.tmall.utils.RandUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-15 9:41
 * Versions:1.0.0
 * Description:
 */

@Service
public class OrderServiceImpl implements OrderService {
    @Resource
    private PageUtil pageUtil;
    @Resource
    private OrderDao orderDao;
    @Resource
    private ProductDao productDao;
    @Resource
    private OrderItemDao orderItemDao;

    @Override
    public Map<String, Object> listOrder(Integer pageNum, Integer count, User user, String status) {
        float totalMoney = 0;
        int totalNumber = 0;
        Map<String, Object> map = new HashMap<>();
        List<Order> orders = orderDao.listOrder(user, status);
        if(user != null){
            pageUtil.setUri("user/order/list?id="+user.getId()+"&status="+status+"&");
        }else{
            pageUtil.setUri("admin/order/list?");
        }
        for (int i = 0; i < orders.size(); i++, totalMoney = totalNumber = 0) {
            for (int j = 0; j < orders.get(i).getOrderItems().size(); j++) {
                int number = orders.get(i).getOrderItems().get(j).getNumber();
                totalMoney += orders.get(i).getOrderItems().get(j).getProduct().getPromotePrice() * number;
                totalNumber += number;
            }
            orders.get(i).setTotalMoney(totalMoney);
            orders.get(i).setTotalNumber(totalNumber);
        }
        map.put("orders", orders);
        return map;
    }

    @Override
    @Transactional
    public boolean orderDeliver(Order order) {
        order.setDeliveryDate(new Date());
        return orderDao.orderDeliver(order) == 0 ? false : true;
    }

    @Override
    @Transactional
    public Map<String, Object> orderAdd(Order order, Integer[] oiids, User user) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> param = new HashMap<>();
        Float totalPrice = 0f; //总金额

        //1、检查该用户购物车中是否前端发过来的购物车单号
        for (int i = 0; i < oiids.length; i++) {
            OrderItem orderItem = orderItemDao.checkOrderItemLegal(user.getId(), oiids[i]);
            if (orderItem == null){  //如果为真则订单项不合法
                return null;
            }
            if(orderItem.getNumber() > orderItem.getProduct().getStock()){  //如果为真则库存不足
                return null;
            }
            totalPrice += orderItem.getNumber() * orderItem.getProduct().getPromotePrice(); //计算总金额

            //2、减少商品库存
            param.put("pid", orderItem.getProduct().getId());
            param.put("number", orderItem.getNumber());
            productDao.updateProductStock(param);
        }

        //3、生成订单号、获取创建时间、更新状态、关联用户
        order.setOrderCode(RandUtil.createOrderCode());
        order.setCreateDate(new Date());
        order.setStatus("waitPay");
        order.setUser(user);

        //4、添加订单
        orderDao.addOrder(order);

        //5、订单项更新oid
        orderItemDao.updateOrderItemOid(order.getId(), oiids);

        map.put("totalPrice", totalPrice);
        map.put("id", order.getId());
        return map;
    }

    @Override
    @Transactional
    public Order userOrderPayPage(Order order) {
        Float totalPrice = 0f;
        order = orderDao.queryOrder(order);

        for (int i = 0; i < order.getOrderItems().size(); i++) {
            OrderItem orderItem = order.getOrderItems().get(i);
            totalPrice += orderItem.getProduct().getPromotePrice() * orderItem.getNumber();
        }

        order.setTotalMoney(totalPrice);
        return order;
    }

    @Override
    @Transactional
    public boolean userOrderUpdateStatus(Order order) {
        return orderDao.updateOrderStatus(order, new Date()) == 0 ? false : true;
    }

    @Override
    @Transactional
    public boolean userOrderDelete(Order order) {
        Map<String, Object> param = new HashMap<>();
        param.put("oid", order.getId());
        param.put("uid", order.getUser().getId());
        orderItemDao.deleteOrderItem(param);
        return orderDao.userOrderDelete(order) == 0 ? false : true;
    }

    @Override
    public Order queryOrder(Order order) {
        Float totalPrice = 0f;
        order = orderDao.queryOrder(order);
        if(order == null){
            return null;
        }
        for (int j = 0; j < order.getOrderItems().size(); j++) {
            int number = order.getOrderItems().get(j).getNumber();
            totalPrice += order.getOrderItems().get(j).getProduct().getPromotePrice() * number;
        }
        order.setTotalMoney(totalPrice);
        return order;
    }
}
