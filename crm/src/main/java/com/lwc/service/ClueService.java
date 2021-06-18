package com.lwc.service;

import com.lwc.pojo.Page;
import java.util.Map;

public interface ClueService {

    Page getLikeList(Map map);

    void addRelation(String clueId,String[] activityId);


}
