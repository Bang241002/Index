-- tạo CSDL và 2 bảng students và class
use master
Go
IF (DB_ID('Exam10Test') IS NOT NULL)
	DROP DATABASE Exam10test
ELSE
	CREATE DATABASE Exam10Test
Go
USE Exam10test 
Go
CREATE TABLE Class
(
	ClassID int IDENTITY,
	CLassName nvarchar(10),
	CONSTRAINT PK_Classes PRIMARY KEY (ClassID),
	CONSTRAINT UQ_CLassesClassname UNIQUE(ClassName)
)
CREATE TABLE Students
(
	RollNo Varchar(6) CONSTRAINT Pk_Students PRIMARY 
	FuLLName nvarchar(50) NOT NULL,
	EMail varchar(100) CONSTRAINT UQ_StudentsEmail UnIQUE 
	CLassName nvarchar(10) CONSTRAIT PK_Students_Classes FOREIGN KEY REFERENCES Class(CLassName) On UpDATE CASCADE

)
GO

CREATE INDEX IX_Email ON Students(Email)

--tạo bảng subjects
CREATE TABLE Subjects
(
	SubjectID int,
	SubjectName nvarchar(100)
)

--tạo chỉ mục Clustered
CREATE CLUSTERED INDEX IX_SubjectID
On Subjects(SubjectName)

--tạo chỉ mục Nonclustered
CREATE NONCLUSTERED INDEX IX_SubjectID
ON Subjects(SubjectID)

--tạo chỉ mục duy nhất
CREATE UNIQUE INDEX IX_UQ_SubjectName ON Subjects(subjectName)

--tảo chị mục kết hợp
CREATE INDEX IX_Name_Email On Students(Fullname, Email)

Go

--xoá chỉ mục IX_SubjectID
DROP INDEX IX_SubjectID ON Subjects
Go

--tạo chỉ mục IX_SubjectID mới với tuỳ chọn FiLLFACTOR
CREATE CLUSTERED INDEX IX_SubjectID ON Subjects(SubjectID)WITH (FILLFACTOR=60)

--xoá chỉ mục IX_SubjectID
DROP INDEX IX_SubjectID ON Subjects
GO
--tạo chỉ mục IX_SubjectID mpows vời tuỳ chọn PAD_INDEX  và FILLFACTOR
CREATE CLUSTERED INDEX IX_SubjectID oN Subjects(SubjectID)WITH (PAD_INDEX=ON, FILLFACTOR=60)
GO

--xem định nghĩa chỉ mục dùng sp_helptext
EXEC sp_helpindex 'Subject'
--hoặc
EXECUTE sp_helpindex 'Subject'
Go

--xây dựng lại chỉ mục IX_SubjectName
ALTER INDEX IX_SubjectName ON Subjects REBUILD 
--xây dựng lại chỉ mục IX_SubjectName với tuỳ chọn FILLFACTOR
ALTER INDEX IX_SubjectName ON Subjects REBUILD WITH (FILLFACTOR=60)

--vô hiệu hoá chỉ mục IX_SubjectName
ALTER INDEX IX_SubjectName ON Subjects DISABLE
--xây dựng lại chỉ mục IX_SubjectName tương đương làm cho chỉ mục có hiệu lực 
ALTER INDEX IX_SubjectName ON Subjects REBUILD
--làm chỉ mục IX_SubjectName tổ chức  lại
ALTER INDEX IX_SubjectName ON Subjects REORGANIZE

--thay đổi chỉ mục IX_SubjectName thành ONLINE chỉ áp dụng trên bảng Enterprise
ALTER INDEX IX_SubjectName ON Subjects REBUILD With(ONLINE=4)

--thao tác với chỉ mục song song 
ALTER INDEX IX_SubjectName ON Subjects REBUILD WITH (MAXDOP=4)

--chỉ mục với nhiều cột
ALTER INDEX IX_SubjectName_IncLude ON Students (Fullname) INCLUDE (Email, ClassName)
--truy vấn sau sẽ sử dụng chỉ mục IX_SubjectName_Include:
SELECT FullName, Email, ClassName FROM Students WHERE FullName like '%a%'

--xoá chỉ mục
DROP INDEX IX_SubjectName_Include ON Students

--tạo thống kê chỉ mục 
CREATE STATISTICS Statictics_Subjects ON Subjects(SubjectID)

--Cập nhật thống kê chi mục
UPDATE STATISTICS Subjects Statictics_Subjects

--xem thống kê chỉ mục
DBCC SHOW_STATISTICS (Subjects, Statictics_Subjects)