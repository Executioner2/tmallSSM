package com.tmall.domain;

import java.util.Objects;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-17 17:42
 * Versions:1.0.0
 * Description:
 */
public class AdminUser {
    private int id;
    private String key;
    private User user;

    @Override
    public String toString() {
        return "RegisterKey{" +
                "id=" + id +
                ", key='" + key + '\'' +
                ", user=" + user +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AdminUser that = (AdminUser) o;
        return id == that.id &&
                Objects.equals(key, that.key) &&
                Objects.equals(user, that.user);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, key, user);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
