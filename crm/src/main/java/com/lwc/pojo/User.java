package com.lwc.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class User implements Serializable {
    private String id;
    private String deptId;
    private String loginAct;
    private String name;
    private String loginPwd;
    private String email;
    private String expireTime;
    private String lockStatus;
    private String allowIps;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;

}
