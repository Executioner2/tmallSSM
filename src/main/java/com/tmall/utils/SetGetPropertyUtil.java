package com.tmall.utils;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-19 15:12
 * Versions:1.0.0
 * Description:
 */
public class SetGetPropertyUtil {
    //用户匿名
    public static String anonymousName(String userName){
        StringBuilder name = new StringBuilder();
        if(userName.length() == 1){
            name.append("*");
        }else if(userName.length() == 2){
            name.append(userName.charAt(0));
            name.append("*");
        }else{
            name.append(userName.charAt(0));
            for (int i = 0; i < userName.length() - 2; i++) {
                name.append("*");
            }
            name.append(userName.charAt(name.length()));
        }
        return name.toString();
    }
}
