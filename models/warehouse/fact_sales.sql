{{ config(
    partition_by={
      "field": "order_date",
      "data_type": "date"
    }
)}}
with source as(
    select
        od."ORDER_ID" AS "ORDER_ID"
        ,od."PRODUCT_ID" AS "PRODUCT_ID"
        ,o."CUSTOMER_ID" AS "CUSTOMER_ID"
        ,o."EMPLOYEE_ID" AS "EMPLOYEE_ID"
        ,o."SHIPPER_ID" AS "SHIPPER_ID"
        ,od."QUANTITY" AS "QUANTITY"
        ,od."UNIT_PRICE" AS "UNIT_PRICE"
        ,od."DISCOUNT" AS "DISCOUNT"
        ,date(o."ORDER_DATE") as "ORDER_DATE"
        ,o."SHIPPED_DATE" AS "SHIPPED_DATE"
        ,o."REQUIRED_DATE" AS "REQUIRED_DATE"
        ,current_timestamp() as insertion_timestamp
    from {{ ref('stg_orders') }} o
    left join
        {{ ref('stg_order_details') }} od
        on
        od."ORDER_ID" = o."ORDER_ID"
    where
        od."ORDER_ID" is not null
),
unique_source as (
    select
        *
        ,ROW_NUMBER() OVER(PARTITION BY "CUSTOMER_ID", "EMPLOYEE_ID", "ORDER_ID", "PRODUCT_ID", "SHIPPER_ID", "ORDER_DATE" ORDER BY "CUSTOMER_ID", "EMPLOYEE_ID", "ORDER_ID", "PRODUCT_ID", "SHIPPER_ID", "ORDER_DATE") AS "row_num"
    from
        source
)
select
    * EXCLUDE ("row_num")
from
    unique_source
where
    "row_num" = 1