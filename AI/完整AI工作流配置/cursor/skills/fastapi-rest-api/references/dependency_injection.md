# Dependency Injection in FastAPI

FastAPI has a powerful dependency injection system. It's used to provide dependencies (like database sessions, authentication credentials, etc.) to your path operations.

## Example: `get_db` Dependency

The `get_db` function is a dependency that provides a database session to the endpoints.

```python
# in app/database.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
```

### How it Works

1.  `get_db` creates a new `SessionLocal` instance.
2.  `yield db` provides the session to the path operation.
3.  The `finally` block ensures that the session is closed after the request is finished, even if an error occurred.

### Usage in Path Operations

To use the dependency, you use `Depends` in your path operation function:

```python
from fastapi import Depends
from sqlalchemy.orm import Session
from ..database import get_db

@router.post("/")
def create_item(item: ItemCreate, db: Session = Depends(get_db)):
    # ... use db session
    pass
```

FastAPI will call `get_db` and pass the returned value as the `db` argument to `create_item`.
