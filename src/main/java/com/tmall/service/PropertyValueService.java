package com.tmall.service;

import com.tmall.domain.Product;
import com.tmall.domain.PropertyValue;

import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-14 18:12
 * Versions:1.0.0
 * Description:
 */
public interface PropertyValueService {
    Map<String, Object> listPropertyValue(Product product);

    void editPropertyValue(PropertyValue propertyValue);

    void addPropertyValue(Product product, Integer cid);

    boolean updatePropertyValue(PropertyValue propertyValue);
}
