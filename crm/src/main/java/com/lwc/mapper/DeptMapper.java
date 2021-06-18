package com.lwc.mapper;

import com.lwc.pojo.Dept;

import java.util.List;

public interface DeptMapper {
    List<Dept> getAll();

    void save(Dept dept);

    Dept getDeptById(String id);

    void del(String[] ids);

    void update(Dept dept);

}
