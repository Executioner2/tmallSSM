package com.tmall.service.impl;

import com.tmall.dao.AdminUserDao;
import com.tmall.dao.OrderItemDao;
import com.tmall.dao.UserDao;
import com.tmall.domain.AdminUser;
import com.tmall.domain.User;
import com.tmall.service.UserService;
import com.tmall.utils.PageUtil;
import com.tmall.utils.RandUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-15 9:21
 * Versions:1.0.0
 * Description:
 */

@Service


public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;
    @Resource
    private AdminUserDao adminUserDao;
    @Resource
    private OrderItemDao orderItemDao;
    @Resource
    private PageUtil pageUtil;

    @Override
    public Map<String, Object> listUser(Integer pageNum, Integer count) {
        Map<String, Object> map = new HashMap<>();

        List<User> users = userDao.listUser();
        pageUtil.setUri("admin/user/list?");
        map.put("users", users);
        return map;
    }

    @Override
    @Transactional
    public boolean adminUserRegister(User user) {
        boolean flag = false;
        AdminUser adminUser = new AdminUser();
        userDao.userRegister(user);
        adminUser.setUser(user);
        adminUser.setKey(RandUtil.randKey(6));
        flag = adminUserDao.addAdminUser(adminUser) == 0 ? false : true;
        return flag;
    }

    @Override
    public User queryUserByRegisterKey(String key) {
        key = key.trim();
        return userDao.queryUserByAdminUser(key);
    }

    @Override
    public boolean adminUserLogin(User user) {
        boolean result = false;
        Integer id;
        user.setName(user.getName().trim());
        user.setPassword(user.getPassword().trim());
        id = userDao.adminUserLogin(user);
        if(id != null){
            user.setId(id);
            result = true;
        }
        return result;
    }

    @Override
    public boolean nameRepetitionCheck(User user) {
        user.setName(user.getName().trim());
        return userDao.queryUserByName(user) == 0 ? false : true;
    }

    @Override
    @Transactional
    public boolean userRegister(User user) {
        user.setName(user.getName().trim());
        user.setPassword(user.getPassword().trim());
        return userDao.userRegister(user) == 0 ? false : true;
    }

    @Override
    public boolean userLogin(User user) {
        boolean result = false;
        user.setName(user.getName().trim());
        user.setPassword(user.getPassword().trim());
        Integer uid = userDao.userLogin(user);
        if(uid != null){
            user.setId(uid);
            user.setOrderItemNumber(orderItemDao.getCountByUser(user));
            user.setOrderItemNumber(user.getOrderItemNumber() == null ? 0 : user.getOrderItemNumber());
            result = true;
        }
        return result;
    }

    @Override
    public void updateOrderItemNumber(User user) {
        user.setOrderItemNumber(orderItemDao.getCountByUser(user));
    }
}
