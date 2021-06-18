package com.lwc.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class ActivitiesRemark implements Serializable {

    private String id;
    private String notePerson;
    private String noteContent;
    private String noteTime;
    private String editPerson;
    private String editTime;
    private String editFlag;
    private String marketingActivitiesId;


}
