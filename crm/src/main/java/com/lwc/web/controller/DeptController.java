package com.lwc.web.controller;

import com.lwc.pojo.Dept;
import com.lwc.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@ResponseBody
@RequestMapping("/dept")
public class DeptController {

    @Autowired
    private DeptService deptService;

    @RequestMapping("/getAll.json")
    public List getAll() {
        return deptService.getAll();
    }

    @RequestMapping("/save.json")
    public Boolean save(Dept dept) {
        deptService.save(dept);
        return true;
    }

    @RequestMapping("/getDeptById.json")
    public Dept getDeptById(String id) {
        Dept dept = deptService.getDeptById(id);
        return dept;
    }

    @RequestMapping("/update.json")
    public boolean update(Dept dept) {
        deptService.update(dept);
        return true;
    }

    @RequestMapping("/del.json")
    public boolean del(String[] ids) {
        deptService.del(ids);
        return true;
    }

}
