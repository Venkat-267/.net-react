create procedure ListProd
as
begin
select * from production.products order by product_name
end

exec ListProd

create procedure findprod(@lp as decimal)
as begin
select product_name, list_price from production.products
where list_price>@lp
order by product_name
end

exec findprod 3499.99

create procedure usp_GetProductsByCategory(@cId INT)
as
begin
select p.product_name, b.brand_name, p.list_price from production.products p
inner join production.brands b on p.brand_id=b.brand_id
where p.category_id=@cId
end

exec usp_GetProductsByCategory 3

create procedure usp_AddCustomer
(@fname    VARCHAR(50),
    @lname    VARCHAR(50),
    @ph       VARCHAR(20),
    @mail     VARCHAR(100),
    @st       VARCHAR(100),
    @city     VARCHAR(50),
    @state    VARCHAR(50),
    @zipcode  VARCHAR(10))
as
begin
insert into sales.customers(first_name, last_name, phone, email, street,city, state, zip_code)
values(@fname,@lname,@ph,@mail,@st,@city,@state,@zipcode)
end

EXEC usp_AddCustomer 
    @fname = 'John',
    @lname = 'Doe',
    @ph = '123-456-7890',
    @mail = 'john.doe@example.com',
    @st = '123 Main St',
    @city = 'New York',
    @state = 'NY',
    @zipcode = '10001';

create procedure usp_UpdateProductStock(@sid int, @pid int, @stockQuantity int)
as
begin
update production.stocks set quantity = @stockQuantity
where store_id =@sid and product_id= @pid
end

exec usp_UpdateProductStock 1, 1, 30

create procedure usp_GetOrderDetails @oId int
as begin
select o.order_date, c.first_name, s.store_name, p.product_name, oi.quantity, oi.list_price from sales.orders o
INNER JOIN sales.customers c ON o.customer_id = c.customer_id
INNER JOIN sales.stores s ON o.store_id = s.store_id
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
INNER JOIN production.products p ON oi.product_id = p.product_id
WHERE o.order_id = @oId;
end

exec usp_GetOrderDetails 1

create procedure usp_GetTotalSalesByStore(@sDate date, @eDate date)
as
begin
select s.store_name,  SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales_amount
FROM sales.orders o
INNER JOIN sales.stores s ON o.store_id = s.store_id
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
WHERE o.order_date BETWEEN  @sDate and @eDate
GROUP BY s.store_name;
end
