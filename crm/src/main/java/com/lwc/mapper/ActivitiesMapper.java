package com.lwc.mapper;

import com.lwc.pojo.Activities;

import java.util.List;
import java.util.Map;

public interface ActivitiesMapper {
    List getList(Map searchMap);

    void add(Activities activities);

    void update(Activities activities);

    void del(String[] ids);

    Activities getActivitiesById(String id);

    void addList(List<Activities> list);

    List relationClue(String id);
}
