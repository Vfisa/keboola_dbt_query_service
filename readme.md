## Info

Example repo to showcase how to use [dbt-keboola-snowflake](https://github.com/keboola-rnd/dbt-keboola-snowflake) - dbt adapter for Snowflake via Keboola Query Service

## Datasets
Data defiition is in the [models/_sources/in.c-northwind_dataset.yml](models/_sources/in.c-northwind_dataset.yml) file.
Tables in the `in.c-northwind_dataset` Keboola schema:
- CATEGORIES
- CUSTOMERS
- CUSTOMER_DEMOGRAPHICS
- EMPLOYEES
- EMPLOYEE_TERRITORIES
- ORDERS
- ORDER_DETAILS
- PRODUCTS
- REGION
- SHIPPERS
- SUPPLIERS
- TERRITORIES
- US_STATES

You can use `Snowflake SQL - Northwind Seed.json` file to create datasets in Keboola project. Use debug mode to paste the whole thing or use Keboola MCP to create a transformation automatically.


## Run setup

`./setup.sh`

## Activate conda

`conda activate .conda`

## Load variables

`source load_env.sh`

## Run dbt commands
```
dbt debug          # Verify connection
dbt deps           # Install packages
dbt run            # Run all models
dbt test           # Run all tests
dbt docs generate           # Generate documentation
dbt docs serve           # Serve documentation
```

