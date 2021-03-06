IF OBJECT_ID('tempdb..#AUTHORS') IS NOT NULL
	DROP TABLE #AUTHORS;

SELECT *,ROW_NUMBER() OVER (ORDER BY author_id) AS ID
INTO #AUTHORS
  FROM [BookStoresDB].[dbo].[Author];

UPDATE auth
set auth.author_id = temp.id
FROM Author auth
inner join #AUTHORS temp on temp.author_id = auth.author_id;

-----------------------------------------------

alter table BookAuthor alter column author_id int not null; 

-----------------------------------------------

IF OBJECT_ID('tempdb..#BOOKS') IS NOT NULL
	DROP TABLE #BOOKS;

SELECT *,ROW_NUMBER() OVER (ORDER BY book_id) AS ID
INTO #BOOKS
  FROM [BookStoresDB].[dbo].Book;

UPDATE boo
set boo.book_id = temp.id
FROM Book boo
inner join #BOOKS temp on temp.book_id = boo.book_id;

-----------------------------------------------

alter table BookAuthor alter column book_id int not null; 

-----------------------------------------------

ALTER TABLE Book  
DROP CONSTRAINT UPKCL_titleidind;   
GO  

alter table Book 
alter column book_id int not null

alter table Book add primary key (book_id)

-----------------------------------------------

IF OBJECT_ID('tempdb..#BOOKS') IS NOT NULL
	DROP TABLE #BOOKS;

SELECT *,ROW_NUMBER() OVER (ORDER BY book_id) AS ID
INTO #BOOKS
  FROM [BookStoresDB].[dbo].Book;

UPDATE boo
set boo.book_id = temp.id
FROM Book boo
inner join #BOOKS temp on temp.book_id = boo.book_id;

-----------------------------------------------


ALTER TABLE [dbo].BookAuthor  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Book] ([book_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].BookAuthor  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[Author] ([author_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

-----------------------------------------------

alter table Sale alter column book_id int not null; 

-----------------------------------------------

ALTER TABLE [dbo].Sale  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].book ([book_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO


-----------------------------------------------

IF OBJECT_ID('tempdb..#PUBLISHERS') IS NOT NULL
	DROP TABLE #PUBLISHERS;

SELECT *,ROW_NUMBER() OVER (ORDER BY pub_id) AS ID
INTO #PUBLISHERS
  FROM [BookStoresDB].[dbo].Publisher;

UPDATE PUB
set PUB.pub_id = temp.id
FROM Publisher PUB
inner join #PUBLISHERS temp on temp.pub_id = PUB.pub_id;

-----------------------------------------------

alter table dbo.users alter column pub_id int not null; 

-----------------------------------------------

ALTER TABLE Publisher  
DROP CONSTRAINT PK__Publishe__2515F222EBFB7C30;   
GO  

alter table Publisher 
alter column pub_id int not null

alter table Publisher add primary key (pub_id)

-----------------------------------------------

ALTER TABLE [dbo].Users  WITH CHECK ADD FOREIGN KEY([pub_id])
REFERENCES [dbo].Publisher ([pub_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

---------------------------------------

alter table Book alter column pub_id int not null;

---------------------------------------

ALTER TABLE [dbo].Book  WITH CHECK ADD FOREIGN KEY([pub_id])
REFERENCES [dbo].Publisher ([pub_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO 

---------------------------------------

USE [BookStoresDB]
GO

set IDENTITY_INSERT [Author2] ON;

INSERT INTO [dbo].[Author2]
           (author_id
		   ,[last_name]
           ,[first_name]
           ,[phone]
           ,[address]
           ,[city]
           ,[state]
           ,[zip])
     SELECT * from Author
GO

set IDENTITY_INSERT [Author2] OFF;

---------------------------------------

USE [BookStoresDB]
GO

set IDENTITY_INSERT Book2 ON;

INSERT INTO [dbo].[Book2]
           (book_id
		   ,[title]
           ,[type]
           ,[pub_id]
           ,[price]
           ,[advance]
           ,[royalty]
           ,[ytd_sales]
           ,[notes]
           ,[published_date])
     SELECT * from Book
GO

set IDENTITY_INSERT Book2 OFF;

---------------------------------------

USE [BookStoresDB]
GO

-- set IDENTITY_INSERT [User2] ON;

INSERT INTO [dbo].[User2]
           ([email_address]
           ,[password]
           ,[first_name]
           ,[middle_name]
           ,[last_name]
           ,[job_id]
           ,[job_level]
           ,[pub_id]
           ,[hire_date])
    SELECT user_id + '@gmail.com',password,first_name,middle_name,last_name,job_id,job_level,pub_id,hire_date FROM [User];

GO

-- set IDENTITY_INSERT [User2] OFF;

INSERT INTO [dbo].[User2]
           ([email_address]
           ,[password]
           ,[source]
           ,[first_name]
           ,[middle_name]
           ,[last_name]
           ,[job_id]
           ,[job_level]
           ,[pub_id]
           ,[hire_date])
     SELECT email_address,password, 'APPC', first_name,middle_name, last_name, job_id, job_level, pub_id, hire_date from [User] 
GO

ALTER TABLE RefreshToken  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO




