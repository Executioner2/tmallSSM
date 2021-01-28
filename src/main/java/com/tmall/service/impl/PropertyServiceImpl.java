package com.tmall.service.impl;

import com.tmall.dao.PropertyDao;
import com.tmall.dao.PropertyValueDao;
import com.tmall.domain.Category;
import com.tmall.domain.Property;
import com.tmall.service.PropertyService;
import com.tmall.utils.PageUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-08 14:40
 * Versions:1.0.0
 * Description:
 */

@Service
public class PropertyServiceImpl implements PropertyService {
    @Resource
    private PropertyDao propertyDao;
    @Resource
    private PropertyValueDao propertyValueDao;
    @Resource
    private PageUtil pageUtil;

    @Override
    public Map<String, Object> listProperty(Integer pageNum, Integer count, Category category) {
        Map<String, Object> map = new HashMap<>();

        List<Property> properties = propertyDao.listProperty(category);
        pageUtil.setUri("admin/property/list?id="+category.getId()+"&");
        map.put("properties", properties);
        return map;
    }

    @Override
    @Transactional
    public PageUtil addProperty(Property property) {
        property.setName(property.getName().trim());
        propertyDao.addProperty(property);
        return pageUtil;
    }

    @Override
    @Transactional
    public boolean deleteProperty(Property property) {
        int i = 0;
        List<Property> properties = new ArrayList<>();
        properties.add(property);
        propertyValueDao.deletePropertyValueByProperty(properties);
        i = propertyDao.deleteProperty(property);
        return i == 0 ? false : true;
    }

    @Override
    public Property queryProperty(Property property) {
        return propertyDao.queryProperty(property);
    }

    @Override
    @Transactional
    public PageUtil updateProperty(Property property) {
        property.setName(property.getName().trim());
        propertyDao.updateProperty(property);
        return pageUtil;
    }
}
