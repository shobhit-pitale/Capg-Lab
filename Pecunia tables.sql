create schema EmployeeService;
go

create table EmployeeService.Admin(
	   AdminID UniqueIDentifier constraint PK_EmployeeService_Admin_AdminID Primary Key,
	   AdminName varchar(50) not null,
       Email varchar(20) unique Not null,
   	   AdminPassword varchar(15) not null,
	   CreationDateTime DateTime default SysDateTime(),
       LastModifiedDatetime Datetime default SysDateTime()
	   )

create table EmployeeService.Employees(

	   EmployeeID UniqueIDentifier constraint PK_EmployeeService_Employee_EmployeeID Primary Key,
	   EmployeeName varchar(50) not null,
       Email varchar(20) unique Not null,
   	   EmployeePassword varchar(15) not null,
	   CreationDateTime DateTime default SysDateTime(),
       LastModifiedDatetime Datetime default SysDateTime()
	
)
go

--Created BY Asmita Chandrakar
--script to create table
CREATE TABLE CustomerService.Customer
( CustomerID  Uniqueidentifier  constraint PK_Customer_CustomerID primary key,
  CustomerNumber char(6) not null, 
  CustomerName   varchar(40) not null check(CustomerName>2 and CustomerName<40),
  CustomerMobile char(10) not null,
  CustomerAddress varchar(200) not null check (CustomerAddress>2 and CustomerAddress<200),
  CustomerAadharNumber char(12) not null,
  CustomerPANNumber char(10) not null,
  CustomerGender varchar(12) not null,
  CustomerDOB    datetime not null,
  Email       varchar(50) not null,
  WorkExperience decimal not null check (WorkExperience>0),
  AnnualIncome   decimal not null check (AnnualIncome>0) ,
  CreationDateTime  datetime not null DEFAULT sysdatetime(),
  LastModified    datetime not null default sysdatetime()
  )
  go


---CREATED BY AKASH KUMAR SINGH
---MODULE- ACCOUNTS
---CREATED ON 
  CREATE TABLE CustomerService.RegularAccount
(AccountID uniqueidentifier constraint PK_RegularAccount_AccountID primary key,
	CustomerID uniqueidentifier NOT NULL constraint FK_RegularAccount_CustomerID foreign key references CustomerService.Customer(CustomerID),
	AccountNo char(10) NOT NULL check(AccountNo like '_________'),
	CurrentBalance money NOT NULL default 0 check(CurrentBalance >= 0),
	AccountType varchar(10) NOT NULL check(AccountType = 'Savings' OR AccountType = 'Current'),
	Branch varchar(30) NOT NULL check(Branch = 'Delhi' OR Branch = 'Mumbai'OR Branch = 'Chennai'OR Branch = 'Bengaluru' ),
	Status char(10) NOT NULL default 'Active' check(Status ='Active' OR Status = 'Closed'),
	MinimumBalance money NOT NULL default 500 check(MinimumBalance > 0),
	InterestRate decimal NOT NULL default 3.5 check(InterestRate > 0),
	CreationDateTime datetime NOT NULL default SysDateTime(),
	LastModifiedTime datetime NOT NULL default SysDateTime())

GO


---CREATED TABLE FIXED ACCOUNT
CREATE TABLE CustomerService.FixedAccount
(AccountID uniqueidentifier constraint PK_FixedAccount_AccountID primary key,
	CustomerID uniqueidentifier NOT NULL constraint FK_FixedAccount_CustomerID foreign key references CustomerService.Customer(CustomerID),
	AccountNo char(10) NOT NULL check(AccountNo like '_________'),
	CurrentBalance money default 0 check(CurrentBalance >= 0) ,
	AccountType varchar(10) NOT NULL check(AccountType = 'Fixed'),
	Branch varchar(30) NOT NULL check(Branch = 'Delhi' OR Branch = 'Mumbai'OR Branch = 'Chennai'OR Branch = 'Bengaluru' ),
	Tenure decimal NOT NULL check(tenure > 0),
	FDDeposit money NOT NULL check(FDDeposit > 0),
	Status char(10) NOT NULL default 'Active' check(Status ='Active' OR Status = 'Closed'),
	MinimumBalance money NOT NULL default 500 check(MinimumBalance > 0),
	InterestRate decimal NOT NULL default 3.5 check(InterestRate > 0),
	CreationDateTime datetime NOT NULL default SysDateTime(),
	LastModifiedTime datetime NOT NULL default SysDateTime())
GO


---Create Car Loan Table--- 	
	CREATE TABLE Loans.CarLoan
