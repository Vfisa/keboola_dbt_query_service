with source as (

    select * from {{ source('in.c-northwind_dataset', 'SHIPPERS') }}
)
select 
    "SHIPPER_ID"
    ,"COMPANY_NAME"
    ,"PHONE"
    ,"_timestamp" as ingestion_timestamp
from source