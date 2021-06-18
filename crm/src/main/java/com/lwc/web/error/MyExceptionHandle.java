package com.lwc.web.error;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class MyExceptionHandle {

/*ResponseBody是为了响应ajax*/
    @ExceptionHandler(LoginException.class)
    @ResponseBody
    public Map error(Exception e) {
        e.printStackTrace();
        return new HashMap() {{
            put("msg", e.getMessage());
        }};
    }

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Map errorLast(Exception e) {
        e.printStackTrace();
        return new HashMap() {{
            put("msg", e.getMessage());
        }};
    }
}
