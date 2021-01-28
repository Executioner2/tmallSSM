package com.tmall.dao;

import com.tmall.domain.User;

import java.util.List;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:45
 * Versions:1.0.0
 * Description:
 */
public interface UserDao {
    List<User> listUser();

    int queryUserByName(User user);

    User queryUserByAdminUser(String key);

    Integer adminUserLogin(User user);

    int userRegister(User user);

    Integer userLogin(User user);
}
