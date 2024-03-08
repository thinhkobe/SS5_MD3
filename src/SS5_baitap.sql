create database demo;
use demo;
CREATE TABLE IF NOT EXISTS Products
(
    Id                 INT AUTO_INCREMENT PRIMARY KEY,
    productCode        VARCHAR(20)    NOT NULL,
    productName        VARCHAR(255)   NOT NULL,
    productPrice       DECIMAL(10, 2) NOT NULL,
    productAmount      INT            NOT NULL,
    productDescription TEXT,
    productStatus      BOOLEAN        NOT NULL
);

-- Chèn dữ liệu mẫu
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES ('P001', 'Laptop', 999.99, 50, 'High-performance laptop', true),
       ('P002', 'Smartphone', 499.99, 100, 'Latest smartphone model', true),
       ('P003', 'Tablet', 299.99, 30, 'Portable tablet device', true),
       ('P004', 'Headphones', 79.99, 200, 'Wireless over-ear headphones', true),
       ('P005', 'Smartwatch', 149.99, 50, 'Fitness tracking smartwatch', false);

-- Tạo Unique Index trên cột productCode
CREATE UNIQUE INDEX idx_productCode ON Products (productCode);

-- Tạo Composite Index trên các cột productName và productPrice
CREATE INDEX idx_productName_productPrice ON Products (productName, productPrice);

-- Mô phỏng một câu lệnh SELECT trước khi tạo chỉ mục
EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P001';

-- Mô phỏng một câu lệnh SELECT sau khi tạo chỉ mục
EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P001';

create view view_Product as
select productCode, productName, productPrice
from Products;
select *
from Products;

-- Sửa đổi view, ví dụ thêm cột productDescription
    ALTER VIEW view_Product AS
    SELECT productCode, productName, productPrice, productStatus, productDescription
    FROM Products;

drop view view_Product;

delimiter //
create procedure testProcedure(in_ID int)
begin
    select *
    from Products
    where Id = in_ID;
end //

call testProcedure(2);

DELIMITER //
CREATE PROCEDURE AddNewProduct(
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(255),
    IN p_productPrice DECIMAL(10, 2),
    IN p_productAmount INT,
    IN p_productDescription TEXT,
    IN p_productStatus BOOLEAN
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription, p_productStatus);
END //
DELIMITER ;

CALL AddNewProduct('P006', 'New Product', 129.99, 10, 'Description for new product', true);
#Tạo stored procedure sửa thông tin sản phẩm theo id
DELIMITER //
CREATE PROCEDURE UpdateProductById(
    IN p_productId INT,
    IN p_productName VARCHAR(255),
    IN p_productPrice DECIMAL(10, 2),
    IN p_productAmount INT,
    IN p_productDescription TEXT,
    IN p_productStatus BOOLEAN
)
BEGIN
    UPDATE Products
    SET productName        = p_productName,
        productPrice       = p_productPrice,
        productAmount      = p_productAmount,
        productDescription = p_productDescription,
        productStatus      = p_productStatus
    WHERE Id = p_productId;
END //
DELIMITER ;

#Tạo stored procedure xoá sản phẩm theo id
DELIMITER //
CREATE PROCEDURE DeleteProductById(
    IN p_productId INT
)
BEGIN
    DELETE FROM Products WHERE Id = p_productId;
END //
DELIMITER ;
