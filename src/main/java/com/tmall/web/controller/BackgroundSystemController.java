package com.tmall.web.controller;

import com.tmall.domain.*;
import com.tmall.service.*;
import com.tmall.utils.PageUtil;
import com.tmall.utils.UploadFileImage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-06 17:12
 * Versions:1.0.0
 * Description:  后台管理系统控制器
 */
@Controller
@RequestMapping(value = {"/admin"})
public class BackgroundSystemController {
    @Resource
    private CategoryService categoryService;
    @Resource
    private PropertyService propertyService;
    @Resource
    private ProductService productService;
    @Resource
    private PropertyValueService propertyValueService;
    @Resource
    private ProductImageService productImageService;
    @Resource
    private UserService userService;
    @Resource
    private OrderService orderService;
    @Resource
    private ModelAndView mv;

    @RequestMapping(value = {"/category/list", ""})
    public ModelAndView listCategory(Integer pageNum) {
        Map<String, Object> map = categoryService.listCategory(pageNum, 5);
        mv.addObject("categories", (List<Category>) map.get("categories"));
        mv.addObject("pageUtil", (PageUtil) map.get("pageUtil"));
        mv.setViewName("admin/categoryManager");
        return mv;
    }

    @RequestMapping(value = "/category/add", method = RequestMethod.POST)
    public String addCategory(String name, UploadFileImage image) throws IOException {
        Integer pageNum = categoryService.addCategory(name, image).getPageInfo().getPageNum();
        return "redirect:/admin/category/list?pageNum=" + ((pageNum - 1) * 5);
    }

    @RequestMapping("/category/edit")
    public ModelAndView editCategory(Category category) {
        mv.addObject("category", category);
        mv.setViewName("admin/edit/editCategory");
        return mv;
    }

    @RequestMapping(value = "/category/update", method = RequestMethod.POST)
    public String updateCategory(Category category, UploadFileImage image) throws IOException {
        Integer pageNum = categoryService.editCategory(category, image).getPageInfo().getPageNum();
        return "redirect:/admin/category/list/?pageNum=" + ((pageNum - 1) * 5);
    }

    @RequestMapping(value = "/category/delete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCategory(Category category) {
        String json = "";
        json = (categoryService.deleteCategory(category) ? "删除失败！" : "删除成功！");
        return json;
    }

    @RequestMapping("/property/list")
    public ModelAndView listProperty(Integer pageNum, Category category) {
        Map<String, Object> map = propertyService.listProperty(pageNum, 5, category);
        mv.addObject("category", categoryService.queryCategory(category));
        mv.addObject("properties", map.get("properties"));
        mv.addObject("pageUtil", map.get("pageUtil"));
        mv.setViewName("admin/propertyManager");
        return mv;
    }

    @RequestMapping(value = "/property/add", method = RequestMethod.POST)
    public String addProperty(Property property, Integer cid) {
        if (property != null) {
            property.setCategory(new Category());
            property.getCategory().setId(cid);
        }
        Integer pageNum = propertyService.addProperty(property).getPageInfo().getPageNum();
        return "redirect:/admin/property/list?id=" + cid + "&pageNum=" + ((pageNum - 1) * 5);
    }

    @RequestMapping(value = "/property/delete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteProperty(Property property) {
        String json = "";
        if (propertyService.deleteProperty(property)) {
            json = "删除成功！";
        } else {
            json = "删除失败！";
        }
        return json;
    }

    @RequestMapping("/property/edit")
    public ModelAndView editProperty(Property property) {
        property = propertyService.queryProperty(property);
        mv.addObject("property", property);
        mv.setViewName("admin/edit/editProperty");
        return mv;
    }

    @RequestMapping(value = "/property/update", method = RequestMethod.POST)
    public String updateProperty(Property property, Integer cid) {
        Integer pageNum = propertyService.updateProperty(property).getPageInfo().getPageNum();
        return "redirect:/admin/property/list?id=" + cid + "&pageNum=" + ((pageNum - 1) * 5);
    }

    @RequestMapping("/product/list")
    public ModelAndView listProduct(Integer pageNum, Category category) {
        Map<String, Object> map = productService.listProduct(pageNum, 5, category);
        PageUtil pageUtil = (PageUtil) map.get("pageUtil");
        pageUtil.setUri("admin/product/list?id="+category.getId()+"&");
        mv.addObject("products", map.get("products"));
        mv.addObject("pageUtil", pageUtil);
        mv.addObject("category", map.get("category"));
        mv.setViewName("admin/productManager");
        return mv;
    }

    @RequestMapping(value = "/product/update", method = RequestMethod.POST)
    public String updateProduct(Product product, Integer cid) {
        Integer pageNum = productService.updateProduct(product).getPageInfo().getPageNum();
        return "redirect:/admin/product/list?id=" + cid + "&pageNum=" + ((pageNum - 1) * 5);
    }

