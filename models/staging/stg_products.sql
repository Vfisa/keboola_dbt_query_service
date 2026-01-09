with source as (
    select cast("SUPPLIER_ID" as integer) as "SUPPLIER_ID"
           ,"PRODUCT_ID"
           ,"PRODUCT_NAME"
           ,"CATEGORY_ID"
           ,TRY_TO_NUMERIC("QUANTITY_PER_UNIT") AS "QUANTITY_PER_UNIT"
           ,TRY_CAST("UNIT_PRICE" AS FLOAT) AS "UNIT_PRICE"
           ,TRY_TO_NUMERIC("UNITS_ON_ORDER") AS "UNITS_ON_ORDER"
           ,TRY_TO_NUMERIC("UNITS_IN_STOCK") AS "UNITS_IN_STOCK"
           ,TRY_TO_NUMERIC("REORDER_LEVEL") AS "REORDER_LEVEL"
           ,"DISCONTINUED"
           ,"_timestamp" AS ingestion_timestamp
    from {{ source('in.c-northwind_dataset', 'PRODUCTS') }}
)
select 
    *
from source