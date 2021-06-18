package com.lwc.mapper;

import com.lwc.pojo.Page;
import com.lwc.pojo.Tran;

import java.util.List;
import java.util.Map;

public interface TransactionMapper {

    List getList(Map map);

    void add(Tran transaction);

    List getNameLike(String name);

    List getDate();

}
