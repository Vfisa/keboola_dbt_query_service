with source as (

    select * from "KBC_USE4_834"."in.c-northwind_dataset"."SHIPPERS"
)
select 
    "SHIPPER_ID"
    ,"COMPANY_NAME"
    ,"PHONE"
    ,"_timestamp" as ingestion_timestamp
from source