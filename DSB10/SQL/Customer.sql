CREATE TABLE Staff (
  staff_id INTEGER PRIMARY KEY,
  staff_name TEXT,
  salary integer
);

CREATE TABLE menu (
  menu_id INTEGER PRIMARY KEY,
  menu_name TEXT,
  menu_type TEXT,
  price integer
);

CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  customer_name TEXT,
  staff_id INTEGER,
  menu_id INTEGER,
  order_date TEXT
);

INSERT INTO Staff VALUES
  (1, 'Beem', 20000),
  (2, 'Nack', 18000),
  (3, 'Hein', 17000),
  (4, 'Chaewon', 20000),
  (5, 'Aun', 15000);

insert into menu values
  (1, 'Coffee', 'Drink', 60),
  (2, 'Latte', 'Drink', 70),
  (3, 'Green Tea', 'Drink', 65),
  (4, 'Mocha', 'Drink', 70),
  (5, 'Blueberry Chess Cake', 'Dessert', 100),
  (6, 'Strawberry Chess Cake', 'Dessert', 100),
  (7, 'Cookie', 'Dessert', 80),
  (8, 'Pizza', 'Food', 150),
  (9, 'french fries', 'Food', 90),
  (10, 'Tomato soup', 'Food', 100);

insert into transactions values
  (1, 'Kim', 1, 3, '2024-06-01'),
  (2, 'Momo', 4, 1, '2024-06-01'),
  (3, 'Ploy', 2, 2, '2024-06-02'),
  (4, 'Anna', 3, 5, '2024-06-02'),
  (5, 'Jane', 5, 8, '2024-06-02'),
  (6, 'Mew', 1, 9, '2024-06-02'),
  (7, 'Krit', 4, 6, '2024-06-03'),
  (8, 'John', 1, 4, '2024-06-04'),
  (9, 'Mike', 2, 7, '2024-06-04'),
  (10, 'Mick', 4, 9, '2024-06-04'),
  (11, 'Ann', 5, 5, '2024-06-05'),
  (12, 'George', 1, 6, '2024-06-05'),
  (13, 'Jack', 3, 10, '2024-06-05'),
  (14, 'Jenny', 5, 1, '2024-06-06'),
  (15, 'Jim', 1, 2, '2024-06-06');

.mode table
.table on

--หา Staff ดีเด่นที่รับ order มากสุด
SELECT 
  s.staff_name, 
  Count(*) AS N_order
FROM Staff s
JOIN transactions t ON s.Staff_id = t.Staff_id
GROUP BY s.staff_name
ORDER BY 2 DESC;

-- Aggregate function in menu table
select
  AVG(price) AS avg_price,
  MAX(price) AS max_price,
  Min(price) AS min_price
FROM menu;
-- With function
WITH high_price AS (
    SELECT * FROM menu WHERE price >= 100
),
  transaction_04_06 AS (
    SELECT * FROM transactions WHERE order_date BETWEEN '2024-06-04' AND '2024-06-06'
)

select menu_name, customer_name, price
FROM high_price h
JOIN transaction_04_06 t ON h.menu_id = t.menu_id