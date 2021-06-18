package com.lwc.service.impl;

import com.lwc.mapper.ValueMapper;
import com.lwc.pojo.Value;
import com.lwc.service.ValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class ValueServiceImpl implements ValueService {


    @Autowired
    private ValueMapper valueMapper;

    @Override
    public List<Value> getAll() {
        return valueMapper.getAll();
    }

    @Override
    public void save(Value value) {
        String id = UUID.randomUUID().toString().replaceAll("-", "");
        value.setId(id);
        valueMapper.save(value);
    }

    @Override
    public void edit(Value value) {
        valueMapper.edit(value);
    }

    @Override
    public Value getValueByid(String id) {
        return valueMapper.getValueByid(id);
    }

    @Override
    public void del(String[] id) {
        valueMapper.del(id);
    }

    @Override
    public List<Value> getAll2() {
        return valueMapper.getAll2();
    }
}
