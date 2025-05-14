create table courses(
id int identity primary key,
Name varchar(max)
)
insert into courses(name) values('C#'),('MsSql')
-- transaction
begin transaction
insert into parts values(8,'Ethernet')
update courses set Name='Python' where id=5
if @@ROWCOUNT=0
	rollback transaction
else
	commit transaction

select* from production.products order by product_id desc
select * from sales.orders order by order_id desc
select * from sales.order_items order by order_id desc

-- transaction rollback statement for orders and order items
create procedure usp_PlaceSimpleOrder
as 
begin
	begin try
		begin transaction
		insert into sales.orders(customer_id,order_status,order_date,required_date,store_id,staff_id)
		values(2,4,getdate(),getdate(),1,2)
		insert into sales.order_items(order_id,item_id,product_id,quantity,list_price,discount)
		values(1619,1,325,20,379.99,0.1),(1619,2,326,30,749.99,0.1)
		commit transaction
	end try
	begin catch
		rollback transaction
	end catch
end