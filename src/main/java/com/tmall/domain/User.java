package com.tmall.domain;

import java.util.List;
import java.util.Objects;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:11
 * Versions:1.0.0
 * Description:
 */
public class User {
    private int id;
    private String name;
    private String password;
    private User parents;  //上级账号
    private List<Order> orders;
    private List<Review> reviews;
    private Integer orderItemNumber;  //购物车商品数量
    private List<User> users;  //管理员账户的子账户
    private AdminUser adminUser;
    private String anonymousName;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", orders=" + orders +
                ", reviews=" + reviews +
                ", users=" + users +
                '}';
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id == user.id &&
                orderItemNumber == user.orderItemNumber &&
                Objects.equals(name, user.name) &&
                Objects.equals(password, user.password) &&
                Objects.equals(parents, user.parents) &&
                Objects.equals(orders, user.orders) &&
                Objects.equals(reviews, user.reviews) &&
                Objects.equals(users, user.users) &&
                Objects.equals(adminUser, user.adminUser) &&
                Objects.equals(anonymousName, user.anonymousName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, password, parents, orders, reviews, orderItemNumber, users, adminUser, anonymousName);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public AdminUser getRegisterKey() {
        return adminUser;
    }

    public void setRegisterKey(AdminUser adminUser) {
        this.adminUser = adminUser;
    }

    public User getParents() {
        return parents;
    }

    public void setParents(User parents) {
        this.parents = parents;
    }

    public AdminUser getAdminUser() {
        return adminUser;
    }

    public void setAdminUser(AdminUser adminUser) {
        this.adminUser = adminUser;
    }

    public String getAnonymousName() {
        return anonymousName;
    }

    public void setAnonymousName(String anonymousName) {
        this.anonymousName = anonymousName;
    }

    public Integer getOrderItemNumber() {
        return orderItemNumber;
    }

    public void setOrderItemNumber(Integer orderItemNumber) {
        this.orderItemNumber = orderItemNumber;
    }
}