(LoanID varchar(36) constraint PK_CarLoan_LoanID primary key,
	CustomerID varchar(36)  NOT NULL constraint FK_CarLoan_CustomerNo foreign key references Loans.Customer(CustomerID),
	LoanNumber int IDENTITY(1000,1)  NOT NULL ,
	LoanAmount money NOT NULL default 0 check(LoanAmount >= 0),
	LoanType varchar(20) NOT NULL,
	LoanStatus varchar(10) NOT NULL check(LoanStatus = 'Pending' OR LoanStatus = 'Approved' OR LoanStatus = 'Rejected'),
	LoanDuration Decimal NOT NULL check(LoanDuration >= 0),
	License char(15) NOT NULL, 
	CreationDateTime datetime NOT NULL ,
	LastModifiedTime datetime NOT NULL )


	---Create Ëducation Loan Table--- 	
	CREATE TABLE Loans.EducationLoan
(LoanID varchar(36) constraint PK_EducationLoan_LoanID primary key,
	CustomerID varchar(36)  NOT NULL constraint FK_EducationLoan_CustomerNo foreign key references Loans.Customer(CustomerID),
	LoanNumber int IDENTITY(1000,1)  NOT NULL ,
	LoanAmount money NOT NULL default 0 check(LoanAmount >= 0),
	LoanStatus varchar(10) NOT NULL check(LoanStatus = 'Pending' OR LoanStatus = 'Approved' OR LoanStatus = 'Rejected'),
	LoanDuration Decimal NOT NULL check(LoanDuration >= 0),
	Collateral money NOT NULL, 
	CollegeName Varchar(50) NOT NULL,
	AdmissionID Varchar(50) NOT NULL,
	Sponseror Varchar(50) NOT NULL,
	CreationDateTime datetime NOT NULL ,
	LastModifiedTime datetime NOT NULL )

	---Create Personal Loan Table--- 	
	CREATE TABLE Loans.PersonalLoan
(LoanID varchar(36) constraint PK_PersonalLoan_LoanID primary key,
	CustomerID varchar(36)  NOT NULL constraint FK_PersonalLoan_CustomerNo foreign key references Loans.Customer(CustomerID),
	LoanNumber int IDENTITY(1000,1)  NOT NULL ,
	LoanAmount money NOT NULL default 0 check(LoanAmount >= 0),
	LoanStatus varchar(10) NOT NULL check(LoanStatus = 'Pending' OR LoanStatus = 'Approved' OR LoanStatus = 'Rejected'),
	LoanDuration Decimal NOT NULL check(LoanDuration >= 0),
	Collateral money NOT NULL, 
	CreationDateTime datetime NOT NULL ,
	LastModifiedTime datetime NOT NULL )

	 create table CustomerService.CreditCard
(
       CreditCardID varchar(12) constraint PK_CustomerService_CreditCard_CreditCardID   Primary Key,
       CustomerID UniqueIDentifier constraint FK_CreditCard_Customer_CustomerID      References CustomerService.Customer(CustomerID),
	   CustomerNameAsPerCard varchar(50) not null,
       CardNumber char(12) constraint  UQ_CustomerService_CreditCard_CardNumber UNIQUE,
   	   CreditLimit decimal not null,
       ExpiryMMYYYY varchar(7) not null,
       CardType varchar(20) not null,
       CardStatus varchar(12) not null ,
	   CardIssueDate DateTime default SysDateTime(),
       LastModifiedDate Datetime default SysDateTime())
		 Go

		 /*

Table for storing Debit card details under customer service schema

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

		 create table CustomerService.DebitCard
(
        DebitCardID UNIQUEIDENTIFIER constraint PK_CustomerService_DebitCard_DebitCardID  Primary Key,
        AccountID UniqueIDentifier constraint FK_DebitCard_RegularAccount_AccountID References CustomerService.RegularAccount(AccountID),
	    CustomerNameAsPerCard varchar(50) not null,
        CardNumber char(12) CONSTRAINT UQ_CustomerService_DebitCard_CardNumber UNIQUE,
        ExpiryMMYYYY varchar(7) not null,
        CardType varchar(20) not null,
        CardStatus varchar(12) not null ,
		CardIssueDate DateTime default SysDateTime(),
        LastModifiedDate Datetime default SysDateTime())
		 Go

		 /*

Table for storing Cheque book details under customer service schema

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

		use PecuniaBanking
		create table CustomerService.ChequeBook
(
       ChequeBookID varchar(12) constraint PK_CustomerService_ChequeBook_ChequeBookID Primary Key,
       AccountID UniqueIDentifier constraint FK_ChequeBook_RegularAccount_AccountID References CustomerService.RegularAccount(AccountID),
	   AccountNo char(10) not null,
	   SeriesStart decimal CONSTRAINT UQ_CustomerService_ChequeBook_SeriesStart UNIQUE,
       NumberOfLeaves int not null,
       ChequeBookStatus varchar(12) not null,
	  ChequeBookRequestDate  DateTime,
		LastModifiedDate Datetime)
		 go