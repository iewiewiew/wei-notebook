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
