package com.tmall.domain;

import java.util.Objects;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:11
 * Versions:1.0.0
 * Description:
 */
public class OrderItem {
    private Integer id;
    private Product product;
    private Order order;
    private User user;
    private Integer number;

    @Override
    public String toString() {
        return "OrderItem{" +
                "id=" + id +
                ", number=" + number +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderItem orderItem = (OrderItem) o;
        return id == orderItem.id &&
                number == orderItem.number &&
                Objects.equals(product, orderItem.product) &&
                Objects.equals(order, orderItem.order) &&
                Objects.equals(user, orderItem.user);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, product, order, user, number);
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }
}
