import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lwc.mapper.ClueMapper;
import com.lwc.mapper.DeptMapper;
import com.lwc.mapper.TransactionMapper;
import com.lwc.mapper.ValueMapper;
import com.lwc.pojo.Clue;
import com.lwc.pojo.Page;
import com.lwc.pojo.Tran;
import com.lwc.pojo.Value;
import com.lwc.service.ValueService;
import com.lwc.utils.MyNowTime;
import org.apache.ibatis.transaction.Transaction;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class MyTest {

    @Autowired
    private ValueService valueService;

    @Autowired
    private TransactionMapper transactionMapper;

    @Test
    public void test01() {
        List<Value> list = valueService.getAll();
        Map<String, List<String>> map = new HashMap<>();
//遍历每个value
        for (Value value : list) {
            List<String> list1 = map.get(value.getTid());
            if (list1 == null) {
                list1 = new ArrayList<>();
            }
            list1.add(value.getValue());
            map.put(value.getTid(), list1);
        }
        System.out.println(map);
    }

 @Test
    public void test07() {
     List<Value> valueList = valueService.getAll();
//      把同类的分成一组
     Map<String, List<String>> map = new HashMap<>();
     for (Value value : valueList) {
//          获取key，首次肯定为空,相同的key获取的value相同
//          每次获取的value为list，add即可
         List<String> list = map.get(value.getTid());
         if (list == null) {
//          首次为空，创建对象，并且初始化map
             list = new ArrayList();
             map.put(value.getTid(), list);
         }
         list.add(value.getValue());
     }
     System.out.println(map);

     Iterator<String> iterator = map.keySet().iterator();
     while (iterator.hasNext()){
         String next = iterator.next();
         System.out.println(next);
     }

 }
 @Test
    public void test08() {

     String[] stage = {"01资质审查", "02需求分析", "03价值建议", "04确定决策者", "05提案/报价", "06谈判/复审", "07成交", "08丢失的线索", "09因竞争丢失关闭"};
     Random random = new Random();

     for (int i = 1; i <= 123; i++) {
         Tran transaction = new Tran();
         transaction.setStage(stage[random.nextInt(9)]);
         transaction.setId(UUID.randomUUID().toString().replaceAll("-", ""));
         transaction.setCustomerId("1");
         transaction.setContactsId("1");
         transactionMapper.add(transaction);
     }
 }

//    @Test
//    public void test01(HttpServletResponse response) throws Exception {
//        //获取excel对象
//        HSSFWorkbook sheets = new HSSFWorkbook();
//        // 创建页签Sheet
//        HSSFSheet sheet = sheets.createSheet();
//
//        for (int i = 0; i < 10; i++) {
//            //创建第一行，0下标开始
//            HSSFRow row = sheet.createRow(i);
//            //创建第一个单元格 (第一行第一个单元格,0下标开始)
//            for (int j = 0; j < 10; j++) {
//                HSSFCell cell = row.createCell(j);
//                //设置单元格的值
//                cell.setCellValue("i*j=" + (i * j));
//            }
//        }
//
////      Content-Disposition如何显示附加的文件 (显示的文件名)
////      服务端向客户端游览器发送文件时，如果是浏览器支持的文件类型，
////      一般会默认使用浏览器打开，比如txt、jpg等，会直接在浏览器中显示，
////      如果需要提示用户保存，就要利用Content-Disposition进行一下处理，
////      关键在于一定要加上attachment：
//        response.setHeader("Content-Disposition", "attachment;filename=Activity" + MyNowTime.getNT() + ".xls");
////      将excel响应写到响应体中
//        ServletOutputStream os = response.getOutputStream();
//        sheets.write(os);
////      关闭流
//        os.close();
//        sheets.close();
//
//    }

    @Test
    public void test02() {
        System.out.println("MyNowTime.getYD() = " + MyNowTime.getYD());
    }


    @Test
    public void test03() {
//        PageHelper pageHelper = new PageHelper();
        PageHelper.startPage(1,10);
        List<Value> all = valueService.getAll();
        System.out.println(all);
    }


    @Test
    public void test04() {
        System.out.println("zzz");
    }


    @Test
    public void test05() {
            for (int i = 1; i <= 123; i++) {
                Tran transaction = new Tran();

                transaction.setId(UUID.randomUUID().toString().replaceAll("-",""));
                transaction.setCustomerId("1");
                transaction.setContactsId("1");
                transaction.setName("交易"+ i);
                transactionMapper.add(transaction);
            }

    }

    @Test
    public void test06() {
        Page page = new Page();
        page.setCurrentPage(1);
        page.setRowsPerPage(10);
        PageHelper.startPage(page.getCurrentPage(), page.getRowsPerPage());
        List list = transactionMapper.getList(page.getCondition());
        PageInfo pageInfo = new PageInfo(list);
        page.setTotalPages(Integer.parseInt(pageInfo.getTotal() + ""));
        page.setTotalRows(pageInfo.getPages());

    }
}
