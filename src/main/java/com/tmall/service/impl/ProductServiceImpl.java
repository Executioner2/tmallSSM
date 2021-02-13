package com.tmall.service.impl;

import com.tmall.dao.*;
import com.tmall.domain.Category;
import com.tmall.domain.Product;
import com.tmall.domain.ProductImage;
import com.tmall.service.ProductService;
import com.tmall.service.ReviewService;
import com.tmall.utils.PageUtil;
import com.tmall.utils.UploadFileImage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.util.*;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-08 17:42
 * Versions:1.0.0
 * Description:
 */

@Service
public class ProductServiceImpl implements ProductService {
    @Resource
    private ProductDao productDao;
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private PropertyValueDao propertyValueDao;
    @Resource
    private ProductImageDao productImageDao;
    @Resource
    private ReviewDao reviewDao;
    @Resource
    private ReviewService reviewService;
    @Resource
    private PageUtil pageUtil;

    @Override
    public Map<String, Object> listProduct(Integer pageNum, Integer count, Category category) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> param = new HashMap<>();

        param.put("category", category);
        List<Product> products = productDao.listProduct(param);
        // 获取第一张产品缩略图
        for (Product p : products) {
            ProductImage productImageFirst = productImageDao.queryProductImageFirst(p);
            p.setSingleImageFirst(productImageFirst);
        }

        pageUtil.setUri("classify?id="+category.getId()+"&");
        map.put("products", products);
        map.put("category", categoryDao.queryCategory(category));
        return map;
    }

    @Override
    public Map<String, Object> listProductByLikeQuery(Integer pageNum, Integer count, String keyword) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", "%" + keyword + "%");
        List<Product> products = productDao.listProduct(param);
        // 获取第一张产品缩略图
        for (Product p : products) {
            ProductImage productImageFirst = productImageDao.queryProductImageFirst(p);
            p.setSingleImageFirst(productImageFirst);
        }
        map.put("products", products);
        pageUtil.setUri("search?keyword="+keyword+"&");
        return map;
    }

    @Override
    public Map<String, Object> listProductSort(Integer pageNum, Integer count, Category category, String sort, Boolean sortType, Integer priceLeft, Integer priceRight) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> param = new HashMap<>();
        List<Product> products;

        if (priceLeft != null && priceRight != null) {
            if (priceLeft > priceRight) {
                param.put("priceLeft", priceRight);
                param.put("priceRight", priceLeft);
            } else {
                param.put("priceLeft", priceLeft);
                param.put("priceRight", priceRight);
            }
        }

        param.put("category", category);
        param.put("order", "desc");
        pageUtil.setUri("classify/sort?id=" + category.getId() + "&sort=" + sort + "&priceRight=" + priceRight + "&priceLeft=" + priceLeft + "&");
        if ("review".equals(sort)) { //按照人气排序（评价数）
            param.put("sort", "reviewNumber");
        } else if ("createDate".equals(sort)) {  //按照新品排序
            param.put("sort", "createDate");
        } else if ("sales".equals(sort)) {  //按照销量排序
            param.put("sort", "salesVolume");
        } else if ("price".equals(sort)) {  //按照价格排序
            param.put("sort", "promotePrice");
            if (!sortType) {
                param.put("order", "asc");
            }
            pageUtil.setUri("classify/sort?id=" + category.getId() + "&sort=" + sort + "&sortType=" + sortType + "&priceRight=" + priceRight + "&priceLeft=" + priceLeft + "&");
        }else{
            param.put("sort", null);
            param.put("order", null);
            pageUtil.setUri("classify/sort?id=" + category.getId() + "&priceRight=" + priceRight + "&priceLeft=" + priceLeft + "&");
        }

        products = productDao.listProduct(param);
        // 获取第一张产品缩略图
        for (Product p : products) {
            ProductImage productImageFirst = productImageDao.queryProductImageFirst(p);
            p.setSingleImageFirst(productImageFirst);
        }
        map.put("category", categoryDao.queryCategory(category));
        map.put("products", products);
        map.put("sortType", !sortType);
        return map;
    }


    @Override
    @Transactional
    public PageUtil addProduct(Product product) {
        product.setName(product.getName().trim());
        product.setSubTitle(product.getSubTitle().trim());
        product.setCreateDate(new Date());
        productDao.addProduct(product);
        return pageUtil;
    }

    @Override
    public Product queryProduct(Product product) {
        return productDao.queryProduct(product);
    }

    @Override
    @Transactional
    public boolean deleteProduct(Product product) {
        boolean flag = false;
        List<Product> list = new ArrayList<>();

        list.add(product);
        reviewDao.deleteReviewByProduct(list);
        productImageDao.deleteProductImageByProduct(list);
        propertyValueDao.deletePropertyValueByProduct(product);
        File file = new File(UploadFileImage.imagePath + "/img/product/" + product.getId());
        flag = productDao.deleteProduct(product) == 1 ? true : false;
        if(flag){
            UploadFileImage.deleteImage(file);
        }
        return flag;
    }

    @Override
    @Transactional
    public PageUtil updateProduct(Product product) {
        product.setName(product.getName().trim());
        product.setSubTitle(product.getSubTitle().trim());
        productDao.updateProduct(product);
        return pageUtil;
    }

    @Override
    public Map<String, Object> queryProductDetail(Integer pageNum, Integer count, Product product) {
        Map<String, Object> map = new HashMap<>();
        product = productDao.queryProduct(product);

        //查询产品图片
        product.setProductImages(new HashMap<>());
        product.getProductImages().put("singleImage", productImageDao.listProductImageByType("singleImage", product.getId()));
        product.getProductImages().put("detailsImage", productImageDao.listProductImageByType("detailsImage", product.getId()));

        //查询用户评价，一页只显示20条
        Map<String, Object> reviewMap = reviewService.listReviewByProduct(pageNum, count, product);

        map.put("product",product);
        map.put("reviews", reviewMap.get("reviews"));
        map.put("pageUtil", reviewMap.get("pageUtil"));
        return map;
    }
}
