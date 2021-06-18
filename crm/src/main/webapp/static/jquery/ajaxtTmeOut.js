//全局默认的ajax设置，如果没有特定指名属性，默认则按如下配置
// 在success之前执行，如果不返回任何数据，则success不会执行
jQuery.ajaxSetup({
    dataFilter(result) {
        if (result != '') {
            var temp = JSON.parse(result);
            if (temp.url) {
                alert(temp.msg);
                location = decodeURIComponent(temp.url);
                return;
            }
        }
        return result;
    }
});

