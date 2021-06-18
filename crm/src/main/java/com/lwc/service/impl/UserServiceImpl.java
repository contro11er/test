package com.lwc.service.impl;

import com.lwc.mapper.UserMapper;
import com.lwc.pojo.User;
import com.lwc.service.UserService;
import com.lwc.utils.MD5Util;
import com.lwc.web.error.LoginException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {


    @Autowired
    private UserMapper userMapper;

    //    登录
    @Override
    public User getUser(String loginAct, String loginPwd, String ip) {

        loginPwd = MD5Util.getMD5(loginPwd);
        User user = userMapper.login(loginAct, loginPwd);

        if (user == null) {
            throw new LoginException("账号/密码错误");
        }

        //获取该对象时长,判断该账号是否已经过了登录时限
        String expireTime = user.getExpireTime();
        if (StringUtils.isNotBlank(expireTime)) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                //数据库时间转换为时间戳，用于比较
                long sqlTime = sdf.parse(expireTime).getTime();
                long nowTime = System.currentTimeMillis();
                if (sqlTime < nowTime) {
                    throw new LoginException("登录权限超时");
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        //判断账号状态
        String lockStatus = user.getLockStatus();
        if (lockStatus.equals("0")) {
            throw new LoginException("账号已经被锁定");
        }

        //判断账号是否在可用ip内
        String ips = user.getAllowIps();
        if (StringUtils.isNotBlank(ips)) {
            // 待做
        }
        return user;
    }

    //    自动登录
    @Override
    public User getAutoLogin(String loginAct, String loginPwd, String ip) {
        User user = userMapper.login(loginAct, loginPwd);

        if (user == null) {
            return null;
        }

        //获取该对象时长,判断该账号是否已经过了登录时限
        String expireTime = user.getExpireTime();
        if (StringUtils.isNotBlank(expireTime)) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                //数据库时间转换为时间戳，用于比较
                long sqlTime = sdf.parse(expireTime).getTime();
                long nowTime = System.currentTimeMillis();
                if (sqlTime < nowTime) {
                    return null;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        //判断账号状态
        String lockStatus = user.getLockStatus();
        if (lockStatus.equals("0")) {
            return null;
        }

        //判断账号是否在可用ip内
        String ips = user.getAllowIps();
        if (StringUtils.isNotBlank(ips)) {
            // 待做
        }
        return user;
    }

    @Override
    public User getUserById(String loginAct) {
        return userMapper.getUserById(loginAct);
    }

    @Override
    public void add(User user) {
        String id = UUID.randomUUID().toString().replaceAll("-", "");
        user.setId(id);
        userMapper.add(user);
    }

    @Override
    public List getList() {
        return userMapper.getList();
    }
}
