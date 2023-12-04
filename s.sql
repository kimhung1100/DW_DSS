-- SELECT * FROM customer_dim;
--
-- SELECT * FROM date_dim;
--
-- SELECT * FROM employee_dim;
--
-- SELECT * FROM products_dim;
--
-- SELECT * FROM promotion_dim;
--
-- SELECT * FROM orders_dim;


SELECT
    o.ORDER_ID,
    o.ORDER_DATE,
--     o.ORDER_STATUS,
    o.ORDER_TOTAL,
--     c.CUSTOMER_ID,
--     c.CUST_FIRST_NAME,
--     c.CUST_LAST_NAME,
    c.STREET_ADDRESS,
    c.POSTAL_CODE,
    c.CITY,
--     c.STATE_PROVINCE,
--     c.COUNTRY_ID,
--     c.COUNTRY_NAME,
--     c.REGION_ID,
--     c.NLS_LANGUAGE,
--     c.NLS_TERRITORY,
    c.CREDIT_LIMIT,
--     c.CUST_EMAIL,
--     c.PRIMARY_PHONE_NUMBER,
--     c.PHONE_NUMBER_2,
--     c.ACCOUNT_MGR_ID,
    c.LOCATION_GTYPE,
    c.LOCATION_SRID,
    c.LOCATION_X,
    c.LOCATION_Y,
--     e.salesrep_id AS SALES_REP_ID,
--     e.FIRST_NAME AS SALES_REP_FIRST_NAME,
--     e.LAST_NAME AS SALES_REP_LAST_NAME,
--     e.EMAIL AS SALES_REP_EMAIL,
--     e.PHONE_NUMBER AS SALES_REP_PHONE,
--     e.HIRE_DATE AS SALES_REP_HIRE_DATE,
--     e.JOB_ID AS SALES_REP_JOB_ID,
--     e.SALARY AS SALES_REP_SALARY,
--     e.COMMISSION_PCT AS SALES_REP_COMMISSION_PCT,
--     e.MANAGER_ID AS SALES_REP_MANAGER_ID,
--     e.DEPARTMENT_ID AS SALES_REP_DEPARTMENT_ID,
--     p.PRODUCT_ID,
--     p.PRODUCT_NAME,
--     p.LANGUAGE_ID,
    p.MIN_PRICE,
    p.LIST_PRICE,
    p.PRODUCT_STATUS,
--     p.SUPPLIER_ID,
    p.WARRANTY_PERIOD,
    p.WEIGHT_CLASS,
--     p.PRODUCT_DESCRIPTION,
    p.CATEGORY_ID,
--     p.CATALOG_URL,
--     p.SUB_CATEGORY_NAME,
--     p.SUB_CATEGORY_DESCRIPTION,
--     p.PARENT_CATEGORY_ID,
--     p.CATEGORY_NAME,
--     promo.PROMO_ID,
    promo.PROMO_NAME,
    d.sales_date,
    d.sales_day_of_year,
    d.sales_month,
    d.sales_year,
    d.sales_quarter,
    d.sales_month_name,
    d.sales_day_of_week_name,
    d.sales_day_of_week,
    d.sales_day_of_month
FROM
    orders_dim o
JOIN
    customer_dim c ON o.CUSTOMER_ID = c.CUSTOMER_ID
JOIN
    employee_dim e ON o.SALES_REP_ID = e.salesrep_id
JOIN
    products_dim p ON o.PRODUCT_ID = p.PRODUCT_ID
JOIN
    promotion_dim promo ON o.PROMO_ID = promo.PROMO_ID
JOIN
    date_dim d ON CAST(o.ORDER_DATE AS DATE) = d.sales_date;

