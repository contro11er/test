package com.lwc.web.controller;

import com.lwc.pojo.Page;
import com.lwc.service.ClueService;
import com.lwc.utils.AjaxDo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/clue")
public class ClueController {

    @Autowired
    private ClueService clueService;

    @RequestMapping("/getLikeList.json")
    public Page getLikeList(@RequestParam Map map) {
        return clueService.getLikeList(map);
    }

    @RequestMapping("/addRelation.do")
    public Map addRelation(String clueId,String[] activityId) {
         clueService.addRelation(clueId,activityId);
        return AjaxDo.SUCCESS;
    }


}
