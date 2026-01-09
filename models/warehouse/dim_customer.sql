with source as (
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
        ,current_timestamp() as insertion_timestamp
    from {{ ref('stg_customer') }}
),
unique_source as (
    select
        *
        ,ROW_NUMBER() OVER(PARTITION BY "CUSTOMER_ID" ORDER BY "CUSTOMER_ID") AS "row_num"
    from source
)
select
    * EXCLUDE ("row_num")
from
    unique_source
where
    "row_num" = 1