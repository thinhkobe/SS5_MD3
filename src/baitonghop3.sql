create database quanlibai3
;
use quanlibai3
;
create table customer(
                         cID int primary key ,
                         cName varchar(25),
                         cAge tinyint
);
create table product (
                         pID int primary key ,
                         pName varchar(25),
                         pPrice int
);
create table orders(
                       oID int primary key ,
                       cID int ,
                       foreign key (cID) references customer(cID),
                       oDate datetime default current_timestamp,
                       oTotalPrice int
);
create table orderdetail(
                            oID int,
                            foreign key (oID) references orders (oID),
                            pID int,
                            foreign key (pID)references product(pID),
                            odQTY int
);
-- Insert data into the Customer table
INSERT INTO customer (cID, cName, cAge) VALUES
                                            (1, 'Minh Quan', 10),
                                            (2, 'Ngoc Oanh', 20),
                                            (3, 'Hong Ha', 50);

-- Insert data into the Orders table
INSERT INTO orders (oID, cID, oDate, oTotalPrice) VALUES
                                                      (1, 1, '2006-03-21', NULL),
                                                      (2, 2, '2006-03-23', NULL),
                                                      (3, 1, '2006-03-16', NULL);

-- Insert data into the Product table
INSERT INTO product (pID, pName, pPrice) VALUES
                                             (1, 'May Giat', 3),
                                             (2, 'Tu Lanh', 5),
                                             (3, 'Dieu Hoa', 7),
                                             (4, 'Quat', 1),
                                             (5, 'Bep Dien', 2);

-- Insert data into the OrderDetail table
INSERT INTO orderdetail (oID, pID, odQTY) VALUES
                                              (1, 1, 3),
                                              (1, 3, 7),
                                              (1, 4, 2),
                                              (2, 1, 1),
                                              (2, 3, 8),
                                              (2, 5, 4),
                                              (3, 2, 3);

#1.Hiển thị các thông tin  gồm oID,cID, oDate, oTotalPrice của tất cả các hóa đơn trong bảng Orders,
# danh sách phải sắp xếp theo thứ tự ngày tháng, hóa đơn mới hơn nằm trên như hình sau:
select oID, cID, oDate, oTotalPrice
    from orders
order by oDate;
#2.Hiển thị tên và giá của các sản phẩm có giá cao nhất như sau:

#Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách đó như sau:

#Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào như sau:

#Hiển thị chi tiết của từng hóa đơn như sau

#Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
# (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn.
# Giá bán của từng loại được tính = odQTY*pPrice) như sau

#Tạo một view tên là Sales để hiển thị tổng doanh thu của siêu thị như sau:

# Xóa tất cả các ràng buộc khóa ngoại, khóa chính của tất cả các bảng.

#   Tạo một trigger tên là cusUpdate trên bảng Customer,
#   sao cho khi sửa mã khách (cID) thì mã khách trong bảng Order cũng được sửa theo:

# Tạo một stored procedure tên là delProduct nhận vào 1 tham số là tên của một sản phẩm,
# strored procedure này sẽ xóa sản phẩm có tên được truyên vào thông qua tham số,
# và các thông tin liên quan đến sản phẩm đó ở trong bảng OrderDetail
