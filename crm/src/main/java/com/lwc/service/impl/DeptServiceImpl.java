package com.lwc.service.impl;

import com.lwc.mapper.DeptMapper;
import com.lwc.pojo.Dept;
import com.lwc.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class DeptServiceImpl implements DeptService {

    @Autowired
    private DeptMapper deptMapper;

    @Override
    public List<Dept> getAll() {
        return deptMapper.getAll();
    }

    @Override
    public void save(Dept dept) {
        String id = UUID.randomUUID().toString().replaceAll("-", "");
        dept.setId(id);
        deptMapper.save(dept);
    }

    @Override
    public Dept getDeptById(String id) {
        return deptMapper.getDeptById(id);
    }

    @Override
    public void del(String[] ids) {
        deptMapper.del(ids);
    }

    @Override
    public void update(Dept dept) {
        deptMapper.update(dept);
    }
}
