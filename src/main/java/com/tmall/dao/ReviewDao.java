package com.tmall.dao;

import com.tmall.domain.Product;
import com.tmall.domain.Review;

import java.util.List;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:45
 * Versions:1.0.0
 * Description:
 */
public interface ReviewDao {
    int deleteReviewByProduct(List<Product> products);

    List<Review> listReviewByProduct(Product product);

    Integer addReview(Review review);
}
