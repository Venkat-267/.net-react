-- scalar valued function
create function sales.fun(@qty int, @price decimal(10,2), @discount decimal(4,2))
returns decimal(10,2)
as
begin
return @qty*@price*(1-@discount)
end

select sales.fun(20,10.9,2.6)

select order_id,sum(sales.fun(quantity, list_price,discount)) as net_value from sales.order_items
group by order_id
order by net_value

-- table valued function
create function prod_yr(@yr int)
returns table
as
return 
select product_name, model_year,list_price from production.products
where model_year=@yr

alter function fn_CalculateDiscountedPrice(@listPrice decimal(10,2), @discount decimal(4,2))
returns decimal(10,2)
as
begin
return @listPrice * (1 - (@discount));
end

select dbo.fn_CalculateDiscountedPrice(list_price,discount) as final from sales.order_items

alter function fn_GetFullCustomerName (@fName varchar(max), @lName varchar(max))
returns varchar(max)
as
begin
return @lName+', '+@fName
end

SELECT dbo.fn_GetFullCustomerName(first_name, last_name) AS full_name
FROM sales.customers;

create function fn_CalculateTotalOrderAmount(@oId int)
returns decimal(18,2)
as
begin
return (select SUM(quantity*list_price) from sales.order_items
WHERE order_id = @oId)
end

SELECT dbo.fn_CalculateTotalOrderAmount(1001) AS total_amount;

create function fn_GetProductsByBrand(@bId int)
returns table
as return
select product_id, product_name, category_id, list_price from production.products
WHERE brand_id=@bId

SELECT * FROM fn_GetProductsByBrand(3);

create function fn_GetOrdersByCustomer(@cId int)
returns table
as
return
select order_id, order_date,store_id, staff_id from sales.orders
WHERE customer_id=@cId

SELECT * FROM fn_GetOrdersByCustomer(5);

create function fn_GetStockByStore(@sId int)
returns table
as
return
select s.product_id, p.product_name, s.quantity from production.stocks s
Inner join production.products p on p.product_id=s.product_id
WHERE s.store_id=@sId

select * from fn_GetStockByStore(1)