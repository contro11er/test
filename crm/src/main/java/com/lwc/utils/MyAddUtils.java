package com.lwc.utils;

import com.lwc.constant.CRM;
import com.lwc.pojo.User;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;


//实体类中的类型只能是String
public class MyAddUtils {

    public static <T> T getObject(Class<T> clazz, HttpServletRequest request) {
        Object obj = null;
        try {
            Method[] methods = clazz.getDeclaredMethods();
            obj = clazz.newInstance();
            for (Method method : methods) {
                if (method.getName().startsWith("set")) {
                    // 获取方法名
                    String name = method.getName();
                    // 方法名setXXXX  获取XXXX  属性首字母小写
                    String filed = name.substring(3, name.length());
                    String str = filed.substring(0, 1).toLowerCase();
                    String filedName = str + filed.substring(1, filed.length());
                    //从方法名中截取出属性名称 比如setName  属性名为name
                    //属性名,这里可能获取会为空
                    String parameter = request.getParameter(filedName);
//                    UUID生成随机的ID
                    if ("id".equals(filedName)) {
                        method.invoke(obj, UUID.randomUUID().toString().replaceAll("-", ""));
                        continue;
                    }
//                MD5 加密
                    if ("loginPwd".equals(filedName)) {
                        method.invoke(obj, MD5Util.getMD5(parameter));
                        continue;
                    }
//                    自动生成对应的创建时间
                    if ("createTime".equals(filedName)) {
                        Date date = new Date();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        method.invoke(obj, sdf.format(date));
                        continue;
                    }
//                    从session中获取创建人的信息
                    if ("createBy".equals(filedName)) {
                        User user1 = (User) request.getSession().getAttribute(CRM.LoginUser.obj);
                        method.invoke(obj, user1.getName());
                        continue;
                    }
                    method.invoke(obj, parameter);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (T) obj;
    }
}
