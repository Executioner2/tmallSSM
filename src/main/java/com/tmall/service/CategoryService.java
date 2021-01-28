package com.tmall.service;

import com.tmall.domain.Category;
import com.tmall.utils.PageUtil;
import com.tmall.utils.UploadFileImage;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-06 17:44
 * Versions:1.0.0
 * Description:
 */
public interface CategoryService {
    PageUtil addCategory(String name, UploadFileImage image) throws IOException;

    Map<String, Object> listCategory(Integer pageNum, Integer count);

    PageUtil editCategory(Category category, UploadFileImage image) throws IOException;

    boolean deleteCategory(Category category);

    Category queryCategory(Category category);

    List<Category> listCategoryAll();
}
