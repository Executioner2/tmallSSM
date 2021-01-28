package com.tmall.dao;


import com.tmall.domain.Product;
import com.tmall.domain.Property;
import com.tmall.domain.PropertyValue;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:45
 * Versions:1.0.0
 * Description:
 */
public interface PropertyValueDao {
    int deletePropertyValueByProduct(Product product);

    int deletePropertyValueByProperty(List<Property> properties);

    List<PropertyValue> queryPropertyValueByProduct(Product product);

    int addPropertyValue(@Param("pid") int pid, @Param("ptid") int ptid);

    int updatePropertyValue(PropertyValue propertyValue);

    //获取对应产品的属性值总数
    int getPropertyValueByProductTotal(Product product);
}
