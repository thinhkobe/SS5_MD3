create database quanlihocvien;
use quanlihocvien;
create table student
(
    rn     int primary key auto_increment,
    name   varchar(50) not null,
    age    numeric check ( age > 0 and age < 150 ),
    status bit
);
create table test
(
    testID   int primary key,
    testName varchar(50) not null
);
create table studentTest
(
    rn     int,
    foreign key (rn) references student (rn),
    testID int,
    foreign key (testID) references test (testID),
    date   datetime default current_timestamp,
    mark   int

);
-- Insert data into the 'student' table
INSERT INTO student (name, age, status)
VALUES ('Nguyen Hong Ha', 20, 1),
       ('Truong Ngoc Anh', 30, 1),
       ('Tuan Minh', 25, 1),
       ('Dan Truong', 22, 1);

-- Insert data into the 'test' table
INSERT INTO test (testID, testName)
VALUES (1, 'EPC'),
       (2, 'DWMX'),
       (3, 'SQL1'),
       (4, 'SQL2');

-- Insert data into the 'studentTest' table
INSERT INTO studentTest (rn, testID, date, mark)
VALUES (1, 1, '2006-07-17', 8),
       (2, 1, '2006-07-18', 5),
       (3, 1, '2006-07-19', 7),
       (1, 2, '2006-07-17', 7),
       (2, 2, '2006-07-18', 4),
       (3, 2, '2006-07-19', 2),
       (1, 3, '2006-07-17', 10),
       (3, 3, '2006-07-18', 1);

#Sử dụng alter để sửa đổi
#Thêm ràng buộc dữ liệu cho cột age với giá trị thuộc khoảng: 15-55
alter table student
    modify age int not null check ( age between 15 and 55);

#Thêm giá trị mặc định cho cột mark trong bảng StudentTest là 0

alter table studentTest
    modify mark int default 0;
#Thêm khóa chính cho bảng studenttest là (RN,TestID)
alter table studentTest
    ADD PRIMARY KEY (rn, testID);

#Thêm ràng buộc duy nhất (unique) cho cột name trên bảng Test
alter table test
    ADD CONSTRAINT UC_Test_Name UNIQUE (testName);
-- Xóa unique constraint từ cột 'name' trong bảng Test (MySQL)
ALTER TABLE test
    DROP INDEX UC_Test_Name;

select S.name,T.testName,mark,date
from student S join studentTest sT on S.rn = sT.rn
join test T on T.testID = sT.testID;

#Hiển thị danh sách các bạn học viên chưa thi môn nào như hình sau:
SELECT s.rn, s.name
FROM student s
         LEFT JOIN studentTest st ON s.rn = st.rn
WHERE st.rn IS NULL;
#Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm thi(điểm phải thi lại là điểm nhỏ hơn 5)
select S.rn,S.name,st.mark,t.testName,date
from  student S
join studentTest sT on S.rn = sT.rn
join test t on t.testID = sT.testID
where mark<5;
#Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần

select S.rn,S.name,AVG(mark)
from student S join studenttest s2 on S.rn = s2.rn
join quanlihocvien.test t on s2.testID = t.testID
group by S.rn;

#Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất



select test.testName ,max(s.mark)
from test join quanlihocvien.studenttest s on test.testID = s.testID
group by test.testID;

#Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi nếu học viên chưa thi môn nào thì phần tên môn học để Null như sau:
select S.name,T.testname
from student S left join studentTest sT on S.rn = sT.rn
left join test t on t.testID = sT.testID;

#Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi.
update student set age=age+1;
select * from  student;
#sua trường tên là Status có kiểu Varchar(10) vào bảng Student.
alter table student
modify status varchar(10);

update student set status = IF(Age < 30, 'Young', 'Old');

select S.name,T.testname,mark,sT.date
from student S join studentTest sT on S.rn = sT.rn
join test t on t.testID = sT.testID
order by date;


select S.name,S.age,avg(mark) as avg
from student S  join studentTest sT on S.rn = sT.rn
group by S.rn
having avg>4.5;

#Hiển thị các thông tin sinh viên (Mã, tên, tuổi, điểm trung bình, xếp hạng).
# Trong đó, xếp hạng dựa vào điểm trung bình của học viên, điểm trung bình cao nhất thì xếp hạng 1.

select S.rn, S.name,S.age,avg(mark),row_number() over () as 'xep hang'
from student S join studentTest sT on S.rn = sT.rn
group by S.rn;

alter table student
modify name nvarchar(255);

UPDATE student
SET name =
        CASE
            WHEN age > 20 THEN CONCAT('Old ', name)
            WHEN age <= 20 THEN CONCAT('Young ', name)
            END;
# Xóa tất cả các môn học chưa có bất kỳ sinh viên nào thi.
delete from test
where testID not in (select testID from studentTest);
select * from studentTest;

DELETE FROM studentTest
WHERE mark <= 5;