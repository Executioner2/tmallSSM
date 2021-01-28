package com.tmall.domain;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:08
 * Versions:1.0.0
 * Description:
 */
public class Product {
    private Integer id;
    private String name;
    private String subTitle;
    private float orignalPrice;
    private float promotePrice;
    private Integer stock;
    private Category category;
    private Date createDate;
    private List<PropertyValue> propertyValues;
    private Map<String, List<ProductImage>> productImages;
    private List<Review> reviews;
    private ProductImage singleImageFirst;  //第一张产品图片
    private Integer reviewNumber; //评价数量
    private Integer salesVolume;  //销量

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", subTitle='" + subTitle + '\'' +
                ", orignalPrice=" + orignalPrice +
                ", promotePrice=" + promotePrice +
                ", stock=" + stock +
                ", createDate=" + createDate +
                ", propertyValues=" + propertyValues +
                ", productImages=" + productImages +
                ", reviews=" + reviews +
                ", firstProductImage=" + singleImageFirst +
                ", reviewNumber=" + reviewNumber +
                ", salesVolume=" + salesVolume +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return id == product.id &&
                Float.compare(product.orignalPrice, orignalPrice) == 0 &&
                Float.compare(product.promotePrice, promotePrice) == 0 &&
                stock == product.stock &&
                reviewNumber == product.reviewNumber &&
                salesVolume == product.salesVolume &&
                Objects.equals(name, product.name) &&
                Objects.equals(subTitle, product.subTitle) &&
                Objects.equals(category, product.category) &&
                Objects.equals(createDate, product.createDate) &&
                Objects.equals(propertyValues, product.propertyValues) &&
                Objects.equals(productImages, product.productImages) &&
                Objects.equals(reviews, product.reviews) &&
                Objects.equals(singleImageFirst, product.singleImageFirst);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, subTitle, orignalPrice, promotePrice, stock, category, createDate, propertyValues, productImages, reviews, singleImageFirst, reviewNumber, salesVolume);
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSubTitle() {
        return subTitle;
    }

    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }

    public float getOrignalPrice() {
        return orignalPrice;
    }

    public void setOrignalPrice(float orignalPrice) {
        this.orignalPrice = orignalPrice;
    }

    public float getPromotePrice() {
        return promotePrice;
    }

    public void setPromotePrice(float promotePrice) {
        this.promotePrice = promotePrice;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<PropertyValue> getPropertyValues() {
        return propertyValues;
    }

    public void setPropertyValues(List<PropertyValue> propertyValues) {
        this.propertyValues = propertyValues;
    }

    public Map<String, List<ProductImage>> getProductImages() {
        return productImages;
    }

    public void setProductImages(Map<String, List<ProductImage>> productImages) {
        this.productImages = productImages;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    public ProductImage getSingleImageFirst() {
        return singleImageFirst;
    }

    public void setSingleImageFirst(ProductImage singleImageFirst) {
        this.singleImageFirst = singleImageFirst;
    }

    public Integer getReviewNumber() {
        return reviewNumber;
    }

    public void setReviewNumber(Integer reviewNumber) {
        this.reviewNumber = reviewNumber;
    }

    public Integer getSalesVolume() {
        return salesVolume;
    }

    public void setSalesVolume(Integer salesVolume) {
        this.salesVolume = salesVolume;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
