package com.lwc.pojo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

@Data
public class Page implements Serializable {
    // 以下属性中，当前页和每页显示的记录数是页面传递过来的条件
    private Integer currentPage = 1;        // 当前页
    private Integer rowsPerPage = 10;       // 每页显示的记录条数
    private Integer maxRowsPerPage = 100;   // 每页最多显示的记录条数
    private Integer visiblePageLinks = 10;  // 显示几个卡片

    // 以下三个属性，需要在后台计算得到
    private Integer totalRows;              // 总记录条数
    private Integer totalPages;             // 总页数
    private List data;                      // 当前页数据

    private Map condition;

    public Page() {
    }

    public Page(Integer currentPage, Integer rowsPerPage, Integer maxRowsPerPage, Integer visiblePageLinks, Integer totalRows, Integer totalPages, List data, Map condition) {
        this.currentPage = currentPage;
        this.rowsPerPage = rowsPerPage;
        this.maxRowsPerPage = maxRowsPerPage;
        this.visiblePageLinks = visiblePageLinks;
        this.totalRows = totalRows;
        this.totalPages = totalPages;
        this.data = data;
        this.condition = condition;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        if (currentPage != null)
            this.currentPage = currentPage;
    }

    public Integer getRowsPerPage() {
        return rowsPerPage;
    }

    public void setRowsPerPage(Integer rowsPerPage) {
        if (rowsPerPage != rowsPerPage)
            this.rowsPerPage = rowsPerPage;
    }

    public Integer getMaxRowsPerPage() {
        return maxRowsPerPage;
    }

    public void setMaxRowsPerPage(Integer maxRowsPerPage) {
        this.maxRowsPerPage = maxRowsPerPage;
    }

    public Integer getVisiblePageLinks() {
        return visiblePageLinks;
    }

    public void setVisiblePageLinks(Integer visiblePageLinks) {
        this.visiblePageLinks = visiblePageLinks;
    }

    public Integer getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(Integer totalRows) {
        this.totalRows = totalRows;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }

    public Map getCondition() {
        return condition;
    }

    public void setCondition(Map condition) {
        this.condition = condition;
    }
}
