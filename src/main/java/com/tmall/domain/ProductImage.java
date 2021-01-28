package com.tmall.domain;

import java.util.Objects;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:10
 * Versions:1.0.0
 * Description:
 */
public class ProductImage {
    private int id;
    private Product product;
    private String type;

    @Override
    public String toString() {
        return "ProductImage{" +
                "id=" + id +
                ", type='" + type + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductImage that = (ProductImage) o;
        return id == that.id &&
                Objects.equals(product, that.product) &&
                Objects.equals(type, that.type);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, product, type);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
