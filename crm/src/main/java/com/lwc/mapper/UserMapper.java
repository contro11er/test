package com.lwc.mapper;

import com.lwc.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    User login(@Param("loginAct") String loginAct,@Param("loginPwd") String loginPwd);

    User getUserById(String loginAct);

    void add(User user);

    List getList();

}
