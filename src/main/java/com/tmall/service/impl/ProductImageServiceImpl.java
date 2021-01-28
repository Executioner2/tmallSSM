package com.tmall.service.impl;

import com.tmall.dao.ProductDao;
import com.tmall.dao.ProductImageDao;
import com.tmall.domain.Product;
import com.tmall.domain.ProductImage;
import com.tmall.service.ProductImageService;
import com.tmall.utils.UploadFileImage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-14 20:25
 * Versions:1.0.0
 * Description:
 */

@Service
public class ProductImageServiceImpl implements ProductImageService {
    @Resource
    private ProductDao productDao;
    @Resource
    private ProductImageDao productImageDao;

    @Override
    public Map<String, Object> listProductImage(Product product) {
        Map<String, Object> map = new HashMap<>();
        Map<String, List<ProductImage>> productImageMap = new HashMap<>();

        product = productDao.queryProduct(product);
        productImageMap.put("singleImage", productImageDao.listProductImageByType("singleImage", product.getId()));
        productImageMap.put("detailsImage", productImageDao.listProductImageByType("detailsImage", product.getId()));
        map.put("productImageMap", productImageMap);
        map.put("product", product);
        return map;
    }

    @Override
    @Transactional
    public void addProductImage(ProductImage productImage, UploadFileImage images) throws IOException {
        for (int i = 0; i < images.getImages().length; i++) {
            productImageDao.addProductImage(productImage);
            String imageName = productImage.getId() + ".jpg";
            File file = new File(UploadFileImage.imagePath +
                    "/img/product/"+productImage.getProduct().getId()+"/"+productImage.getType(), imageName);
            file.getParentFile().mkdirs();
            images.getImages()[i].transferTo(file);
        }
    }

    @Override
    @Transactional
    public boolean deleteProductImage(ProductImage productImage) {
        boolean flag = false;
        productImage = productImageDao.queryProductImage(productImage);
        File file = new File(UploadFileImage.imagePath +  "/img/product/" +
                productImage.getProduct().getId()+"/"+productImage.getType() +"/"+ productImage.getId() + ".jpg");
        flag = productImageDao.deleteProductImage(productImage) == 0  ? false : true;
        if(flag){
            UploadFileImage.deleteImage(file);
        }
        return flag;
    }


}
