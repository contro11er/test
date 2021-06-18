package com.lwc.web.controller;

import com.lwc.pojo.Type;
import com.lwc.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

@RequestMapping("/type")
@Controller
public class TypeController {
    @Autowired
    private TypeService typeService;

    @RequestMapping("/index.do")
    public ModelAndView getTypeAll(ModelAndView mv) {
        mv.addObject("type", typeService.getTypeAll());
        mv.setViewName("settings/dictionary/type/index");
        return mv;
    }

    @RequestMapping("/isExist.do")
    @ResponseBody
    public boolean isExist(String id) {
        return typeService.getIsExist(id);
    }

    @RequestMapping("/save.do")
    public String save(Type type) {
        typeService.save(type);
        return "redirect:/type/index.do";
    }

    @RequestMapping("/getTypeById.do")
    public ModelAndView getTypeById(String id, ModelAndView mv) {
        Type type = typeService.getTypeById(id);
        mv.addObject("type", type);
        mv.setViewName("settings/dictionary/type/edit");
        return mv;
    }

    @RequestMapping("/update.do")
    public String update(Type type) {
        typeService.updateType(type);
        return "redirect:/type/index.do";
    }

    @RequestMapping(value = "/delType.do")
    public String delType(String[] ids) {
        typeService.delType(ids);
        return "redirect:/type/index.do";
    }

}
