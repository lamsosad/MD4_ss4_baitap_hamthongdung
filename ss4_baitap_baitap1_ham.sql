CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;
CREATE TABLE Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
CREATE TABLE Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
CREATE TABLE Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);
insert into Class(ClassName,StartDate,Status) values
("A1","2008-12-20",1),
("A2","2008-12-22",1),
("B3",now(),0);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId) VALUES 
('Hung', 'Ha Noi', '0912113113', 1, 1),
('Hoa', 'Hai phong',null, 1, 1),
('Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO `Subject`(SubName,Credit,Status)
VALUES ('Toan', 5, 1),
       ('Van', 6, 1),
       ('Anh', 5, 1),
       ('Hoa', 10, 1);
       
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 50, 1),
       (2, 2, 10, 2),
       (2, 1, 20, 2),
       (3, 3, 55, 2),
       (4, 2, 60, 2);
select * from `Subject` where Subject.credit = ( select max(Subject.credit) from  `Subject`);
select Subject.SubId,Subject.SubName,Mark.Mark from `Subject` join Mark on Subject.SubId=Mark.SubId where Mark.Mark = ( select max(Mark.Mark) from  `Mark`);
select Student.StudentId,Student.StudentName,Student.Address,Student.Phone, avg(Mark.Mark) as "Mark" 
from `Student` join `Mark` on Student.StudentId=Mark.StudentId group by Student.StudentId order by avg(Mark.Mark) desc;
