package com.tmall.service;

import com.tmall.domain.Category;
import com.tmall.domain.Product;
import com.tmall.utils.PageUtil;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-08 17:42
 * Versions:1.0.0
 * Description:
 */
public interface ProductService {
    Map<String, Object> listProduct(Integer pageNum, Integer count, Category category);

    Map<String, Object> listProductByLikeQuery(Integer pageNum, Integer count, String keyword);

    Map<String, Object> listProductSort(Integer pageNum, Integer count, Category category, String sort, Boolean sortType, Integer priceLeft, Integer priceRight);

    PageUtil addProduct(Product product);

    Product queryProduct(Product product);

    boolean deleteProduct(Product product);

    PageUtil updateProduct(Product product);

    //查询产品详情
    Map<String, Object> queryProductDetail(Integer pageNum, Integer count, Product product);
}
