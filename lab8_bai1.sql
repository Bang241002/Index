if exists (select * from sys.databases where name = 'RiverPlate')
	drop database RiverPlate
create database RiverPlate
use RiverPlate

-- Tạo bảng Student
create table Student (
	StudentNo int primary key,
	StudentName varchar(50),
	StudentAddress varchar(100),
	PhoneNo int
)


-- tạo bảng Department
create table Department (
	DeptNo int primary key,
	DeptName varchar(50),
	ManagerName char(30)
)


-- Tạo bảng Assignment
create table Assignment (
	AssignmentNo int primary key,
	Description varchar(100)
)


-- tạo bảng work-assign
create table Work_Assign (
	JobID int primary key,
	StudentNo int foreign key references Student(StudentNo),
	AssignmentNo int foreign key references Assignment(AssignmentNo),
	TotalHours int,
	JobDetails xml
)


-- yêu cầu 1
create index IX_Student on Student(StudentNo)


-- yêu cầu 2
alter index IX_Student on Student Disable


-- yêu cầu 3
create nonclustered index IX_Dept
on Department (DeptNo, DeptName, ManagerName)