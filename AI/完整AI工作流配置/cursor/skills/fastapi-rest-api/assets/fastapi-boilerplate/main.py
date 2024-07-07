from fastapi import FastAPI
from app.routers import items

app = FastAPI()

app.include_router(items.router, prefix="/api/v1")

@app.get("/")
async def root():
    return {"message": "Hello World"}
