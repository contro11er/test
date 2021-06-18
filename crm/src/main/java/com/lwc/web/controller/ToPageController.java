package com.lwc.web.controller;

import com.lwc.constant.CRM;
import com.lwc.pojo.User;
import com.lwc.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 因为请求转发是同一请求，刷新页面会导致请求再发送一次
 * 所以除了查询，剩下的都用重定向
 */

@Controller
public class ToPageController {

    @Autowired
    private UserService userService;

    //@CookieValue注解用于将请求的cookie数据映射到功能处理方法的参数上。
    @RequestMapping("/")
    public String toLogin(@CookieValue(value = CRM.LoginUser.username, required = false) String loginAct,
                          @CookieValue(value = CRM.LoginUser.password, required = false) String loginPwd,
                          HttpServletRequest request) {
        if (StringUtils.isNoneBlank(loginAct, loginPwd)) {
            String ip = request.getRemoteAddr();
            User user = userService.getAutoLogin(loginAct, loginPwd, ip);
            if (user != null) {
                request.getSession().setAttribute(CRM.LoginUser.obj, user);
                return "redirect:/workbench/index.html";
            }
        }
        return "redirect:/login.html";
    }

    @RequestMapping("/**/*.html")
    public String toAnyWhere(HttpServletRequest request) {
        //uri截取到   不会获取路径后面的参数(queryString可以)/
        String uri = request.getRequestURI();
        int index = uri.lastIndexOf(".");
        return uri.substring(1, index);
    }
}
