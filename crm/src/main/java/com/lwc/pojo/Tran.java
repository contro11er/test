package com.lwc.pojo;


import lombok.Data;

import java.io.Serializable;

@Data
public class Tran implements Serializable {
    private String id;
    private String owner;
    private String amountOfMoney;
    private String name;
    private String expectedClosingDate;
    private String customerId;
    private String stage;
    private String type;
    private String source;
    private String activityId;
    private String contactsId;
    private String description;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String contactSummary;
    private String nextContactTime;

    private Customer customer;
    private Contacts contacts;
    private Activities activities;

}
