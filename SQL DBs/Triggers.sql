CREATE TABLE production.product_audits(  product_id INT NOT NULL, product_name VARCHAR(255) NOT NULL, brand_id INT NOT NULL, updated_at DATETIME NOT NULL, operation CHAR(3) NOT NULL, CHECK(operation = 'INS' or operation='DEL') );

CREATE TRIGGER production.trg_pro_audit
ON production.products
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO production.product_audits(product_id, product_name, brand_id, updated_at, operation)
SELECT i.product_id, i.product_name, i.brand_id, GETDATE(), 'INS'
FROM inserted i
UNION ALL
SELECT d.product_id, d.product_name, d.brand_id, GETDATE(), 'DEL'
FROM deleted d;
END

INSERT INTO production.products( product_name, brand_id, category_id, model_year, list_price ) VALUES ( 'Test product', 1, 1, 2018, 599 );

SELECT*FROM production.product_audits;

-- Creating an AFTER-INSERT Trigger to Log New Orders
CREATE TABLE sales.order_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    customer_id INT,
    log_timestamp DATETIME NOT NULL DEFAULT GETDATE()
);

create trigger trg_log_new_order
on sales.orders
after insert
as
begin
INSERT into sales.order_log (order_id, order_date, customer_id, log_timestamp)
select i.order_id, i.order_date, i.customer_id, GETDATE() from inserted i
end

-- AFTER UPDATE Trigger to Track Price Changes

CREATE TABLE production.price_change_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    old_price DECIMAL(10, 2) NOT NULL,
    new_price DECIMAL(10, 2) NOT NULL,
    change_date DATETIME NOT NULL DEFAULT GETDATE()
);

create trigger trg_log_price_change
on production.products
after update
as
begin
INSERT INTO production.price_change_log (product_id, old_price, new_price, change_date)
SELECT d.product_id,d.list_price AS old_price,i.list_price AS new_price,GETDATE()
FROM deleted d
INNER JOIN inserted i ON d.product_id = i.product_id
WHERE d.list_price <> i.list_price
end

-- instead of delete
CREATE TRIGGER trg_prevent_customer_delete
ON sales.customers
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN sales.orders o ON d.customer_id = o.customer_id
    )
    BEGIN
        RAISERROR('Cannot delete customer with existing orders.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM sales.customers
        WHERE customer_id IN (SELECT customer_id FROM deleted);
    END
END;

delete from sales.customers WHERE customer_id  = 1

-- Update raise error
CREATE TRIGGER trg_prevent_negative_stock
ON production.stocks
AFTER UPDATE
AS
BEGIN
IF EXISTS (SELECT 1 FROM inserted i WHERE i.quantity < 0)
BEGIN
RAISERROR('Stock quantity cannot be reduced below zero.', 16, 1);
ROLLBACK TRANSACTION;
END
END;

UPDATE production.stocks
SET quantity = 4
WHERE product_id = 101 AND store_id = 1;
