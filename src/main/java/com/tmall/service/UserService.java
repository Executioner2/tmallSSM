package com.tmall.service;

import com.tmall.domain.User;

import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-15 9:20
 * Versions:1.0.0
 * Description:
 */
public interface UserService {
    Map<String, Object> listUser(Integer pageNum, Integer count);

    boolean adminUserRegister(User user);

    User queryUserByRegisterKey(String key);

    boolean adminUserLogin(User user);

    boolean nameRepetitionCheck(User user);

    boolean userRegister(User user);

    boolean userLogin(User user);

    void updateOrderItemNumber(User user);
}
