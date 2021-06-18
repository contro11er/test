package com.lwc.web.listener;

import com.lwc.pojo.Value;
import com.lwc.service.ValueService;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//初始化字典类型
@WebListener
public class InitValueListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 只能从工厂中获取实例
        WebApplicationContext currentWebApplicationContext = ContextLoader.getCurrentWebApplicationContext();
        ValueService valueService = currentWebApplicationContext.getBean(ValueService.class);

        List<Value> valueList = valueService.getAll2();
        Map<String, List<String>> map = new HashMap<>();
        for (Value value : valueList) {
//          获取key，首次肯定为空,相同的key获取的value相同
//          每次获取的value为list，add即可
            List<String> list = map.get(value.getTid());
            if (list == null) {
//          首次为空，创建对象，并且初始化map
                list = new ArrayList();
                map.put(value.getTid(), list);
            }
            list.add(value.getValue());
        }
        sce.getServletContext().setAttribute("zd",map);
    }
}
