package com.lwc.service;

import com.lwc.pojo.Page;

import java.util.List;

public interface TransactionService {
    void getList(Page page);

    List getNameLike(String name);

    List getDate();

}
