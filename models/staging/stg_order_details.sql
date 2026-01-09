with source as (
    select * from {{ source('in.c-northwind_dataset', 'ORDER_DETAILS') }}
)
select 
    "ORDER_ID"
    ,"PRODUCT_ID"
    ,"UNIT_PRICE"
    ,"QUANTITY"
    ,"DISCOUNT"
    ,"_timestamp" as ingestion_timestamp
from source