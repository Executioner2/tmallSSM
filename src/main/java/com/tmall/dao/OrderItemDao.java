package com.tmall.dao;

import com.tmall.domain.OrderItem;
import com.tmall.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:43
 * Versions:1.0.0
 * Description:
 */
public interface OrderItemDao {
    List<OrderItem> listOrderItem(@Param("oid") Integer oid, @Param("uid") Integer uid, @Param("oiids") Integer[] oiids);

    Integer getCountByUser(User user);

    Integer addOrderItem(OrderItem orderItem);

    Integer checkRepetition(@Param("uid") Integer uid, @Param("pid") Integer pid);

    Integer updateOrderItemNumber(OrderItem orderItem);

    Integer deleteOrderItem(Map<String, Object> map);

    //检查订单项合法性
    OrderItem checkOrderItemLegal(@Param("uid") Integer uid, @Param("id") Integer id);

    Integer updateOrderItemOid(@Param("oid") Integer oid, @Param("oiids") Integer[] oiids);
}
