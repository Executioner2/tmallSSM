package com.tmall.web.controller;

import com.tmall.domain.Category;
import com.tmall.domain.Product;
import com.tmall.domain.User;
import com.tmall.service.CategoryService;
import com.tmall.service.ProductService;
import com.tmall.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Copyright@1205878539@qq.com
 * Author:2Executioner
 * Date:2021-01-18 9:38
 * Versions:1.0.0
 * Description:  公共资源控制器
 */
@Controller
public class PublicResourceController {
    @Resource
    private ModelAndView mv;
    @Resource
    private CategoryService categoryService;
    @Resource
    private ProductService productService;
    @Resource
    private UserService userService;

    @RequestMapping("/home")
    public ModelAndView listCategoryAll(){
        mv.addObject("categories", categoryService.listCategoryAll());
        mv.setViewName("frontDesk/login/homePage");
        return mv;
    }

    @RequestMapping("/classify")
    public ModelAndView listProduct(Category category, Integer pageNum){
        Map<String, Object> map = productService.listProduct(pageNum, 40 ,category);
        mv.clear();  //清空在ModelAndView中的数据
        mv.addObject("products", map.get("products"));
        mv.addObject("pageUtil", map.get("pageUtil"));
        mv.addObject("category", map.get("category"));
        mv.setViewName("frontDesk/login/classifyPage");
        return mv;
    }

    @RequestMapping("/classify/sort")
    public ModelAndView sortProduct(Category category, Integer pageNum, String sort, Boolean sortType, Integer priceLeft, Integer priceRight){
        if("".equals(sort)){
            sort = null;
        }
        if(sortType == null){
            sortType = new Boolean(true);
        }
        if(priceLeft == priceRight){
            priceLeft = priceRight = null;
        }
        Map<String, Object> map = productService.listProductSort(pageNum, 40, category, sort, sortType, priceLeft, priceRight);
        mv.addObject("products", map.get("products"));
        mv.addObject("pageUtil", map.get("pageUtil"));
        mv.addObject("category", map.get("category"));
        mv.addObject("sortType", map.get("sortType"));
        mv.addObject("priceLeft", priceLeft);
        mv.addObject("priceRight", priceRight);
        mv.addObject("sort", sort);
        mv.setViewName("frontDesk/login/classifyPage");
        return mv;
    }

    @RequestMapping("/product")
    public ModelAndView productShow(Integer pageNum, Product product, Boolean reviewShow){
        Map<String, Object> map = productService.queryProductDetail(pageNum, 20, product);
        mv.addObject("product", map.get("product"));
        mv.addObject("reviews", map.get("reviews"));
        mv.addObject("pageUtil", map.get("pageUtil"));
        mv.addObject("reviewShow", reviewShow);
        mv.setViewName("frontDesk/login/productPage");
        return mv;
    }

    @RequestMapping("/registerPage")
    public String userRegisterPage(){
        return "frontDesk/login/registerPage";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public String userRegister(User user){
        String result = "";
        if(userService.nameRepetitionCheck(user)){
            result = "用户名已经被使用，不能使用";
            return result;
        }
        if(userService.userRegister(user)){
            result = "注册成功";
        }else{
            result = "注册失败";
        }
        return result;
    }

    @RequestMapping("/loginPage")
    public String userLoginPage(){
        return "frontDesk/login/loginPage";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public boolean userLogin(User user, HttpServletRequest request){
        boolean result = false;
        result = userService.userLogin(user);
        if(result){
            request.getSession().setAttribute("user", user);
        }
        return result;
    }

    //搜索
    @RequestMapping(value = "/search")
    public ModelAndView searchProduct(Integer pageNum, String keyword){
        Map<String, Object> map = productService.listProductByLikeQuery(pageNum, 40, keyword);
        mv.addObject("pageUtil", map.get("pageUtil"));
        mv.addObject("products", map.get("products"));
        mv.setViewName("frontDesk/other/queryResultPage");
        return mv;
    }
}
