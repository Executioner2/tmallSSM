package com.tmall.service;

import com.tmall.domain.Product;
import com.tmall.domain.ProductImage;
import com.tmall.utils.UploadFileImage;

import java.io.IOException;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-14 20:25
 * Versions:1.0.0
 * Description:
 */
public interface ProductImageService {
    Map<String, Object> listProductImage(Product product);

    void addProductImage(ProductImage productImage, UploadFileImage images) throws IOException;

    boolean deleteProductImage(ProductImage productImage);
}
