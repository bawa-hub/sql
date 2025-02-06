import mysql.connector
import random
import faker
import time
import uuid
import logging

# MySQL database connection setup
conn = mysql.connector.connect(
    host='localhost',
    user='root',  # replace with your MySQL username
    password='',  # replace with your MySQL password
    database='gpt_ecom_without_idx'  # replace with your actual database name
)
cursor = conn.cursor()

# Faker instance to generate random data
fake = faker.Faker()

# Function to insert users
def insert_users(batch_size):
    users = []
    for i in range(batch_size):
        name = fake.name()
        # Use UUID for uniqueness, and append a random number to avoid overlap
        unique_suffix = f"{uuid.uuid4().hex[:8]}{random.randint(1000, 9999)}"
        email = f"{fake.first_name().lower()}{unique_suffix}@example.com"
        created_at = fake.date_time_this_decade()
        users.append((name, email, created_at))

    cursor.executemany("""
        INSERT INTO users (name, email, created_at)
        VALUES (%s, %s, %s)
    """, users)
    conn.commit()


# Function to insert products
def insert_products(batch_size):
    products = []
    categories = ['Electronics', 'Clothing', 'Books', 'Beauty', 'Toys']
    for _ in range(batch_size):
        name = fake.word()
        category = random.choice(categories)
        price = round(random.uniform(5.0, 500.0), 2)
        stock = random.randint(0, 1000)
        created_at = fake.date_time_this_decade()
        products.append((name, category, price, stock, created_at))

    cursor.executemany("""
        INSERT INTO products (name, category, price, stock, created_at)
        VALUES (%s, %s, %s, %s, %s)
    """, products)
    conn.commit()

# Function to insert orders

# Set up logging
logging.basicConfig(filename='insert_orders_error.log', level=logging.ERROR)

VALID_STATUSES = ['pending','shipped','delivered','canceled']

def insert_orders(batch_size, total_users):
    orders = []
    for i in range(batch_size):
        user_id = random.randint(1, total_users)  # Ensure this is a valid `user_id`
        total_amount = random.randint(50, 500)  # Random total_amount for the order
        status = random.choice(VALID_STATUSES)  # Random valid status
        created_at = fake.date_time_this_decade()
        
        if status not in VALID_STATUSES:
            logging.error(f"Invalid status value: {status} for user_id: {user_id}")
            continue  # Skip this invalid order
        
        orders.append((user_id, total_amount, status, created_at))
    
    try:
        cursor.executemany("""
            INSERT INTO orders (user_id, total_amount, status, created_at)
            VALUES (%s, %s, %s, %s)
        """, orders)
        conn.commit()
    except mysql.connector.errors.DatabaseError as e:
        # Log the database error
        logging.error(f"DatabaseError: {e}")
        for order in orders:
            try:
                cursor.execute("""
                    INSERT INTO orders (user_id, total_amount, status, created_at)
                    VALUES (%s, %s, %s, %s)
                """, order)
                conn.commit()
            except mysql.connector.errors.DatabaseError as single_error:
                # Log the specific error for the order
                logging.error(f"Failed to insert order for user_id {order[0]}: {single_error}")


# Function to insert order items
def insert_order_items(batch_size, total_orders, total_products):
    cursor.execute("SELECT id FROM orders")  # Fetch valid order IDs
    existing_order_ids = [row[0] for row in cursor.fetchall()]
    
    if not existing_order_ids:
        logging.error("No existing orders found! Cannot insert order_items.")
        return
    
    order_items = []
    
    for _ in range(batch_size):
        order_id = random.choice(existing_order_ids)  # Pick only valid order_id
        product_id = random.randint(1, total_products)
        quantity = random.randint(1, 10)
        price = random.uniform(10.0, 500.0)
        
        order_items.append((order_id, product_id, quantity, price))
    
    try:
        cursor.executemany("""
            INSERT INTO order_items (order_id, product_id, quantity, price)
            VALUES (%s, %s, %s, %s)
        """, order_items)
        conn.commit()
    except mysql.connector.errors.IntegrityError as e:
        logging.error(f"IntegrityError: {e}")
        for item in order_items:
            try:
                cursor.execute("""
                    INSERT INTO order_items (order_id, product_id, quantity, price)
                    VALUES (%s, %s, %s, %s)
                """, item)
                conn.commit()
            except mysql.connector.errors.IntegrityError as single_error:
                logging.error(f"Failed to insert order_item for order_id {item[0]}: {single_error}")

# Number of records to insert per batch
batch_size = 10000

# Insert users (1 million users)
# for i in range(100):  # 1 million users
#     insert_users(batch_size)

# Insert products (500,000 products)
# for i in range(50):  # 500,000 products
#     insert_products(batch_size)

# Get user count for order generation
# cursor.execute("SELECT COUNT(*) FROM users")
# user_count = cursor.fetchone()[0]

# Insert orders (10 million orders)
# for i in range(1000):  # 10 million orders
#     insert_orders(batch_size, 1590000)

# Get order count for order items
cursor.execute("SELECT COUNT(*) FROM orders")
order_count = cursor.fetchone()[0]

# Insert order items (30 million order_items)
for i in range(3000):  # 30 million order_items
    insert_order_items(batch_size, order_count, 500000)

# Close connection
cursor.close()
conn.close()

print("Data insertion complete!")
