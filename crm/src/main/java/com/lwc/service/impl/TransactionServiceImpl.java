package com.lwc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lwc.mapper.TransactionMapper;
import com.lwc.pojo.Page;
import com.lwc.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionServiceImpl implements TransactionService {

    @Autowired
    private TransactionMapper transactionMapper;

    @Override
    public void getList(Page page) {
        PageHelper.startPage(page.getCurrentPage(), page.getRowsPerPage());
        List list = transactionMapper.getList(page.getCondition());
        PageInfo pageInfo = new PageInfo(list);
        page.setTotalPages(Integer.parseInt(pageInfo.getTotal() + ""));
        page.setTotalRows(pageInfo.getPages());
        page.setData(list);
    }

    @Override
    public List getNameLike(String name) {
        return transactionMapper.getNameLike(name);
    }

    @Override
    public List getDate() {
        return transactionMapper.getDate();
    }
}
