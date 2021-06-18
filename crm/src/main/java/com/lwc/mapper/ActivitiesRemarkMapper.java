package com.lwc.mapper;

import com.lwc.pojo.ActivitiesRemark;

import java.util.List;

public interface ActivitiesRemarkMapper {
    ActivitiesRemark getARById(String id);

    List<ActivitiesRemark> getARList();

    List<ActivitiesRemark> getARByIdList(String id);

    void delAR(String id);

    void add(ActivitiesRemark activitiesRemark);

    void edit(ActivitiesRemark activitiesRemark);


}
