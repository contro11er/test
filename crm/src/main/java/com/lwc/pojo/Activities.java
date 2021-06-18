package com.lwc.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class Activities implements Serializable {

    private String id;
    private String owner;
    private String name;
    private String startDate;
    private String endDate;
    private String cost;
    private String description;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
}
