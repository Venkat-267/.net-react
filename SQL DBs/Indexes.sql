create table parts(part_id int not null, part_name varchar(100))

insert into parts values
(1,'asd'),
(2,'mouse'),
(3,'dfghj'),
(4,'fan')

select * from parts where part_id=4

-- clustered index created using primary key
alter table parts add primary key(part_id)

-- non clustered index
select customer_id,city from sales.customers
where city='Atwater'

select customer_id,city from sales.customers
where customer_id=24

create nonclustered index index_city
on sales.customers(city)

CREATE CLUSTERED INDEX id_list_price
ON production.products(list_price);


CREATE CLUSTERED INDEX id_order_date
ON sales.orders(order_date);

create nonclustered index id_product_id
on sales.order_items(product_id)


begin try
declare @Numerator int = 10,