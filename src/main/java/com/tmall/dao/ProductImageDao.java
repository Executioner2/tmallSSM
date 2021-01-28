package com.tmall.dao;

import com.tmall.domain.Product;
import com.tmall.domain.ProductImage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:44
 * Versions:1.0.0
 * Description:
 */
public interface ProductImageDao {
    int deleteProductImageByProduct(List<Product> products);

    List<ProductImage> listProductImageByType(@Param("type") String type, @Param("pid") Integer pid);

    int addProductImage(ProductImage productImage);

    int deleteProductImage(ProductImage productImage);

    ProductImage queryProductImage(ProductImage productImage);
}
