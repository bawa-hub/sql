-- CREATE TABLE [IF NOT EXISTS] table_name(
--    column_1_definition,
--    column_2_definition,
--    ...,
--    table_constraints
-- ) ENGINE=storage_engine;

CREATE TABLE [IF NOT EXISTS] table_name(
   column1 datatype constraints,
   column1 datatype constraints,
) ENGINE=storage_engine;


-- syntax of column
-- column_name data_type(length) [NOT NULL] [DEFAULT value] [AUTO_INCREMENT] column_constraint;



-- 1) MySQL CREATE TABLE simple example
CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE,
    status TINYINT NOT NULL,
    priority TINYINT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)  ENGINE=INNODB;

-- view the structure of table
DESCRIBE tasks;

-- 2) MySQL CREATE TABLE with a foreign key primary key example
CREATE TABLE IF NOT EXISTS checklists (
    todo_id INT AUTO_INCREMENT,
    task_id INT,
    todo VARCHAR(255) NOT NULL,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (todo_id , task_id),
    FOREIGN KEY (task_id)
        REFERENCES tasks (task_id)
        ON UPDATE RESTRICT ON DELETE CASCADE
);