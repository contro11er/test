package com.lwc.service.impl;

import com.lwc.mapper.ActivitiesMapper;
import com.lwc.pojo.Activities;
import com.lwc.service.ActivitiesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ActivitiesServiceImpl implements ActivitiesService {

    @Autowired
    private ActivitiesMapper activitiesMapper;

    @Override
    public List getList(Map searchMap) {
        return activitiesMapper.getList(searchMap);
    }

    @Override
    public void add(Activities activities) {
        activitiesMapper.add(activities);
    }

    @Override
    public void update(Activities activities) {
        activitiesMapper.update(activities);
    }

    @Override
    public void del(String[] ids) {
        activitiesMapper.del(ids);
    }

    @Override
    public Activities getActivitiesById(String id) {
        return activitiesMapper.getActivitiesById(id);
    }

    @Override
    public void addList(List<Activities> list) {
        activitiesMapper.addList(list);
    }

    @Override
    public List relationClue(String id) {
        return activitiesMapper.relationClue(id);
    }
}
