with source as(
    select
        p."PRODUCT_ID" AS "PRODUCT_ID"
        ,p."PRODUCT_NAME"
        ,p."CATEGORY_ID"
        ,s."COMPANY_NAME" as "SUPPLIER_COMPANY"
        ,p."UNIT_PRICE"
        ,p."UNITS_ON_ORDER"
        ,p."UNITS_IN_STOCK"
        ,p."REORDER_LEVEL"
        ,p."DISCONTINUED"
        ,current_timestamp() as insertion_timestamp
    from
        {{ ref('stg_products') }} p
    left join
        {{ ref('stg_suppliers') }} s
        on
        s."SUPPLIER_ID" = p."SUPPLIER_ID"
),
unique_source as (
    select
        *
        ,ROW_NUMBER() OVER(PARTITION BY "PRODUCT_ID" ORDER BY "PRODUCT_ID") AS "row_num"
    from source
)
select
    * EXCLUDE ("row_num")
from
    unique_source
where
    "row_num" = 1