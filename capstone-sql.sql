create database capstone;

use capstone;
show tables;
select * from capstone.products;

-- task1
create table brands (brand_id int primary key,brand_name varchar(100));
create table categories ( category_id int primary key,category_name varchar(100));
create table customer (customer_id int primary key,frist_name varchar(100),last_name varchar(100),phone varchar(100),
email varchar(100),street varchar(100),city varchar(100),state varchar(100),zip_code int);

create table capstone.orders(order_id int primary key,customer_id int,product_id int,order_status text,order_date text,
discount double,total_price double);

create table capstone.orders (orders_id int primary key,customer_id int,order_status text,order_date text,
requried_date text,shipped_date text,store_id int,staff_id int);

create table capstone.staffs (staff_id int primary key,frist_name varchar(100),last_name varchar(100),email varchar(100),
phone varchar(100),active int,store_id int,manager_id varchar(100));

create table capstone.stocks (store_id int,product_id int,quantity int);

create table capstone.stores (store_id int primary key ,store_name varchar(100),phone varchar(100),email varchar(100),
street varchar(100),city varchar(100),satate varchar(100),zip_code int);

-- task 3
select * from capstone.orders as o
inner join capstone.order_items as od
on o.order_id = od.order_id
inner join capstone.products as p
on p.product_id =od.product_id;

-- task 4
select sum(od.Total_price) as Total_sales,s.store_id from capstone.order_items as od 
join capstone.orders as o
on o.order_id = od.order_id
join capstone.stores as s
on o.store_id = s.store_id
group by s.store_id;

-- task 5
select sum(oi.quantity) as quantity,p.product_name
from capstone.order_items as  oi
inner join capstone.products as p
on oi.product_id = p.product_id
group by p.product_name
order by quantity desc limit 5;

-- task6
select o.customer_id,count(oi.order_id) as total_orders,sum(oi.Total_Price) as total_revenue,sum(oi.quantity) as total_item_purchased
from capstone.orders as o 
join capstone.order_items as  oi
on oi.order_id = o.order_id
group by o.customer_id
order by total_orders,total_revenue;


-- task7
select o.customer_id,sum(oi.Total_price) as total_spending,
case
when sum(oi.Total_price) < 10000 then "low"
when sum(oi.Total_price) between 10000 and 15000 then "medium"
else "high"
end as spending_segment
from capstone.orders as o
join capstone.order_items as oi
on o.order_id = oi.order_id
group by o.customer_id;

-- task8
select s.staff_id,round(sum(oi.Total_price),2) as total_revenue
from capstone.orders as o
join capstone.staffs as s
on s.staff_id = o.staff_id
join capstone.order_items as oi
on oi.order_id = o.order_id
group by s.staff_id;

-- task 9
select str.store_id,p.product_id,p.product_name,s.quantity
from capstone.stores as str
join capstone.stocks as s
on s.store_id = str.store_id
join capstone.products as p
on p.product_id = s.product_id
where s.quantity < 10;

create table capstone.customer_segments(customer_id int,recency int,monetary decimal(12,2));
select * from capstone.customer_segments;
