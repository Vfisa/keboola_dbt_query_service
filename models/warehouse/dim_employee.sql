with source as (
    select
        "EMPLOYEE_ID"
        ,"LAST_NAME"
        ,"FIRST_NAME"
        ,"TITLE"
        ,"BIRTH_DATE"
        ,"HIRE_DATE"
        ,"ADDRESS"
        ,"CITY"
        ,"REGION"
        ,"POSTAL_CODE"
        ,"COUNTRY"
        ,"HOME_PHONE"
        ,"EXTENSION"
        ,"NOTES"
        ,"REPORTS_TO"
        ,current_timestamp() as insertion_timestamp
    from {{ ref('stg_employees') }}
),
unique_source as (
    select
        *
        ,ROW_NUMBER() OVER(PARTITION BY "EMPLOYEE_ID" ORDER BY "EMPLOYEE_ID") AS "row_num"
    from source
)
select
    * EXCLUDE ("row_num")
from
    unique_source
where
    "row_num" = 1