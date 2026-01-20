
  create or replace   view KBC_USE4_834.WORKSPACE_21534344.stg_orders
  
  
  
  
  as (
    with source as (
    select * from "KBC_USE4_834"."in.c-northwind_dataset"."ORDERS"
)
select
    "ORDER_ID"
    ,"CUSTOMER_ID"
    ,"EMPLOYEE_ID"
    ,TRY_CAST("ORDER_DATE" AS DATE) AS "ORDER_DATE"
    ,TRY_CAST("REQUIRED_DATE" AS DATE) AS "REQUIRED_DATE"
    ,TRY_CAST("SHIPPED_DATE" AS DATE) AS "SHIPPED_DATE"
    ,"SHIP_VIA" AS "SHIPPER_ID"
    ,"FREIGHT"
    ,"SHIP_NAME"
    ,"SHIP_ADDRESS"
    ,"SHIP_CITY"
    ,"SHIP_REGION"
    ,"SHIP_POSTAL_CODE"
    ,"SHIP_COUNTRY"
    ,"_timestamp" as ingestion_timestamp
from source
  );

