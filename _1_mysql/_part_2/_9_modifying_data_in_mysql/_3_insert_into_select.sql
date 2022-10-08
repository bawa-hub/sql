-- use the result of a SELECT statement as the data source for the INSERT statement
INSERT INTO table_name(column_list)
SELECT 
   select_list 
FROM 
   another_table
WHERE
   condition;