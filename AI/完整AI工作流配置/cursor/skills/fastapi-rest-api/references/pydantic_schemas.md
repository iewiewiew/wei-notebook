# Pydantic Schemas for Validation

Pydantic models are used to define the data shapes for request bodies and responses.

## Example: `Item` Schemas

These schemas define the data for creating, updating, and reading 'Item' resources.

```python
from pydantic import BaseModel
from typing import Optional

class ItemBase(BaseModel):
    title: str
    description: Optional[str] = None

class ItemCreate(ItemBase):
    pass

class ItemUpdate(ItemBase):
    pass

class Item(ItemBase):
    id: int

    class Config:
        from_attributes = True
```

### Schema Breakdown

- **`ItemBase`**: Contains common attributes. Other schemas inherit from it to avoid repetition.
- **`ItemCreate`**: Used for the request body when creating an item.
- **`ItemUpdate`**: Used for the request body when updating an item.
- **`Item`**: Used for the response body. It includes the `id` which is assigned by the database.
- **`Config.from_attributes = True`**: Allows Pydantic to read data from ORM models (like SQLAlchemy). This replaces the deprecated `orm_mode`.
