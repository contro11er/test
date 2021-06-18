package com.lwc.web.controller;

import com.lwc.constant.CRM;
import com.lwc.pojo.Activities;
import com.lwc.pojo.ActivitiesRemark;
import com.lwc.pojo.User;
import com.lwc.service.ActivitiesRemarkService;
import com.lwc.service.ActivitiesService;
import com.lwc.utils.AjaxDo;
import com.lwc.utils.MyAddUtils;
import com.lwc.utils.MyNowTime;
import com.lwc.utils.MyUpdateUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.*;

@Controller
@ResponseBody
@RequestMapping("/activities")
public class ActivitiesController {

    @Autowired
    private ActivitiesService activitiesService;

    @Autowired
    private ActivitiesRemarkService activitiesRemarkService;

    @RequestMapping("/getList.json")
    public List getList(@RequestParam Map searchMap) {
        return activitiesService.getList(searchMap);
    }

    @RequestMapping("/getActivitiesById.json")
    public Activities getActivitiesById(String id) {
        return activitiesService.getActivitiesById(id);
    }

    @RequestMapping("/add.do")
    public Map add(HttpServletRequest request) {
        activitiesService.add(MyAddUtils.getObject(Activities.class, request));
        return AjaxDo.SUCCESS;
    }

    @RequestMapping("/update.do")
    public Map update(HttpServletRequest request) {
        activitiesService.update(MyUpdateUtils.getObject(Activities.class, request));
        return AjaxDo.SUCCESS;
    }

    @RequestMapping("/del.do")
    public Map del(String[] ids) {
        activitiesService.del(ids);
        return AjaxDo.SUCCESS;
    }

    //表格里不能出现纯数字
    @RequestMapping("/import.do")
    public Map importDate(MultipartFile mf, HttpSession session) throws Exception {
        HSSFWorkbook excel = new HSSFWorkbook(mf.getInputStream());
        //获取第一个页签
        HSSFSheet sheet = excel.getSheetAt(0);
        //获取第二行，因为第一行都是表头，不用
        int index = 1;
        HSSFRow row;
        List<Activities> list = new ArrayList();
        User user = (User) session.getAttribute(CRM.LoginUser.obj);

        while ((row = sheet.getRow(index++)) != null) {
            Activities activities = new Activities();
            activities.setId(UUID.randomUUID().toString().replaceAll("-", ""));
            activities.setCreateBy(user.getName());
            activities.setCreateTime(MyNowTime.getYD());
            int rowIndex = 0;
            activities.setName(row.getCell(rowIndex++).getStringCellValue());
            activities.setOwner(row.getCell(rowIndex++).getStringCellValue());
            activities.setStartDate(row.getCell(rowIndex++).getStringCellValue());
            activities.setEndDate(row.getCell(rowIndex++).getStringCellValue());
            list.add(activities);
        }
        activitiesService.addList(list);
        return AjaxDo.SUCCESS;
    }

    @RequestMapping("/export.do")
    public void exportDate(HttpServletResponse response) throws Exception {
//         获取操作excel对象
        HSSFWorkbook excel = new HSSFWorkbook();
//        创建页签 Sheet
        HSSFSheet sheet = excel.createSheet();
//        创建第一行,设置头
        String[] head = {"名称", "所有者", "开始日期", "结束日期"};
        HSSFRow row = sheet.createRow(0);
        for (int i = 0; i < head.length; i++) {
            HSSFCell cell = row.createCell(i);
            cell.setCellValue(head[i]);
        }
//        数据准备
        List<Activities> list = activitiesService.getList(new HashMap());
//       遍历创建行，单元格，添加数据
        int rowIndex = 1;
        for (Activities activities : list) {
            HSSFRow row1 = sheet.createRow(rowIndex++);
            int colIndex = 0;
            row1.createCell(colIndex++).setCellValue(activities.getName());
            row1.createCell(colIndex++).setCellValue(activities.getOwner());
            row1.createCell(colIndex++).setCellValue(activities.getStartDate());
            row1.createCell(colIndex++).setCellValue(activities.getEndDate());
        }
//      设置下载的文件名
        response.setHeader("Content-Disposition", "attachment;filename=Activity" + MyNowTime.getNT() + ".xls");
        //获取输出流
        ServletOutputStream os = response.getOutputStream();
        //将此工作簿写出到OutputStream.
        excel.write(os);
        //关闭流
        excel.close();
        os.close();
    }

