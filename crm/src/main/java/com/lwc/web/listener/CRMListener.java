package com.lwc.web.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.ResourceBundle;

//配置版本，避免修改jq文件时，浏览器无法及时更新(只能通过清除缓存)
@WebListener
public class CRMListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ResourceBundle rb = ResourceBundle.getBundle("version");
        String version = rb.getString("version");
        sce.getServletContext().setAttribute("version", version);
    }
}
