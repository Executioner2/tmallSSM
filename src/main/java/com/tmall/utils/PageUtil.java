package com.tmall.utils;

import com.github.pagehelper.PageInfo;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-07 19:33
 * Versions:1.0.0
 * Description:
 */
public class PageUtil {
    private PageInfo pageInfo;
    private int startPage;  //开始页
    private String uri;  //页面跳转地址
    private int count;

    public PageInfo getPageInfo() {
        return pageInfo;
    }

    public void setPageInfo(PageInfo pageInfo) {
        this.pageInfo = pageInfo;
    }

    public int getStartPage() {
        int pageNum = pageInfo.getPageNum(); //当前页数
        int pages = pageInfo.getPages();     //总页数
        if(pageNum < 7){
            this.setStartPage(1);
        }else if(pages - pageNum < 3){
            this.setStartPage(pages - 6);
        }else{
            this.setStartPage(pageNum - 3);
        }
        return startPage;  //返回实际开始页
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
