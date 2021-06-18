package com.lwc.utils;

import com.lwc.pojo.Page;

import java.util.List;
import java.util.Map;

public class MyPageHelper {
    //查询条件map，总记录数totalRows，查询集合list
    public static Map PageHelper(Page page,Map map, Integer totalRows) {
//      关键点1：如果当前用户没有传递当前页，则默认取值
        String currentPageStr = (String) map.get("currentPage");
//      判断是否取到值
        Integer currentPage = null;
        if (currentPageStr == null || "".equals(currentPageStr)) {
            currentPage = page.getCurrentPage();//获取设置的初始化的值
        } else {
            currentPage = Integer.valueOf(currentPageStr);
        }
//        把获取的当前页放到page中，前端需要使用
        page.setCurrentPage(currentPage);

//        同理，每页显示多少数据rowsPerPage
        String rowsPerPageStr = (String) map.get("rowsPerPage");
//      判断是否取到值
        Integer rowsPerPage = null;
        if (rowsPerPageStr == null || "".equals(rowsPerPageStr)) {
            rowsPerPage = page.getRowsPerPage();//获取设置的初始化的值
        } else {
            rowsPerPage = Integer.valueOf(rowsPerPageStr);
        }
        page.setRowsPerPage(rowsPerPage);
//      把查询条件放到map中作为条件去查询
        map.put("rowsPerPage", rowsPerPage);
//获取总条数...
        page.setTotalPages(totalRows);
//计算有多少页=(总条数减1/每页的数据)+1
        Integer totalPages = (totalRows - 1) / rowsPerPage + 1;
        page.setTotalPages(totalPages);
//计算当前页码起始位置 (当前页-1)*每页显示的数量
        Integer startIndex = (currentPage - 1) * rowsPerPage;
        map.put("startIndex", startIndex);

        return map;
    }
}
