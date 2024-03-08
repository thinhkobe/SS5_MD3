
-- Bước 1: Tạo CSDL QuanLySinhVien
CREATE DATABASE QuanLySinhVien;
-- Bước 2: Chọn Database QuanLySinhVien để thao tác với cơ sở dữ liệu này:
USE QuanLySinhVien;
-- Bước 3: Tiếp theo sử dụng câu lệnh Create Table để tạo bảng Class với các trường ClassId, ClassName, StartDate, Status như sau:
CREATE TABLE Class
(
    ClassID   INT AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
-- Bước 4: Tạo bảng Student với các thuộc tính StudentId, StudentName, Address, Phone, Status, ClassId với rằng buộc như sau:
CREATE TABLE Student
(
    StudentId   INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
-- Bước 5: Tạo bảng Subject với các thuộc tính SubId, SubName, Credit, Status với các ràng buộc như sau :
CREATE TABLE Subject
(
    SubId   INT AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);
-- Bước 6: Tạo bảng Mark với các thuộc tính MarkId, SubId, StudentId, Mark, ExamTimes với các ràng buộc như sau :
CREATE TABLE Mark
(
    MarkId    INT AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

USE QuanLySinhVien;
INSERT INTO Class
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (3, 'B3', current_date, 0);
-- Bước 3: Thêm dữ liệu vào trong bảng Student bằng các câu lệnh insert into như sau:
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);
-- Bước 4: Thêm dữ liệu nhanh vào trong bảng Subject:
INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);
-- Bước 5: Thêm dữ liệu vào trong bảng Mark bằng câu lệnh insert into như sau:
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);
select S.studentID,S.studentName,Sub.SubName,M.Mark
from Student S join Mark M on S.studentID=M.studentID
               join Subject Sub on M.SubID=Sub.SubID
where Sub.SubName='CF';
select *
from Student where Student.studentname like 'h%';
select*
from Class where DATE_FORMAT(startdate, '%m') = '12';

select*
from subject  where credit between 3 and 5;

update Student set ClassId=2 where StudentName='Hung';
select S.studentName,Sub.SubName,M.Mark
from student S
         join mark M on m.studentID=S.studentID
         join subject sub on M.SubId=sub.SubId;

#Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from subject where (select max(Credit));
#Hiển thị các thông tin môn học có điểm thi lớn nhất.
select m.SubId,SubName,Mark 'diem cao nhat' from subject
                                                     join quanlysinhvien.mark m on subject.SubId = m.SubId
where (select max(Mark));
#Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select StudentName,avg(m.Mark) ' diem trung binh' from student
                                                           join quanlysinhvien.mark m on student.StudentId = m.StudentId
group by m.StudentId;
