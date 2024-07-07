```
${__time(yyyyMMddHHmmss,time)}
${__Random(100000,999999,)}

String orderNo = "orderNo" + ${__Random(10000,99999,)};
vars.put("orderNo",orderNo);

{
"curDate":"${__time(yyyyMMdd,time)}",  //当天
"curtime":"${__time(yyyyMMddHHmmss,time)}", //当前时间
"curtimeAndRandom":"${__time(yyyyMMddHHmmss,time)}${__Random(10,99,)}", //当前时间+随机
"randomDate":"${__RandomDate(yyyyMMdd,19800101,20211231,,)}", //随机日期
"randomNum":"0${__Random(100,999,)}", //随机数值,可在值前面加任意字符
"randomString":"${__RandomString(1,YN,)}" //随机字符串,可在值前面加任意字符
}

Random random = new Random();

//1身份证 2护照 3港澳台居民身份证 Z 其他
String[] str= new String[]{"1", "2", "3", "Z"};
int a = random.nextInt(str.length);
vars.put("idType",str[a]);
log.info("随机字符:" + str[a]);
```
