package com.lwc.service;

import com.lwc.pojo.Activities;

import java.util.List;
import java.util.Map;

public interface ActivitiesService {
    List getList(Map searchMap);

    void add(Activities activities);

    void update(Activities activities);

    void del(String[] ids);

    Activities getActivitiesById(String id);

    void addList(List<Activities> list);

    List relationClue(String id);
}
