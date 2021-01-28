package com.tmall.domain;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 19:08
 * Versions:1.0.0
 * Description:
 */

public class Order {
    private int id;
    private String orderCode;
    private String address;
    private String post;
    private String receiver;
    private String mobile;
    private String userMessage;
    private Date createDate;
    private Date payDate;
    private Date deliveryDate;
    private Date confirmDate;
    private User user;
    private String status;
    private List<OrderItem> orderItems; //订单项
    private float totalMoney;  //总金额
    private int totalNumber; //总数量

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", orderCode='" + orderCode + '\'' +
                ", address='" + address + '\'' +
                ", post='" + post + '\'' +
                ", receiver='" + receiver + '\'' +
                ", mobile='" + mobile + '\'' +
                ", userMessage='" + userMessage + '\'' +
                ", createDate=" + createDate +
                ", payDate=" + payDate +
                ", deliveryDate=" + deliveryDate +
                ", confirmDate=" + confirmDate +
                ", orderItems=" + orderItems +
                ", totalMoney=" + totalMoney +
                ", totalNumber=" + totalNumber +
                ", status=" + status +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return id == order.id &&
                Float.compare(order.totalMoney, totalMoney) == 0 &&
                totalNumber == order.totalNumber &&
                Objects.equals(orderCode, order.orderCode) &&
                Objects.equals(address, order.address) &&
                Objects.equals(post, order.post) &&
                Objects.equals(receiver, order.receiver) &&
                Objects.equals(mobile, order.mobile) &&
                Objects.equals(userMessage, order.userMessage) &&
                Objects.equals(createDate, order.createDate) &&
                Objects.equals(payDate, order.payDate) &&
                Objects.equals(deliveryDate, order.deliveryDate) &&
                Objects.equals(confirmDate, order.confirmDate) &&
                Objects.equals(user, order.user) &&
                Objects.equals(status, order.status) &&
                Objects.equals(orderItems, order.orderItems);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, orderCode, address, post, receiver, mobile, userMessage, createDate, payDate, deliveryDate, confirmDate, user, status, orderItems, totalMoney, totalNumber);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getUserMessage() {
        return userMessage;
    }

    public void setUserMessage(String userMessage) {
        this.userMessage = userMessage;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public Date getConfirmDate() {
        return confirmDate;
    }

    public void setConfirmDate(Date confirmDate) {
        this.confirmDate = confirmDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public float getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(float totalMoney) {
        this.totalMoney = totalMoney;
    }

    public int getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(int totalNumber) {
        this.totalNumber = totalNumber;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public SimpleDateFormat getSdf() {
        return sdf;
    }

    public void setSdf(SimpleDateFormat sdf) {
        this.sdf = sdf;
    }

    public String getStrCreateDate(){
        if(createDate == null){
            return null;
        }
        return sdf.format(createDate);
    }

    public String getStrPayDate(){
        if(payDate == null){
            return null;
        }
        return sdf.format(payDate);
    }

    public String getStrDeliveryDate(){
        if(deliveryDate == null){
            return null;
        }
        return sdf.format(payDate);
    }

    public String getStrConfirmDate(){
        if(confirmDate == null){
            return null;
        }
        return sdf.format(confirmDate);
    }

    public String getChineseCreateDate(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd");
        if(createDate == null){
            return null;
        }
        return sdf.format(createDate);
    }

    //获取中文的订单状态
    public String getChineseStatus(){
        String result = "";
        switch (status){
            case "accomplish": result = "完成";break;
            case "waitPay": result = "待付款";break;
            case "waitDeliver": result = "待发货";break;
            case "waitTake": result = "待收货";break;
            case "evaluate": result = "待评价";break;
        }
        return result;
    }
}
