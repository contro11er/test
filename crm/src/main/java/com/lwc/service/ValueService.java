package com.lwc.service;

import com.lwc.pojo.Type;
import com.lwc.pojo.Value;

import java.util.List;

public interface ValueService {
    List<Value> getAll();

    void save(Value value);

    void edit(Value value);

    Value getValueByid(String id);

    void del(String[] id);

    List<Value> getAll2();
}
