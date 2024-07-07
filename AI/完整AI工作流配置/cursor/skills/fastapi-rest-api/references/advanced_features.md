# Advanced FastAPI Features

This section covers more advanced FastAPI features like background tasks, file uploads, and pagination.

## Background Tasks

For operations that you need to run after returning a response (like sending an email), use `BackgroundTasks`.

```python
from fastapi import BackgroundTasks, FastAPI

app = FastAPI()

def write_notification(email: str, message=""):
    with open("log.txt", mode="a") as email_file:
        content = f"notification for {email}: {message}\n"
        email_file.write(content)

@app.post("/send-notification/{email}")
async def send_notification(email: str, background_tasks: BackgroundTasks):
    background_tasks.add_task(write_notification, email, message="some notification")
    return {"message": "Notification sent in the background"}
```

## File Uploads

To handle file uploads, use `UploadFile`.

```python
from fastapi import FastAPI, File, UploadFile

app = FastAPI()

@app.post("/files/")
async def create_file(file: bytes = File()):
    return {"file_size": len(file)}


@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile):
    return {"filename": file.filename, "content_type": file.content_type}
```
`UploadFile` is more suitable for large files as it streams the file to disk.

## Pagination

Simple pagination can be implemented using `skip` and `limit` query parameters.

```python
@router.get("/items/", response_model=List[Item])
def read_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    items = services.get_items(db, skip=skip, limit=limit)
    return items
```

For more advanced pagination (e.g., with page numbers, total counts), you can create a custom pagination dependency or use a library like `fastapi-pagination`.
