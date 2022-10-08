-- INNER JOIN matches each row in one table with every row in other tables and allows you to query rows that contain columns from both tables

-- SELECT
--     select_list
-- FROM t1
-- INNER JOIN t2 ON join_condition1
-- INNER JOIN t3 ON join_condition2
-- ...;

SELECT 
    productCode, 
    productName, 
    textDescription
FROM
    products t1
INNER JOIN productlines t2 
    ON t1.productline = t2.productline;

    -- Because the joined columns of both tables have the same name  productline, you can use the USING syntax:
SELECT 
    productCode, 
    productName, 
    textDescription
FROM
    products
INNER JOIN productlines USING (productline);

-- With Group By
SELECT 
    t1.orderNumber,
    t1.status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders t1
INNER JOIN orderdetails t2 
    ON t1.orderNumber = t2.orderNumber
GROUP BY orderNumber;