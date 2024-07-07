# CRUD Router Template

This template provides a generic structure for a CRUD (Create, Read, Update, Delete) router for a resource.

## Example: `items` router

This router manages 'Item' resources. It uses a service layer for business logic and a database session dependency.

```python
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from .. import schemas, services, models
from ..database import get_db, engine

models.Base.metadata.create_all(bind=engine)

router = APIRouter(
    prefix="/items",
    tags=["items"],
    responses={404: {"description": "Not found"}},
)

@router.post("/", response_model=schemas.item.Item)
def create_item(item: schemas.item.ItemCreate, db: Session = Depends(get_db)):
    return services.item_service.create_item(db=db, item=item)

@router.get("/", response_model=List[schemas.item.Item])
def read_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    items = services.item_service.get_items(db, skip=skip, limit=limit)
    return items

@router.get("/{item_id}", response_model=schemas.item.Item)
def read_item(item_id: int, db: Session = Depends(get_db)):
    db_item = services.item_service.get_item(db, item_id=item_id)
    if db_item is None:
        raise HTTPException(status_code=404, detail="Item not found")
    return db_item

@router.put("/{item_id}", response_model=schemas.item.Item)
def update_item(item_id: int, item: schemas.item.ItemUpdate, db: Session = Depends(get_db)):
    db_item = services.item_service.get_item(db, item_id=item_id)
    if db_item is None:
        raise HTTPException(status_code=404, detail="Item not found")
    return services.item_service.update_item(db=db, item_id=item_id, item_update=item)

@router.delete("/{item_id}", response_model=schemas.item.Item)
def delete_item(item_id: int, db: Session = Depends(get_db)):
    db_item = services.item_service.get_item(db, item_id=item_id)
    if db_item is None:
        raise HTTPException(status_code=404, detail="Item not found")
    return services.item_service.delete_item(db=db, item_id=item_id)

```
Key patterns:
- **APIRouter**: Organizes endpoints for a specific resource.
- **`Depends(get_db)`**: Injects a database session into the endpoint.
- **`response_model`**: Defines the schema for the response, ensuring the output is validated and documented.
- **HTTP Methods**: Uses `POST`, `GET`, `PUT`, `DELETE` for the corresponding CRUD operations.
- **Error Handling**: Raises `HTTPException` for not-found errors.
