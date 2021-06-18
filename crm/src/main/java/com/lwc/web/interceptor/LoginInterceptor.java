package com.lwc.web.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwc.constant.CRM;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;


public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (request.getSession().getAttribute(CRM.LoginUser.obj) == null) {
            //如果getHeader(X-Requested-With)能拿到值，并且值为 XMLHttpRequest那是ajax请求了
            if (request.getHeader("X-Requested-With") != null) {
                //获取请求来源的路径
                String url = request.getHeader("Referer");
                String encodeUrl = URLEncoder.encode(url, "UTF-8");
                Map map = new HashMap();
                map.put("msg", "登陆超时");
                map.put("url", "/login.html?redirectUrl=" + encodeUrl);
                response.setContentType("application/json;charset=utf-8");
//                转换成json格式
                ObjectMapper objectMapper = new ObjectMapper();
                String str = objectMapper.writeValueAsString(map);
                response.getWriter().write(str);
            } else {
                //获取请求路径
                String url = request.getRequestURI();
                //对url进行处理，因为 & 符号会丢失参数
                String encodeUrl = URLEncoder.encode(url, "utf-8");
                response.sendRedirect("/login.html?redirectUrl=" + encodeUrl);

            }
            return false;
        }
        return true;
    }
}
