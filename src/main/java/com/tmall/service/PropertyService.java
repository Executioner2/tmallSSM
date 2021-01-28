package com.tmall.service;

import com.tmall.domain.Category;
import com.tmall.domain.Property;
import com.tmall.utils.PageUtil;

import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-08 14:39
 * Versions:1.0.0
 * Description:
 */
public interface PropertyService {
    Map<String, Object> listProperty(Integer pageNum, Integer count,Category category);

    PageUtil addProperty(Property property);

    boolean deleteProperty(Property property);

    Property queryProperty(Property property);

    PageUtil updateProperty(Property property);
}
