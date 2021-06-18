package com.lwc.utils;

import com.lwc.constant.CRM;
import com.lwc.constant.UserVAR;

import java.util.HashMap;
import java.util.Map;

public class AjaxDo {
    public static final Map SUCCESS = new HashMap() {{
        put("success", true);
        put("msg", CRM.MAS.success);
    }};

}
