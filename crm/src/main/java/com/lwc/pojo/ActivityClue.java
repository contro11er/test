package com.lwc.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class ActivityClue implements Serializable {
    private String id;
    private String clueId;
    private String activityId;

}
