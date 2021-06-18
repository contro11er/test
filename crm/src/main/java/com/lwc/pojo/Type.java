package com.lwc.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class Type implements Serializable {
    private String id;
    private String name;
    private String description;

}
