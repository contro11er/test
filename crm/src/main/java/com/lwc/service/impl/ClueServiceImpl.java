package com.lwc.service.impl;

import com.lwc.mapper.ActivityClueMapper;
import com.lwc.mapper.ClueMapper;
import com.lwc.pojo.ActivityClue;
import com.lwc.pojo.Clue;
import com.lwc.pojo.Page;
import com.lwc.service.ClueService;
import com.lwc.utils.MyPageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueMapper clueMapper;
    @Autowired
    private ActivityClueMapper activityClueMapper;

    @Override
    public Page getLikeList(Map map) {

        Page page = new Page();
        Integer num = clueMapper.getNum(map);
        MyPageHelper.PageHelper(page, map, num);
        //查询clue的集合封装入map中
        List list = clueMapper.getLikeList(map);
        page.setData(list);
        return page;
    }

    @Override
    public void addRelation(String clueId, String[] activityId) {
//        先删除所有关联的逻辑
        activityClueMapper.del(clueId);

        if (activityId != null) {
            List list = new ArrayList();
            for (String s : activityId) {
                ActivityClue activityClue = new ActivityClue();
                activityClue.setId(UUID.randomUUID().toString().replaceAll("-", ""));
                activityClue.setActivityId(s);
                activityClue.setClueId(clueId);
                list.add(activityClue);
            }
            activityClueMapper.addList(list);
        }
    }
}
