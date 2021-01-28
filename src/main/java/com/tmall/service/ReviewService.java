package com.tmall.service;

import com.tmall.domain.Product;
import com.tmall.domain.Review;

import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-19 12:47
 * Versions:1.0.0
 * Description:
 */
public interface ReviewService {
    Map<String, Object> listReviewByProduct(Integer pageNum, Integer count, Product product);

    void addReview(Review review);
}
