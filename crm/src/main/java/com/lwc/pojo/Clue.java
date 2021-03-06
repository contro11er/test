package com.lwc.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class Clue implements Serializable {

    private String id;
    private String owner;
    private String company;
    private String phone;
    private String website;
    private String description;
    private String fullName;
    private String appellation;
    private String source;
    private String email;
    private String mphone;
    private String job;
    private String state;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String contactSummary;
    private String nextContactTime;
    private String address;

}