    @RequestMapping(value = "/product/add", method = RequestMethod.POST)
    public String addProduct(Product product, Integer cid) {
        if (product != null) {
            product.setCategory(new Category());
            product.getCategory().setId(cid);
        }
        Integer pageNum = productService.addProduct(product).getPageInfo().getPageNum();
        return "redirect:/admin/product/list/?pageNum=" + ((pageNum - 1) * 5) + "&id=" + cid;
    }

    @RequestMapping("/product/edit")
    public ModelAndView editProduct(Product product) {
        product = productService.queryProduct(product);
        mv.addObject("product", product);
        mv.setViewName("admin/edit/editProduct");
        return mv;
    }

    @RequestMapping(value = "/product/delete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteProduct(Product product) {
        String json = "";
        System.out.println(product);
        if (productService.deleteProduct(product)) {
            json = "删除成功！";
        } else {
            json = "删除失败！";
        }
        return json;
    }

    @RequestMapping("/propertyValue/list")
    public ModelAndView listPropertyValue(Product product, Integer cid) {
        propertyValueService.addPropertyValue(product, cid);
        Map<String, Object> map = propertyValueService.listPropertyValue(product);
        mv.addObject("product", map.get("product"));
        mv.addObject("propertyValues", map.get("propertyValues"));
        mv.setViewName("admin/edit/editPropertyValue");
        return mv;
    }

    @RequestMapping(value = "/propertyValue/update", method = RequestMethod.POST)
    @ResponseBody
    public boolean updatePropertyValue(PropertyValue propertyValue) {
        return propertyValueService.updatePropertyValue(propertyValue);
    }

    @RequestMapping("/productImage/list")
    public ModelAndView listProductImage(Product product) {
        Map<String, Object> map = productImageService.listProductImage(product);
        mv.addObject("productImageMap", map.get("productImageMap"));
        mv.addObject("product", map.get("product"));
        mv.setViewName("admin/productImageManager");
        return mv;
    }

    @RequestMapping(value = "/productImage/add", method = RequestMethod.POST)
    public String addProductImage(ProductImage productImage, Integer pid, UploadFileImage images) throws IOException {
        productImage.setProduct(new Product());
        productImage.getProduct().setId(pid);
        productImageService.addProductImage(productImage, images);
        return "redirect:/admin/productImage/list?id=" + pid;
    }

    @RequestMapping(value = "/productImage/delete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteProductImage(ProductImage productImage) {
        String json = "";
        if (productImageService.deleteProductImage(productImage)) {
            json = "删除成功！";
        } else {
            json = "删除失败！";
        }
        return json;
    }

    @RequestMapping("/user/list")
    public ModelAndView listUser(Integer pageNum) {
        Map<String, Object> map = userService.listUser(pageNum, 5);
        mv.addObject("users", map.get("users"));
        mv.addObject("pageUtil", map.get("pageUtil"));
        mv.setViewName("admin/userManager");
        return mv;
    }

    @RequestMapping("/order/list")
    public ModelAndView listOrder(Integer pageNum) {
        Map<String, Object> map = orderService.listOrder(pageNum, 5, null, null);
        mv.addObject("orders", (List<Order>) map.get("orders"));
        mv.addObject("pageUtil", map.get("pageUtil"));
        mv.setViewName("admin/orderManager");
        return mv;
    }

    //发货
    @RequestMapping(value = "/order/deliver", method = RequestMethod.POST)
    @ResponseBody
    public void orderDeliver(Order order){
        orderService.orderDeliver(order);
    }

    @RequestMapping("/register")
    public ModelAndView registerDisplay() {
        mv.setViewName("admin/adminRegister");
        return mv;
    }

    @RequestMapping(value = "/loginPage")
    public ModelAndView loginDisplay() {
        mv.setViewName("admin/adminLogin");
        return mv;
    }

    @RequestMapping(value = "/user/add", method = RequestMethod.POST)
    @ResponseBody
    public boolean adminUserRegister(User user, Integer uid) {
        user.setParents(new User());
        user.getParents().setId(uid);
        return userService.adminUserRegister(user);
    }

    @RequestMapping(value = "/adminUser/checkKey", method = RequestMethod.POST)
    @ResponseBody
    public User checkRegisterKey(String key) {
        return userService.queryUserByRegisterKey(key);
    }

    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    @ResponseBody
    public boolean adminUserLogin(User user, HttpServletRequest request) {
        boolean flag;
        flag = userService.adminUserLogin(user);
        if (flag) {
            request.getSession().setAttribute("adminUser", user);
        }
        return flag;
    }

    @RequestMapping(value = "/user/exit")
    public String adminUserExit(HttpServletRequest request){
        request.getSession(false).invalidate();
        return "redirect:/admin/loginPage";
    }

    //用户名检测
    @RequestMapping(value = "/name/check", method = RequestMethod.POST)
    @ResponseBody
    public boolean nameRepetitionCheck(User user){
        return userService.nameRepetitionCheck(user);
    }
}