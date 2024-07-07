from sqlalchemy.orm import Session
from .. import models, schemas

def get_item(db: Session, item_id: int):
    return db.query(models.item.Item).filter(models.item.Item.id == item_id).first()

def get_items(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.item.Item).offset(skip).limit(limit).all()

def create_item(db: Session, item: schemas.item.ItemCreate):
    db_item = models.item.Item(**item.model_dump())
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item

def update_item(db: Session, item_id: int, item_update: schemas.item.ItemUpdate):
    db_item = get_item(db, item_id)
    if db_item:
        update_data = item_update.model_dump(exclude_unset=True)
        for key, value in update_data.items():
            setattr(db_item, key, value)
        db.commit()
        db.refresh(db_item)
    return db_item

def delete_item(db: Session, item_id: int):
    db_item = get_item(db, item_id)
    if db_item:
        db.delete(db_item)
        db.commit()
    return db_item
