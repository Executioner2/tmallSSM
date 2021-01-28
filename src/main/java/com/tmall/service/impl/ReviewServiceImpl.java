package com.tmall.service.impl;

import com.tmall.dao.ReviewDao;
import com.tmall.domain.Product;
import com.tmall.domain.Review;
import com.tmall.domain.User;
import com.tmall.service.ReviewService;
import com.tmall.utils.PageUtil;
import com.tmall.utils.SetGetPropertyUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-19 12:48
 * Versions:1.0.0
 * Description:
 */
@Service
public class ReviewServiceImpl implements ReviewService {
    @Resource
    private ReviewDao reviewDao;
    @Resource
    private PageUtil pageUtil;

    @Override
    public Map<String, Object> listReviewByProduct(Integer pageNum, Integer count, Product product) {
        Map<String, Object> map = new HashMap<>();
        User user = null;

        List<Review> reviews = reviewDao.listReviewByProduct(product);
        for (int i = 0; i < reviews.size(); i++) {
            user = reviews.get(i).getUser();
            if(user == null){
                continue;
            }
            reviews.get(i).getUser().setAnonymousName(SetGetPropertyUtil.anonymousName(user.getName()));
        }
        pageUtil.setUri("product/?id="+product.getId()+"&reviewShow=true&");
        map.put("reviews", reviews);
        return map;
    }

    @Override
    @Transactional
    public void addReview(Review review) {
        System.out.println(review);
        review.setCreateDate(new Date());
        reviewDao.addReview(review);
    }
}
