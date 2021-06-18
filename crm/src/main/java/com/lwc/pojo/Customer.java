package com.lwc.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class Customer implements Serializable {
    private String id;
    private String owner;
    private String name;
    private String phone;
    private String website;
    private String description;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String contactSummary;
    private String nextContactTime;
    private String address;

}
