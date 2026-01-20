
  create or replace   view KBC_USE4_834.WORKSPACE_21534344.stg_customer
  
  
  
  
  as (
    with source as (
    select * 
    from "KBC_USE4_834"."in.c-northwind_dataset"."CUSTOMERS"
)
select 
    "CUSTOMER_ID"
	,"COMPANY_NAME"
	,"CONTACT_NAME"
	,"CONTACT_TITLE"
	,"ADDRESS"
	,"CITY"
	,"REGION"
	,"POSTAL_CODE"
	,"COUNTRY"
	,"PHONE"
	,"FAX"
	,"_timestamp" AS ingestion_timestamp
from source
  );

