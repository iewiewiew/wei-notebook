---
name: generate-api-test-cases
description: Generate API test cases for this pytest-based API automation testing project. Use when the user asks to create or generate tests, mentions Swagger/OpenAPI specs, asks about API testing coverage, or mentions pytest framework. Supports generating from CSV test data, Swagger JSON, or API endpoint descriptions.
---

# Generate API Test Cases

This skill guides generation of API test cases following the project's established patterns.

## Project Structure

```
api-autotest/
├── testcase/           # Generated pytest test files (test_api_*.py)
├── testdata/           # Test data files (test_data_*.csv)
├── config/             # Configuration files (config.yaml)
├── utils/              # Utility modules
└── core/               # Core modules including case_generator.py
```

## CSV Test Data Format

Test cases are defined in CSV files with these columns:

| Column | Description | Example |
|--------|-------------|---------|
| test_case_id | Unique identifier | TC001 |
| test_module_name | Module category | apiv5-Repositories |
| test_case_name | Description | 创建企业仓库 |
| request_method | HTTP method | get, post, put, delete |
| path | API endpoint path | /api/v5/repos/{enterprise_path}/{project_path} |
| request_body | Request body (JSON) | {"name": "test"} |
| request_param | Additional params | file path or pytest.mark.parametrize |
| response_body | Response extraction | self.__class__.id = response.data['id'] |
| depends_on | Dependency test IDs | TC001,TC002 |
| assert_status | Expected status codes | 200,201,204 |
| assert_value | Custom assertions | response.data['id'] > 0 |
| pytest_annotation | Pytest markers | @pytest.mark.skip |
| is_skip | Skip execution | yes/no |

## Variable Substitution

Variables in paths and bodies use `{variable}` syntax:
- `{enterprise_path}` → `{self.enterprise_path}`
- `{project_path}` → `{self.project_path}`
- `{access_token}` → `{self.access_token}`
- `{time}` → `{self.time}` (timestamp)

## Generation Workflow

### Step 1: Determine Source

Ask the user or identify from context:
- **Swagger JSON**: Parse OpenAPI spec and generate test cases
- **CSV file**: Create or update test data CSV
- **API description**: Generate from endpoint details

### Step 2: Generate Test Data CSV

Create CSV file in `testdata/{module}/test_data_{module}.csv`:

```csv
test_case_id,test_module_name,test_case_name,request_method,path,request_body,request_param,response_body,depends_on,assert_status,assert_value,pytest_annotation,is_skip
TC001,module-name,测试用例名称,get,/api/path?param={access_token},None,,,"200,201,204",,,no
```

### Step 3: Generate Pytest File

Run the case generator or create test file manually:

```bash
python core/case_generator.py
```

Or create `testcase/{module}/test_api_{module}.py` following the template.

## Test Class Template

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import allure
import pytest
from datetime import datetime, timedelta

from utils.log_util import Logger
from utils.path_util import PathUtils
from utils.http_client_util import HttpClient
from utils.response_util import APIResponse
from config.config_util import ConfigUtils

env = 'premium_gray'

@allure.story("module-name")
class TestAPI:
    @classmethod
    def setup_class(cls):
        """测试类初始化"""
        cls.logger = Logger()
        cls.time = datetime.now().strftime('%Y%m%d%H%M%S')
        cls.base_path = PathUtils.get_project_root_path('api-autotest')
        cls.config_path = os.path.join(cls.base_path, 'config', 'config.yaml')

        cls.env = env
        cls.data = ConfigUtils(cls.env, cls.config_path)
        cls.host = cls.data.host
        cls.access_token = cls.data.access_token
        cls.enterprise_id = cls.data.enterprise_id
        cls.enterprise_path = cls.data.enterprise_path
        cls.project_id = cls.data.project_id
        cls.project_path = cls.data.project_path
        cls.headers = cls.data.headers
        cls.client = HttpClient(cls.host)

    @allure.title('TC001-测试用例名称')
    def test_api_endpoint(self):
        """测试用例名称"""
        path = f"/api/path?access_token={self.access_token}"
        body = None
        response = APIResponse(self.client.send_get_request(path, self.headers))
        response.assert_status((200, 201, 204), '测试用例名称状态码验证')
```

## Special Cases

### File Upload (multipart/form-data)

Add `(upload)` to test_case_name and specify file path in request_param:

```csv
TC001,module,上传文件(upload),post,/api/upload,{},/test_image.png,,"200,201",,,no
```

### File Download

Add `(download)` to test_case_name:

```csv
TC001,module,导出文件(download),get,/api/export,None,,,,"200,201",,,no
```

### Async Operations

Add `(asyncio)` to test_case_name:

```csv
TC001,module,异步操作(asyncio),post,/api/async,{},,,,"200,201",,,no
```

### Test Dependencies

Use `depends_on` to specify prerequisite test IDs:

```csv
TC002,module,更新资源,put,/api/resource/{resource_id},{},,self.__class__.resource_id = response.data['id'],TC001,"200,201",,,no
```

## Running Tests

```bash
# Run specific test file
pytest testcase/gitee/test_api_apiv5.py --env=premium_gray --module=gitee --alluredir=report/allure-results

# Run with allure report
pytest testcase/gitee/test_api_apiv5.py --env=premium_gray --module=gitee --alluredir=report/allure-results && allure serve report/allure-results
```

## Available Config Variables

From `ConfigUtils`:
- `host`, `access_token`, `session_cookie`
- `enterprise_id`, `enterprise_path`
- `user_id`, `username`, `password`
- `project_id`, `project_path`
- `program_id`, `team_id`
- `file_path`, `download_file_path`

## Best Practices

1. **Naming Convention**: Use descriptive test_case_name in Chinese for better readability
2. **Status Codes**: Default to `(200, 201, 204)` for successful operations
3. **Dependencies**: Chain tests that create/delete resources
4. **Cleanup**: Create resources in early tests, delete in later tests
5. **Idempotency**: Use timestamps (`self.time`) for unique resource names
