package com.lwc.service;

import com.lwc.pojo.User;

import java.util.List;

public interface UserService {

    User getUser(String loginAct, String loginPwd, String ip);

    User getAutoLogin(String loginAct, String loginPwd, String ip);

    User getUserById(String loginAct);

    void add(User user);

    List getList();

}
