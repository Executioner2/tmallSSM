package com.tmall.service.impl;

import com.tmall.dao.ProductDao;
import com.tmall.dao.PropertyDao;
import com.tmall.dao.PropertyValueDao;
import com.tmall.domain.Category;
import com.tmall.domain.Product;
import com.tmall.domain.Property;
import com.tmall.domain.PropertyValue;
import com.tmall.service.PropertyValueService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-14 18:12
 * Versions:1.0.0
 * Description:
 */
@Service
public class PropertyValueServiceImpl implements PropertyValueService {
    @Resource
    private PropertyValueDao propertyValueDao;
    @Resource
    private ProductDao productDao;
    @Resource
    private PropertyDao propertyDao;


    @Override
    public Map<String, Object> listPropertyValue(Product product) {
        Map<String, Object> map = new HashMap<>();

        product = productDao.queryProduct(product);
        List<PropertyValue> propertyValues = propertyValueDao.queryPropertyValueByProduct(product);
        map.put("product", product);
        map.put("propertyValues", propertyValues);
        return map;
    }

    @Override
    @Transactional
    public void editPropertyValue(PropertyValue propertyValue) {

    }

    @Override
    @Transactional
    public void addPropertyValue(Product product, Integer cid) {
        Category category = new Category();
        category.setId(cid);

        List<Property> properties = propertyDao.listProperty(category);
        Integer total = propertyValueDao.getPropertyValueByProductTotal(product);
        if(total < properties.size()){
            for (int i = total; i < properties.size(); i++) {
                Integer ptid = properties.get(i).getId();
                propertyValueDao.addPropertyValue(product.getId(), ptid);
            }
        }
    }

    @Override
    @Transactional
    public boolean updatePropertyValue(PropertyValue propertyValue) {
        int result;
        propertyValue.setValue(propertyValue.getValue().trim());
        result = propertyValueDao.updatePropertyValue(propertyValue);
        return result == 0 ? false : true;
    }
}
