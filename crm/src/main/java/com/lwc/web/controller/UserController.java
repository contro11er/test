package com.lwc.web.controller;

import com.lwc.constant.CRM;
import com.lwc.pojo.User;
import com.lwc.service.UserService;
import com.lwc.utils.MyAddUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@ResponseBody
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;


    @RequestMapping("/login.do")
    public Map login(String loginAct, String loginPwd, boolean checked, HttpServletRequest request, HttpServletResponse response) {
        String ip = request.getRemoteAddr();
        User user = userService.getUser(loginAct, loginPwd, ip);
        request.getSession().setAttribute(CRM.LoginUser.obj, user);

        if (checked) {
            Cookie c1 = new Cookie(CRM.LoginUser.username, user.getLoginAct());
            Cookie c2 = new Cookie(CRM.LoginUser.password, user.getLoginPwd());
            int maxAge = 3600 * 24 * 10;
//设置路径为全路径（这样写的好处是同一项目下的页面都可以访问该cookie），而且也一定要设
            c1.setPath("/");
            c2.setPath("/");
            c1.setMaxAge(maxAge);
            c2.setMaxAge(maxAge);
//设置的cookie一定要添加到响应体中，否则无法生效
            response.addCookie(c1);
            response.addCookie(c2);
        }
        return new HashMap() {{
            put("success", true);
        }};
    }

    @RequestMapping("/getList.json")
    public List getList(){
        return userService.getList();
    }

    @RequestMapping("/exit.do")
    public String exit(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute(CRM.LoginUser.obj);

        // 把创建的cookie销毁，只能覆盖
        Cookie[] cookies = request.getCookies();
        for (int i = 0; i < cookies.length - 1; i++) {
            Cookie cookie = new Cookie(cookies[i].getName(), null);
            cookie.setPath("/");
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
        return "redirect:/login.html";
    }

    @RequestMapping("/getUserById.json")
    public User getUserById(String loginAct) {
        return userService.getUserById(loginAct);
    }

    @RequestMapping("/add.do")
    public Map add(HttpServletRequest request) {
        User user = MyAddUtils.getObject(User.class, request);
        userService.add(user);
        return new HashMap() {{
            put("success", "操作成功!");
        }};
    }
}
