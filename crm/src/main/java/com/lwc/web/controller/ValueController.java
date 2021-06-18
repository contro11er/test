package com.lwc.web.controller;

import com.lwc.pojo.Value;
import com.lwc.service.TypeService;
import com.lwc.service.ValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/value")
@Controller
public class ValueController {

    @Autowired
    private ValueService valueService;
    @Autowired
    private TypeService typeService;

    @RequestMapping("/index.html")
    public ModelAndView getAll(ModelAndView mv) {
        mv.addObject("valueList", valueService.getAll());
        mv.setViewName("settings/dictionary/value/index");
        return mv;
    }

    @RequestMapping("/getValueByid.do")
    public ModelAndView getValueByid(ModelAndView mv, String id) {
        mv.addObject("v",valueService.getValueByid(id));
        mv.setViewName("settings/dictionary/value/edit");
        return mv;
    }

    @RequestMapping("/edit.do")
    public String edit(Value value) {
        valueService.edit(value);
        return "redirect:/value/index.html";
    }

    @RequestMapping("/save.html")
    public ModelAndView getTypeList1(ModelAndView mv) {
        mv.addObject("typeList", typeService.getTypeAll());
        mv.setViewName("settings/dictionary/value/save");
        return mv;
    }

    @RequestMapping("/save.do")
    public String save(Value value) {
        valueService.save(value);
        return "redirect:/value/index.html";
    }

    @RequestMapping("/del")
    public String del(String[] id){
        valueService.del(id);
        return "redirect:/value/index.html";
    }
}
