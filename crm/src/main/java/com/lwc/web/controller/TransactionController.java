package com.lwc.web.controller;


import com.lwc.pojo.Page;

import com.lwc.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/transaction")
public class TransactionController {

    @Autowired
    private TransactionService transactionService;

    @RequestMapping("/getList.json")
    public Page getList(Page page) {
        transactionService.getList(page);
        return page;
    }

    @RequestMapping("/getNameLike.do")
    public List getNameLike(String name) {
        return transactionService.getNameLike(name);
    }

    @RequestMapping("/getDate.json")
    public List getDate() {
        List lsit= transactionService.getDate();
        return lsit;
    }
}
