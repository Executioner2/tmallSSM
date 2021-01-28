package com.tmall.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ResourceBundle;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-04 21:40
 * Versions:1.0.0
 * Description:用来作文件上传的实体类（其实是当做工具类用）
 */
public class UploadFileImage {
    private MultipartFile image;
    private MultipartFile[] images;
    public static String imagePath;

    static {
        ResourceBundle bundle = ResourceBundle.getBundle("conf/filePath");
        imagePath = bundle.getString("file.image.path");
    }

    public MultipartFile getImage() {
        return image;
    }

    public void setImage(MultipartFile image) {
        this.image = image;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public MultipartFile[] getImages() {
        return images;
    }

    public void setImages(MultipartFile[] images) {
        this.images = images;
    }

    public static boolean deleteImage(File file){
        if(file == null || !file.exists()){
            return false;
        }
        if(file != null && file.isFile()){
            file.delete();
        }
        File[] files = file.listFiles();
        if(files == null){
            return true;
        }
        for (File f : files) {
            deleteImage(f);
        }
        return file.delete();
    }
}
