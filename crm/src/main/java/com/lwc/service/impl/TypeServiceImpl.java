package com.lwc.service.impl;

import com.lwc.mapper.TypeMapper;
import com.lwc.pojo.Type;
import com.lwc.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeServiceImpl implements TypeService {

    @Autowired
    private TypeMapper typeMapper;

//    type查询全部列表
    @Override
    public List<Type> getTypeAll() {
        return typeMapper.getTypeAll();
    }

//    type添加
    @Override
    public void save(Type type) {
         typeMapper.save(type);
    }

//    type查找某个ID是否已经存在
    @Override
    public boolean getIsExist(String id) {
        return typeMapper.getIsExist(id);
    }

    @Override
    public Type getTypeById(String id) {
        return typeMapper.getTypeById(id);
    }

    @Override
    public void updateType(Type type) {
        typeMapper.updateType(type);
    }

    @Override
    public void delType(String[] ids) {
        typeMapper.delType(ids);
    }


}
