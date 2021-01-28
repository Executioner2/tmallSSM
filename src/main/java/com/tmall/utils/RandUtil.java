package com.tmall.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-17 19:32
 * Versions:1.0.0
 * Description:
 */
public class RandUtil {
    /**
     * 随机生成大写和数字字符串
     * @return
     */
    public static String randKey(int length){
        int flag;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            flag =(int) (Math.random() * 2);
            if(flag == 1){
                sb.append((char)((int)(Math.random() * 10 + 48)));
            }else{
                sb.append((char)((int)(Math.random() * 26 + 65)));
            }
        }
        return sb.toString();
    }

    /**
     * 随机生成订单号
     * @return
     */
    public static String createOrderCode(){
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        StringBuilder newTime = new StringBuilder();
        newTime.append(sdf.format(date));
        String code = String.valueOf((int)(Math.random() * 1000000));
        for (int i = 0; i < 6 - code.length(); i++) {
            newTime.append("0");
        }
        newTime.append(code);
        return newTime.toString();
    }
}
