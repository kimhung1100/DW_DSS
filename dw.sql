CREATE TABLE customers_dim (
  customer_id bpchar PRIMARY KEY NOT NULL,
  company_name character varying(40) NOT NULL,
  contact_name character varying(30),
  contact_title character varying(30),
  address character varying(60),
  city character varying(15),
  region character varying(15),
  postal_code character varying(10),
  country character varying(15),
  phone character varying(24),
  fax character varying(24)
);

CREATE TABLE employees_dim (
  employee_id smallint PRIMARY KEY NOT NULL,
  last_name character varying(20) NOT NULL,
  first_name character varying(10) NOT NULL,
  title character varying(30),
  title_of_courtesy character varying(25),
  birth_date date,
  hire_date date,
  address character varying(60),
  city character varying(15),
  region character varying(15),
  extension character varying(4)
);

CREATE TABLE products_dim (
  product_id smallint PRIMARY KEY NOT NULL,
  product_name character varying(40) NOT NULL,
  supplier_id smallint,
  quantity_per_unit character varying(20),
  units_in_stock smallint,
  units_on_order smallint,
  reorder_level smallint,
  discontinued integer NOT NULL
);

CREATE TABLE orders_fact (
  order_id smallint PRIMARY KEY NOT NULL,
  customer_id bpchar,
  employee_id smallint,
  order_date date,
  unit_price real NOT NULL,
  quantity smallint NOT NULL,
  discount real NOT NULL,
  required_date date,
  shipped_date date,
  ship_via smallint,
  freight real,
  product_id smallint NOT NULL,
  ship_name character varying(40),
  ship_address character varying(60),
  ship_city character varying(15),
  ship_region character varying(15),
  ship_postal_code character varying(10),
  ship_country character varying(15)
);

ALTER TABLE orders_fact ADD FOREIGN KEY (customer_id) REFERENCES customers_dim (customer_id);

ALTER TABLE orders_fact ADD FOREIGN KEY (employee_id) REFERENCES employees_dim (employee_id);

ALTER TABLE orders_fact ADD FOREIGN KEY (product_id) REFERENCES products_dim (product_id);








SELECT   employee_id,
  last_name,
  first_name,
  title ,
  title_of_courtesy,
  birth_date ,
  hire_date ,
  address,
  city,
  region,
  extension
FROM employees;

INSERT INTO products_dim
SELECT
  product_id,
  product_name,
  supplier_id,
  quantity_per_unit,
  units_in_stock,
  units_on_order,
  reorder_level,
  discontinued
FROM products;

INSERT INTO orders_fact (
    order_id, customer_id, employee_id, order_date, unit_price, quantity,
    discount, required_date, shipped_date, ship_via, freight, product_id,
    ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country
)
SELECT DISTINCT ON (o.order_id)
    o.order_id, o.customer_id, o.employee_id, o.order_date,
    od.unit_price, od.quantity, od.discount, o.required_date,
    o.shipped_date, o.ship_via, o.freight, od.product_id,
    o.ship_name, o.ship_address, o.ship_city, o.ship_region,
    o.ship_postal_code, o.ship_country
FROM orders o
LEFT JOIN order_details od ON o.order_id = od.order_id
ORDER BY o.order_id, od.product_id; -- Add an appropriate ordering


-- Check the data in orders_fact table
SELECT * FROM orders_fact;


SELECT
    of.order_id,
    of.customer_id,
    cd.company_name,
    of.employee_id,
    of.order_date,
    of.unit_price,
    of.quantity,
    of.discount,
    of.required_date,
    of.shipped_date,
    of.ship_via,
    of.freight,
    of.product_id,
    of.ship_name,
    of.ship_address,
    of.ship_city,
    of.ship_region,
    of.ship_postal_code,
    of.ship_country
FROM orders_fact of
JOIN customers_dim cd ON of.customer_id = cd.customer_id;
