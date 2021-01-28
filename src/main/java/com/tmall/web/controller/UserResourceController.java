package com.tmall.web.controller;

import com.tmall.domain.*;
import com.tmall.service.OrderItemService;
import com.tmall.service.OrderService;
import com.tmall.service.ReviewService;
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
 * Description:  用户资源控制器
 */
@Controller
@RequestMapping("/user")
public class UserResourceController {
    @Resource
    private ModelAndView mv;
    @Resource
    private OrderItemService orderItemService;
    @Resource
    private OrderService orderService;
    @Resource
    private UserService userService;
    @Resource
    private ReviewService reviewService;

    //用户退出
    @RequestMapping(value = "/quit")
    public String userQuit(HttpServletRequest request){
        request.getSession(false).removeAttribute("user");
        request.getSession(false).invalidate();
        return "frontDesk/login/loginPage";
    }

    //加入购物车
    @RequestMapping(value = "/orderItem/add", method = RequestMethod.POST)
    @ResponseBody
    public boolean orderItemAdd(Integer pid, Integer number, HttpServletRequest request){
        boolean flag = false;
        if(number <= 0 || number == null){
            return false;
        }
        OrderItem orderItem = new OrderItem();
        orderItem.setUser((User)request.getSession(false).getAttribute("user"));
        orderItem.setProduct(new Product());
        orderItem.getProduct().setId(pid);
        orderItem.setNumber(number);
        userService.updateOrderItemNumber(orderItem.getUser());
        flag = orderItemService.joinShopping(orderItem);
        if(flag){
            userService.updateOrderItemNumber(orderItem.getUser());
        }
        return flag;
    }

    //前端订单显示
    @RequestMapping(value = "/order/list")
    public ModelAndView userOrderList(Integer pageNum, String status, HttpServletRequest request){
        User user = (User) request.getSession(false).getAttribute("user");
        status = "".equals(status) || "null".equals(status) ? null : status;
        Map<String, Object> map = orderService.listOrder(pageNum, 15, user, status);
        mv.addObject("orders", map.get("orders"));
        mv.addObject("pageUtil", map.get("pageUtil"));
        mv.addObject("status", status);
        mv.setViewName("frontDesk/other/myOrderFormPage");
        return mv;
    }

    //订单删除
    @RequestMapping(value = "/order/delete", method = RequestMethod.POST)
    @ResponseBody
    public boolean userOrderDelete(Order order, HttpServletRequest request){
        User user = (User) request.getSession(false).getAttribute("user");
        order.setUser(user);
        return orderService.userOrderDelete(order);
    }

    //显示购物车
    @RequestMapping(value = "/shopping")
    public ModelAndView userShoppingShow(HttpServletRequest request){
        User user = (User) request.getSession(false).getAttribute("user");
        mv.addObject("orderItems", orderItemService.shoppingShow(user));
        mv.setViewName("frontDesk/other/shoppingPage");
        return mv;
    }

    //订单商品数量更新
    @RequestMapping(value = "/orderItem/update", method = RequestMethod.POST)
    @ResponseBody
    public void userOrderItemUpdate(OrderItem orderItem, HttpServletRequest request){
        boolean flag = false;
        if(orderItem.getNumber() == null || orderItem.getNumber() <= 0){
            return;
        }
        orderItem.setUser((User) request.getSession(false).getAttribute("user"));
        flag = orderItemService.updateOrderItemNumber(orderItem);
        if(flag){
            userService.updateOrderItemNumber((User) request.getSession(false).getAttribute("user"));
        }
    }

    //删除购物车中的一个产品项
    @RequestMapping(value = "/orderItem/delete", method = RequestMethod.POST)
    @ResponseBody
    public boolean userOrderItemDelete(Integer id, HttpServletRequest request){
        boolean flag = false;
        if (id == null){
            return false;
        }
        User user = (User) request.getSession(false).getAttribute("user");
        flag = orderItemService.userOrderItemDelete(id, user.getId());
        if(flag) {
            userService.updateOrderItemNumber(user);
        }
        return flag;
    }

    //确认下单页面
    @RequestMapping(value = "/settleAccounts")
    public ModelAndView userSettlementPage(Integer[] orderItems){
        mv.addObject("orderItems", orderItemService.userSettlement(orderItems));
        mv.setViewName("frontDesk/other/settleAccountsPage");
        return mv;
    }

    //下单
    @RequestMapping(value = "/order/add", method = RequestMethod.POST)
    public ModelAndView userOrderAdd(Order order, Integer[] oiids, HttpServletRequest request){
        User user = (User) request.getSession(false).getAttribute("user");
        Map<String, Object> map = orderService.orderAdd(order, oiids, user);
        if(map == null){
            return null;
        }

        request.getSession(false).setAttribute("address", order.getAddress());
        request.getSession(false).setAttribute("totalPrice", map.get("totalPrice"));
        userService.updateOrderItemNumber(user);
        mv.addObject("id", map.get("id"));
        mv.setViewName("frontDesk/other/payPage");
        return  mv;
    }

