package com.lwc.mapper;

import com.lwc.pojo.Clue;

import java.util.List;
import java.util.Map;

public interface ClueMapper {

    List getLikeList(Map map);

    Integer getNum(Map map);

    void add(Clue clue);

    void addList(List list);

}
