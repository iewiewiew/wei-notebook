# API Test Case Examples

## Example 1: Basic GET Request

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC001,apiv5-User,获取用户信息,get,/api/v5/user?access_token={access_token},None,,,,"200,201",,,no
```

**Generated Test:**
```python
@allure.title('TC001-获取用户信息')
def test_get_api_v5_user(self):
    """获取用户信息"""
    path = f"/api/v5/user?access_token={self.access_token}"
    body = None
    response = APIResponse(self.client.send_get_request(path, self.headers))
    response.assert_status((200, 201), '获取用户信息状态码验证')
```

---

## Example 2: POST with Request Body

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC002,apiv5-Issues,创建Issue,post,/api/v5/repos/{enterprise_path}/issues,"{""access_token"": ""{access_token}"", ""repo"": ""{project_path}"", ""title"": ""测试工作项"", ""body"": ""内容""}",,self.__class__.issue_id = response.data['id'],,"200,201",,,no
```

**Generated Test:**
```python
@allure.title('TC002-创建Issue')
def test_post_api_v5_repos_enterprise_path_issues(self):
    """创建Issue"""
    path = f"/api/v5/repos/{self.enterprise_path}/issues"
    body = {"access_token": self.access_token, "repo": self.project_path, "title": "测试工作项", "body": "内容"}
    response = APIResponse(self.client.send_post_request(path, body, self.headers))
    self.__class__.issue_id = response.data['id']
    response.assert_status((200, 201), '创建Issue状态码验证')
```

---

## Example 3: Resource Lifecycle (Create → Update → Delete)

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC010,apiv5-Repos,创建企业仓库,post,/api/v5/enterprises/{enterprise_path}/repos,"{""access_token"": ""{access_token}"", ""name"": f""test_{time}"", ""path"": f""test_{time}"", ""private"": 0}",,self.__class__.repo_id = response.data['id']\nself.__class__.repo_path = response.data['path'],,"200,201",,,no
TC011,apiv5-Repos,更新仓库设置,patch,/api/v5/repos/{enterprise_path}/{repo_path},"{""access_token"": ""{access_token}"", ""description"": ""更新描述""}",,,TC010,"200,201",,,no
TC012,apiv5-Repos,删除仓库,delete,/api/v5/repos/{enterprise_path}/{repo_path}?access_token={access_token},None,,,TC010,"200,201,204",,,no
```

**Note:** The `depends_on` field ensures tests run in order. Variables like `{repo_path}` are extracted from previous test responses.

---

## Example 4: File Upload

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC020,apiv5-Attachments,上传附件(upload),post,/api/v5/repos/{enterprise_path}/{project_path}/attachments,"{""access_token"": ""{access_token}""}",/test_image.png,,"200,201",,,no
```

**Generated Test:**
```python
@allure.title('TC020-上传附件(upload)')
def test_post_api_v5_repos_attachments_upload(self):
    """上传附件(upload)"""
    path = f"/api/v5/repos/{self.enterprise_path}/{self.project_path}/attachments"
    form_data = {"access_token": self.access_token}
    file_path = self.file_path + '/test_image.png'
    response = APIResponse(self.client.upload_file(path, file_path, form_data, self.headers))
    response.assert_status((200, 201), '上传附件状态码验证')
```

---

## Example 5: File Download

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC030,apiv5-Export,导出仓库文件(download),get,/api/v5/repos/{enterprise_path}/{project_path}/archive/master.zip?access_token={access_token},None,,,,"200,201",,,no
```

**Generated Test:**
```python
@allure.title('TC030-导出仓库文件(download)')
def test_get_api_v5_repos_archive_download(self):
    """导出仓库文件(download)"""
    path = f"/api/v5/repos/{self.enterprise_path}/{self.project_path}/archive/master.zip?access_token={self.access_token}"
    os.makedirs(self.download_file_path, exist_ok=True)
    self.client.download_file(path, self.download_file_path, self.headers)
```

---

## Example 6: Async Operation

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC040,apiv5-Pipeline,触发流水线(asyncio),post,/api/v5/enterprises/{enterprise_path}/pipelines,"{""access_token"": ""{access_token}"", ""branch"": ""master""}",,self.__class__.pipeline_id = response.data['id'],,"200,201",,,no
```

**Generated Test:**
```python
@allure.title('TC040-触发流水线(asyncio)')
async def test_post_api_v5_pipelines_trigger(self):
    """触发流水线(asyncio)"""
    path = f"/api/v5/enterprises/{self.enterprise_path}/pipelines"
    body = {"access_token": self.access_token, "branch": "master"}
    response = APIResponse(self.client.send_post_request(path, body, self.headers))
    self.__class__.pipeline_id = response.data['id']
    response.assert_status((200, 201), '触发流水线状态码验证')
    await asyncio.sleep(3)
```

---

## Example 7: Custom Assertions

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC050,apiv5-Repos,获取仓库列表,get,/api/v5/user/repos?access_token={access_token}&page=1&per_page=10,None,,,,"200,201",len(response.data) > 0,,no
```

**Generated Test:**
```python
@allure.title('TC050-获取仓库列表')
def test_get_api_v5_user_repos(self):
    """获取仓库列表"""
    path = f"/api/v5/user/repos?access_token={self.access_token}&page=1&per_page=10"
    body = None
    response = APIResponse(self.client.send_get_request(path, self.headers))
    response.assert_status((200, 201), '获取仓库列表状态码验证')
    response.assert_value(len(response.data) > 0)
```

---

## Example 8: Pytest Markers

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC060,apiv5-Admin,管理员操作,post,/api/v5/admin/action,"{""access_token"": ""{access_token}""}",,,,"200,201",,@pytest.mark.skipif(reason="需要管理员权限"),no
```

---

## Example 9: Parameterized Tests

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC070,apiv5-Search,搜索仓库,get,/api/v5/search/repositories?q={keyword}&access_token={access_token},None,pytest.mark.parametrize("keyword", ["python", "java", "golang"]),,"200,201",,,no
```

**Generated Test:**
```python
@pytest.mark.parametrize("keyword", ["python", "java", "golang"])
@allure.title('TC070-搜索仓库')
def test_get_api_v5_search_repositories(self, keyword):
    """搜索仓库"""
    path = f"/api/v5/search/repositories?q={keyword}&access_token={self.access_token}"
    body = None
    response = APIResponse(self.client.send_get_request(path, self.headers))
    response.assert_status((200, 201), '搜索仓库状态码验证')
```

---

## Example 10: Base64 Image Upload

**CSV Test Data:**
```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC080,apiv5-Issues,上传图片(/test_image.png),post,/api/v5/repos/{enterprise_path}/{project_path}/issues/images,"{""access_token"": ""{access_token}""}",,self.__class__.image_url = response.data['url'],,"200,201",,,no
```

**Generated Test:**
```python
@allure.title('TC080-上传图片')
def test_post_api_v5_issues_images_upload(self):
    """上传图片"""
    path = f"/api/v5/repos/{self.enterprise_path}/{self.project_path}/issues/images"
    body = {"access_token": self.access_token}
    image_file_path = self.file_path + '/test_image.png'
    response = APIResponse(self.client.upload_image_with_base64(path, image_file_path, body, self.headers))
    self.__class__.image_url = response.data['url']
    response.assert_status((200, 201), '上传图片状态码验证')
```
