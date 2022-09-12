SELECT 
   select_list
FROM 
   table_name
ORDER BY 
   column1 [ASC|DESC], 
   column2 [ASC|DESC];

-- Using MySQL ORDER BY clause to sort data using a custom list
FIELD(str, str1, str2, ...)
-- FIELD() function returns the position of the str in the str1, str2, … list. 
-- If the str is not in the list, the FIELD() function returns 0

SELECT FIELD('A', 'A', 'B','C');
Output:

+--------------------------+
| FIELD('A', 'A', 'B','C') |
+--------------------------+
|                        1 |
+--------------------------+
1 row in set (0.00 sec)


SELECT 
    orderNumber, status
FROM
    orders
ORDER BY FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');

+-------------+------------+
| orderNumber | status     |
+-------------+------------+
|       10425 | In Process |
|       10421 | In Process |
|       10422 | In Process |
|       10420 | In Process |
|       10424 | In Process |
|       10423 | In Process |
|       10414 | On Hold    |
|       10401 | On Hold    |
|       10334 | On Hold    |
|       10407 | On Hold    |
...


-- NULL comes before non-NULL values