with source as (
    select * from {{ source('in.c-northwind_dataset', 'EMPLOYEES') }}
)
select 
    "EMPLOYEE_ID"
	,"LAST_NAME"
	,"FIRST_NAME"
	,"TITLE"
	,"TITLE_OF_COURTESY"
	,"BIRTH_DATE"
	,"HIRE_DATE"
	,"ADDRESS"
	,"CITY"
	,"REGION"
	,"POSTAL_CODE"
	,"COUNTRY"
	,"HOME_PHONE"
	,"EXTENSION"
	,"PHOTO"
	,"NOTES"
	,"REPORTS_TO"
	,"PHOTO_PATH"
    ,"_timestamp" as ingestion_timestamp
from source