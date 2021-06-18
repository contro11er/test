package com.lwc.service.impl;

import com.lwc.mapper.ActivitiesRemarkMapper;
import com.lwc.pojo.ActivitiesRemark;
import com.lwc.service.ActivitiesRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivitiesRemarkServiceImpl implements ActivitiesRemarkService {

    @Autowired
    private ActivitiesRemarkMapper activitiesRemarkMapper;

    @Override
    public ActivitiesRemark getARById(String id) {
        return activitiesRemarkMapper.getARById(id);
    }

    @Override
    public List<ActivitiesRemark> getARByIdList(String id) {
        return activitiesRemarkMapper.getARByIdList(id);
    }

    @Override
    public void delAR(String id) {
        activitiesRemarkMapper.delAR(id);
    }

    @Override
    public List<ActivitiesRemark> getARList() {
        return activitiesRemarkMapper.getARList();
    }

    @Override
    public void add(ActivitiesRemark activitiesRemark) {
        activitiesRemarkMapper.add(activitiesRemark);
    }

    @Override
    public void edit(ActivitiesRemark activitiesRemark) {
        activitiesRemarkMapper.edit(activitiesRemark);
    }

}
