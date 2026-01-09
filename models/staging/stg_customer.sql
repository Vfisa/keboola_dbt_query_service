with source as (
    select * 
    from {{ source('in.c-northwind_dataset', 'CUSTOMERS') }}
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
