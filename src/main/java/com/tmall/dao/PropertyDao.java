package com.tmall.dao;

import com.tmall.domain.Category;
import com.tmall.domain.Property;

import java.util.List;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:44
 * Versions:1.0.0
 * Description:
 */
public interface PropertyDao {
    List<Property> listProperty(Category category);

    int addProperty(Property property);

    int deleteProperty(Property property);

    Property queryProperty(Property property);

    int updateProperty(Property property);
}
