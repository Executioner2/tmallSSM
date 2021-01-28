package com.tmall.dao;

import com.tmall.domain.Product;

import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:43
 * Versions:1.0.0
 * Description:
 */
public interface ProductDao {

    int deleteProduct(Product product);

    List<Product> listProduct(Map<String, Object> map);

    int addProduct(Product product);

    Product queryProduct(Product product);

    int updateProduct(Product product);

    //更新商品库存
    Integer updateProductStock(Map<String, Object> map);
}
