{{ config(group = 'analytics') }}

with source as (
    select
        s."ORDER_ID"
        ,s."PRODUCT_ID"
        ,s."CUSTOMER_ID"
        ,s."EMPLOYEE_ID"
        ,s."SHIPPER_ID"
        ,s."QUANTITY"
        ,s."UNIT_PRICE"
        ,s."DISCOUNT"
        ,s."ORDER_DATE"
        ,s."SHIPPED_DATE"
        ,s."REQUIRED_DATE"
	    ,c."COMPANY_NAME" AS "CUSTOMER_COMPANY"
	    ,c."CONTACT_NAME" AS "CUSTOMER_NAME"
	    ,c."CONTACT_TITLE" AS "CUSTOMER_TITLE"
	    ,c."ADDRESS" AS "CUSTOMER_ADDRESS"
	    ,c."CITY" AS "CUSTOMER_CITY"
	    ,c."REGION" AS "CUSTOMER_REGION"
	    ,c."POSTAL_CODE" AS "CUSTOMER_POSTAL_CODE"
	    ,c."COUNTRY" AS "CUSTOMER_COUNTRY"
	    ,c."PHONE" AS "CUSTOMER_PHONE"
	    ,c."FAX" AS "CUSTOMER_FAX"
        ,e."LAST_NAME" AS "EMPLOYEE_LAST_NAME"
        ,e."FIRST_NAME" AS "EMPLOYEE_FIRST_NAME"
        ,e."TITLE" AS "EMPLOYEE_TITLE"
        ,e."BIRTH_DATE" AS "EMPLOYEE_BIRTH_DATE"
        ,e."HIRE_DATE" AS "EMPLOYEE_HIRE_DATE"
        ,e."ADDRESS" AS "EMPLOYEE_ADDRESS"
        ,e."CITY" AS "EMPLOYEE_CITY"
        ,e."REGION" AS "EMPLOYEE_REGION"
        ,e."POSTAL_CODE" AS "EMPLOYEE_POSTAL_CODE"
        ,e."COUNTRY" AS "EMPLOYEE_COUNTRY"
        ,e."HOME_PHONE" AS "EMPLOYEE_PHONE"
        ,e."EXTENSION" AS "EMPLOYEE_EXT"
        ,e."NOTES" AS "EMPLOYEE_NOTE"
        ,e."REPORTS_TO" AS "EMPLOYEE_REPORTS_TO"
        ,p."PRODUCT_NAME"
        ,p."CATEGORY_ID"
        ,p."SUPPLIER_COMPANY"
        ,p."UNITS_ON_ORDER"
        ,p."UNITS_IN_STOCK"
        ,p."REORDER_LEVEL"
        ,p."DISCONTINUED"
        ,current_timestamp() as insertion_timestamp
    from {{ ref('fact_sales') }} s
    left join {{ ref('dim_customer') }} c
    on c."CUSTOMER_ID" = s."CUSTOMER_ID"
    left join {{ ref('dim_employee') }} e
    on e."EMPLOYEE_ID" = s."EMPLOYEE_ID"
    left join {{ ref('dim_product') }} p
    on p."PRODUCT_ID" = s."PRODUCT_ID"
)
select * 
from source
