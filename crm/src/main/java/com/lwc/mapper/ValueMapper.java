package com.lwc.mapper;

import com.lwc.pojo.Value;

import java.util.List;

public interface ValueMapper{
    List<Value> getAll();

    List<Value> getAll2();

    void save(Value value);

    void edit(Value value);

    Value getValueByid(String id);

    void del(String[] id);
}