    //付款页面
    @RequestMapping(value = "/pay")
    public ModelAndView userPay(Order order, HttpServletRequest request){
        order.setStatus("waitPay");
        order.setUser((User) request.getSession(false).getAttribute("user"));
        order = orderService.userOrderPayPage(order);
        if(order == null){
            return null;
        }
        request.getSession(false).setAttribute("address", order.getAddress());
        request.getSession(false).setAttribute("totalPrice", order.getTotalMoney());

        mv.addObject("id", order.getId());
        mv.setViewName("frontDesk/other/payPage");
        return mv;
    }

    //用户付款
    @RequestMapping(value = "/affirmPay")
    public ModelAndView userAffirmPay(Order order, HttpServletRequest request){
        User user = (User) request.getSession(false).getAttribute("user");
        order.setUser(user);
        order.setStatus("waitPay");
        if(!orderService.userOrderUpdateStatus(order)){
            return null;
        }

        mv.setViewName("frontDesk/other/paymentSuccessPage");
        return mv;
    }

    //卖家发货
    @RequestMapping(value = "/order/delivery", method = RequestMethod.POST)
    @ResponseBody
    public boolean orderDeliver(Order order, HttpServletRequest request){
        User user = (User) request.getSession(false).getAttribute("user");
        order.setUser(user);
        order.setStatus("waitDeliver");
        return orderService.userOrderUpdateStatus(order);
    }


    //买家确认收货页面
    @RequestMapping(value = "/confirmPage")
    public ModelAndView userOrderConfirmPage(Order order, HttpServletRequest request){
        order.setUser((User) request.getSession(false).getAttribute("user"));
        order.setStatus("waitTake");
        mv.addObject("order", orderService.queryOrder(order));
        mv.setViewName("frontDesk/other/confirmReceiptPage");
        return mv;
    }

    //买家确认收货
    @RequestMapping(value = "/confirm")
    public String userOrderConfirm(Order order, HttpServletRequest request){
        order.setUser((User) request.getSession(false).getAttribute("user"));
        order.setStatus("waitTake");
        orderService.userOrderUpdateStatus(order);
        return "frontDesk/other/theGoodsSuccessfullyPage";
    }

    //立即购买
    @RequestMapping(value = "/buy")
    public String userBuy(Integer pid, Integer number, HttpServletRequest request){
        if(number <= 0 || number == null){
            return "";
        }
        OrderItem orderItem = new OrderItem();
        orderItem.setProduct(new Product());
        orderItem.getProduct().setId(pid);
        orderItem.setNumber(number);
        orderItem.setUser((User) request.getSession(false).getAttribute("user"));
        orderItemService.joinShopping(orderItem);
        userService.updateOrderItemNumber(orderItem.getUser());
        return "redirect:/user/settleAccounts?orderItems="+orderItem.getId(); //跳转到确认下单
    }

    //用户评价页面
    @RequestMapping(value = "/reviewPage")
    public ModelAndView userReviewPage(Order order, HttpServletRequest request){
        order.setUser((User) request.getSession(false).getAttribute("user"));
        order.setStatus("evaluate");
        order = orderService.queryOrder(order);
        if(order == null){
            mv.setViewName("redirect:/user/order/list");
            return mv;
        }
        request.getSession(false).setAttribute("order", order);
        request.getSession(false).setAttribute("reviewCount", 0);
        mv.addObject("orderItem", order.getOrderItems().get(0));
        mv.setViewName("frontDesk/other/theEvaluationPage");
        return mv;
    }

    //用户评价
    @RequestMapping(value = "/affirmReview")
    public ModelAndView userReview(Review review, HttpServletRequest request){
        Integer reviewCount = (Integer) request.getSession(false).getAttribute("reviewCount");
        Order order = (Order) request.getSession(false).getAttribute("order");
        order.setUser((User) request.getSession(false).getAttribute("user"));

        if(reviewCount == null || order == null){
            return null;
        }

        review.setProduct(order.getOrderItems().get(reviewCount).getProduct());
        if(reviewCount == 0){
            orderService.userOrderUpdateStatus(order);
        }

        review.setUser(order.getUser());
        reviewService.addReview(review);
        Map<String, Object> map = reviewService.listReviewByProduct(0, 20, review.getProduct());

        if(reviewCount < order.getOrderItems().size() - 1){
            mv.addObject("hasNext", true);
            request.getSession(false).setAttribute("reviewCount", reviewCount + 1);
        }else{
            mv.addObject("hasNext", false);
        }

        mv.addObject("orderItem", order.getOrderItems().get(reviewCount));
        mv.addObject("reviews", map.get("reviews"));
        mv.setViewName("redirect:/user/evaluate/success");
        return mv;
    }

    //显示评价成功页面
    @RequestMapping(value = "/evaluate/success")
    public ModelAndView evaluateSuccessShow(){
        mv.setViewName("frontDesk/other/evaluateSuccessPage");
        return mv;
    }

    //下一个要评价的产品
    @RequestMapping(value = "/next/review")
    public ModelAndView userNextReviewProduct(HttpServletRequest request){
        Order order = (Order) request.getSession(false).getAttribute("order");
        Integer reviewCount = (Integer) request.getSession(false).getAttribute("reviewCount");

        if(reviewCount == null || order == null){
            return null;
        }

        mv.addObject("orderItem", order.getOrderItems().get(reviewCount));
        mv.setViewName("frontDesk/other/theEvaluationPage");
        return mv;
    }
}
