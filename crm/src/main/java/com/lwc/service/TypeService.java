package com.lwc.service;

import com.lwc.pojo.Type;

import java.util.List;

public interface TypeService {
    List<Type> getTypeAll();

    void save(Type type);

    boolean getIsExist(String id);

    Type getTypeById(String id);

    void updateType(Type type);

    void delType(String[] ids);
}
