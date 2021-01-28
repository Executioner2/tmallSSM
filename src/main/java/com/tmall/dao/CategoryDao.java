package com.tmall.dao;

import com.tmall.domain.Category;

import java.util.List;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:42
 * Versions:1.0.0
 * Description:
 */
public interface CategoryDao {
    List<Category> listCategory();

    int addCategory(Category category);  //插入数据并返回主键

    void editCategory(Category category);

    int deleteCategory(Category category);

    Category queryCategory(Category category);
}
