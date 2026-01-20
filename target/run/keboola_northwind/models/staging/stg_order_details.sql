
  create or replace   view KBC_USE4_834.WORKSPACE_21534344.stg_order_details
  
  
  
  
  as (
    with source as (
    select * from "KBC_USE4_834"."in.c-northwind_dataset"."ORDER_DETAILS"
)
select 
    "ORDER_ID"
    ,"PRODUCT_ID"
    ,"UNIT_PRICE"
    ,"QUANTITY"
    ,"DISCOUNT"
    ,"_timestamp" as ingestion_timestamp
from source
  );

