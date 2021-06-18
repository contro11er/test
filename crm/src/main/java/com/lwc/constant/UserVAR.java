package com.lwc.constant;

//枚举类
public enum UserVAR {
//   用的时候要通过get方式获取值

    OBJ("YUEHBVD"),
    ACCOUNT("GHNKDIUIHI"),
    PASSWORD("GJNUIGHRI");

    private String message;

    UserVAR(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