    @RequestMapping("/download.do")
    public void download(HttpServletResponse response, HttpServletRequest request) throws Exception {

        String filename = "下载的文件.txt";
        //下载的文件包含了中文需要经过处理
        // 获取浏览器类型，通过请求头中的User-Agent来判断
        String ua = request.getHeader("User-Agent");
        boolean IE_LT11 = ua.contains("MSIE"); // IE11以下版本
        boolean IE11 = ua.contains("rv:11.0) like Gecko"); // IE11
        boolean Edge = ua.contains("Edge"); // win10自带的Edge浏览器
        // 如果是微软的浏览器，直接进行UTF-8编码
        if (IE_LT11 || IE11 || Edge) {
            filename = URLEncoder.encode(filename, "UTF-8");
            // java和浏览器对UTF-8编码方式有略微的不同：对于空格，java编码后的结果是加号，
            // 而浏览器的编码结果是%20，因此将+替换成%20, 这样浏览器才能正确解析空格
            filename = filename.replace("+", "%20");
        }
        // 标准浏览器使用Base64编码
        else {
            BASE64Encoder encoder = new BASE64Encoder();
            filename = encoder.encode(filename.getBytes("utf-8"));
            // =?utf-8?B?文件名?= 是告诉浏览器以Base64进行解码
            filename = "=?utf-8?B?" + filename + "?=";
        }

        // 告诉浏览器，不要解析文件，要以附件的形式下载
        response.setHeader("Content-Disposition", "attachment;filename=" + filename);
        //获取输出流
        ServletOutputStream os = response.getOutputStream();
        //创建输入流
        InputStream is = new FileInputStream(new File("D:\\ceshi.txt"));
        byte[] b = new byte[1024];
        int len = 0;
        while ((len = is.read(b)) != -1) {
            //将指定 byte 数组中从偏移量 off 开始的 len 个字节写入此输出流。
            os.write(b, 0, len);
        }
        os.close();
        is.close();

        /*
        PrintWriter以字符为单位，支持汉字，
        OutputStreamWriter以字节为单位，不支持汉字，
        处理人要看得懂的东西就用PrintWriter，字符
        处理机器看的东西就用OutputStreamWriter，二进制
        */
    }

    @RequestMapping("/getARListById.json")
    public List<ActivitiesRemark> getARList(String id) {
        return activitiesRemarkService.getARByIdList(id);
    }

    @RequestMapping("/getARById.json")
    public ActivitiesRemark getARById(String id) {
        return activitiesRemarkService.getARById(id);
    }

    @RequestMapping("/delAR.do")
    public Map delAR(String id) {
        activitiesRemarkService.delAR(id);
        return AjaxDo.SUCCESS;
    }

    @RequestMapping("/addOrEdit.do")
    public Map addOrEdi(ActivitiesRemark activitiesRemark, HttpSession session) {
        User user = (User) session.getAttribute(CRM.LoginUser.obj);
        String nowTime = MyNowTime.getNT();
        String username = user.getName();
        String loginAct = user.getLoginAct();
        String ep = loginAct + "(" + username + ")";
        String id = activitiesRemark.getId();
        if ("".equals(id) || id == null) {
            activitiesRemark.setId(UUID.randomUUID().toString().replaceAll("-", ""));
            activitiesRemark.setNoteTime(nowTime);
            activitiesRemark.setNotePerson(ep);
            activitiesRemarkService.add(activitiesRemark);
        } else {
            activitiesRemark.setEditTime(nowTime);
            activitiesRemark.setEditPerson(ep);
            activitiesRemarkService.edit(activitiesRemark);
        }
        return AjaxDo.SUCCESS;
    }

    @RequestMapping("/relationClue.json")
    public List relationClue(String id){
        return activitiesService.relationClue(id);
    }
}
