package com.tmall.service.impl;

import com.github.pagehelper.PageHelper;
import com.tmall.dao.CategoryDao;
import com.tmall.dao.ProductDao;
import com.tmall.domain.Category;
import com.tmall.domain.Product;
import com.tmall.service.CategoryService;
import com.tmall.utils.PageUtil;
import com.tmall.utils.UploadFileImage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-06 17:45
 * Versions:1.0.0
 * Description:
 */
@Service
public class CategoryServiceImpl implements CategoryService {
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private ProductDao productDao;
    @Resource
    private PageUtil pageUtil;

    @Override
    @Transactional
    public PageUtil addCategory(String name, UploadFileImage image) throws IOException { ;
        Category category = new Category();
        name = name.trim();
        category.setName(name);
        categoryDao.addCategory(category);
        String imageName = category.getId() + ".jpg";
        File file = new File(image.getImagePath() + "/img/category", imageName);
        file.getParentFile().mkdirs();
        image.getImage().transferTo(file);
        return pageUtil;
    }

    @Override
    public Map<String, Object> listCategory(Integer pageNum, Integer count) {
        Map<String, Object> map = new HashMap<>();
        List<Category> categories = categoryDao.listCategory();
        pageUtil.setUri("admin/category/list?");
        map.put("categories", categories);
        return map;
    }

    @Override
    @Transactional
    public PageUtil editCategory(Category category, UploadFileImage image) throws IOException {
        if(category.getName().trim() != ""){
            categoryDao.editCategory(category);
        }
        if(image != null) {
            File file = new File(image.getImagePath() + "/img/category", category.getId() + ".jpg");
            file.getParentFile().mkdirs();
            image.getImage().transferTo(file);
        }
        return pageUtil;
    }

    /**
     * 仅删除分类，分类相关联的表的外键将会被置null
     * @param category
     */
    @Override
    @Transactional
    public boolean deleteCategory(Category category) {
        boolean flag = false;
        flag = categoryDao.deleteCategory(category) == 0 ? false : true;
        if(flag){
            UploadFileImage.deleteImage(new File(UploadFileImage.imagePath + "/img/category/" + category.getId() + ".jpg"));
        }

        return flag;
    }

    @Override
    public Category queryCategory(Category category) {
        return categoryDao.queryCategory(category);
    }

    @Override
    public List<Category> listCategoryAll() {
        List<Category> categories = categoryDao.listCategory();
        Map<String, Object> map = new HashMap<>();

        for (int i = 0; i < categories.size(); i++) {
            map.put("category", categories.get(i));
            List<List<Product>> productsByRow = new ArrayList<>();
            int rows = 8;
            PageHelper.offsetPage(0, 64);
            List<Product> products = productDao.listProduct(map);
            categories.get(i).setProducts(products);

            //设置productsByRow
            for (int j = 0; j < products.size(); j += rows) {
                int size = j + rows;
                size = size > products.size() ? products.size() : size;
                productsByRow.add(products.subList(j, size));
            }
            categories.get(i).setProductsByRow(productsByRow);
        }

        return categories;
    }
}
