with source as (

    select * from {{ source('in.c-northwind_dataset', 'SUPPLIERS') }}
)
select 
    "SUPPLIER_ID"
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
	,"HOMEPAGE"
    ,"_timestamp" as ingestion_timestamp
from source