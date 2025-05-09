create view prod_info
as
select product_name,brand_name,list_price from production.products p
inner join production.brands b on p.brand_id=b.brand_id

select * from prod_info

create view vw_ProductDetails
as
select p.product_name, b.brand_name, c.category_name, list_price from production.products p
inner join production.brands b on p.brand_id=b.brand_id
inner join production.categories c on p.category_id=c.category_id

SELECT * FROM vw_ProductDetails;

create view vw_CustomerOrders
as
select o.order_id, o.order_date, c.first_name, s.store_name, oi.quantity from sales.orders o
inner join sales.customers c on c.customer_id=o.customer_id
inner join sales.stores s on s.store_id=o.store_id
inner join sales.order_items oi on oi.order_id=o.order_id

SELECT * FROM vw_CustomerOrders

create view vw_StoreStockLevels
as
select st.store_name, p.product_name, s.quantity from production.stocks s
inner join production.products p on p.product_id=s.product_id
inner join sales.stores st on s.store_id=st.store_id

SELECT * FROM vw_StoreStockLevels WHERE quantity < 10;

create view vw_TopSellingProducts
as
select p.product_name, SUM(oi.quantity) AS total_quantity_sold, SUM(oi.list_price * (1 - oi.discount)) AS total_sales_amount from sales.order_items oi
inner join production.products p on p.product_id=oi.product_id
group by p.product_name

SELECT * FROM vw_TopSellingProducts
ORDER BY total_quantity_sold DESC;

create view vw_OrdersSummary
as
select o.order_date, count(oi.order_id) AS total_orders, SUM(oi.quantity) AS total_quantity_sold, SUM(oi.list_price * (1 - oi.discount)) AS total_sales_amount 
from sales.orders o
inner join sales.order_items oi on oi.order_id=o.order_id
group by o.order_date

SELECT * FROM vw_OrdersSummary
