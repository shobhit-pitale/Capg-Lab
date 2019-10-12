--procedure to add employee

Create procedure AddEmployee (@empID uniqueidentifier, @empName varchar(50), @email varchar(20), @password varchar(15),@creationTime DateTime, @modifiedTime DateTime)
as

begin

begin try
if(len(@empName)<2 or len(@empName)>40)
	throw 100, 'Customer Name should be between 2 and 40 characters', 1;

if(exists(select * from EmployeeService.Employees where Email= @email))
	throw 5000,'Email Id Alraedy Exists',1;

Insert Into EmployeeService.Employees(EmployeeID, Email,EmployeePassword, CreationDateTime, LastModifiedDatetime) values(@empID, @email,@password,@creationTime,@modifiedTime)
end try

begin catch
	throw
end catch

end


go

-- procedure to update employee

create procedure UpdateEmployee( @empID uniqueidentifier, @empName varchar(40), @email varchar(20), @password varchar(15), @modifiedTime DateTime)
as
begin
if(not exists(select * from EmployeeService.Employees where EmployeeID= @empID))
	throw 5000, 'Employee not found', 1;
if(len(@empName)<2 or len(@empName)>40)
	throw 100, 'Customer Name should be between 2 and 40 characters', 1;
if(exists(select * from EmployeeService.Employees where Email= @email))
	throw 5000,'Email Id Alraedy Exists',1;

update EmployeeService.Employees
	set
		EmployeeName=@empName,
		Email=@email,
		EmployeePassword=@password,
		LastModifiedDateTime=@modifiedTime

		where EmployeeID = @empID
end

go

-- procedure to delete employee
create procedure DeleteEmployee (@empID uniqueIdentifier)
as 
begin
 delete from EmployeeService.Employees where EmployeeID=@empID;

end

go


--procedure for login of employee

create procedure EmployeeLogin(@email varchar(20), @password varchar(15),  @result integer Output)

as

begin
 
	if exists( select 1 from EmployeeService.Employees where Email=@email and EmployeePassword= @password) 
		select @result = 1; 
	 else  
		select @result = 0; 
end

go

-- procedure to get all the employees of the bank
create procedure getAllEmployees
as
begin

 select * from EmployeeService.Employees;
end

go





--Created by Asmita Chandrakar
  --Procedure to Add Customer
  create procedure 
  AddsCustomer(@CustomerID uniqueIdentifier ,@CustomerNumber char(6) ,@CustomerName varchar(40) ,@CustomerMobile char(10) ,@CustomerAddress varchar(200),@CustomerAadharNumber char(12) ,@CustomerPANNumber char(10),@CustomerGender varchar(12) , @CustomerDOB DateTime ,@Email varchar(50),@WorkExperience decimal,@AnnualIncome decimal,@CreationDateTime datetime ,@LastModified datetime)
  as
begin 
   

	insert into CustomerService.Customer(CustomerID,CustomerNumber,CustomerName,CustomerMobile,CustomerAddress,CustomerAadharNumber,CustomerPANNumber,CustomerGender,CustomerDOB,Email,WorkExperience,AnnualIncome,CreationDateTime,LastModified)
		values (@CustomerID,@CustomerNumber,@CustomerName,@CustomerMobile,@CustomerAddress,@CustomerAadharNumber,@CustomerPANNumber,@CustomerGender,@CustomerDOB,@Email,@WorkExperience,@AnnualIncome,@CreationDateTime,@LastModified)
end

go
--Created by Asmita Chandrakar
--Procedure to ViewCustomerBy customer Number
create procedure ViewsCustomerByCustomerNumber(@CustomerNumber char(6)) 
as
begin 
	select * from CustomerService.Customer where CustomerNumber= @CustomerNumber
end
go

--Created by Asmita Chandrakar
--Procedure to ViewCustomerBy customer Name

create procedure ViewsCustomerByCustomerName(@CustomerName varchar(40)) 
as
begin 
	select * from CustomerService.Customer where CustomerName= @CustomerName
end
go
--Created by Asmita Chandrakar
--Procedure to ViewCustomerBy customer PAN Number
create procedure ViewsCustomerByCustomerPANNumber(@CustomerPANNumber char(10)) 
as
begin 
	select * from CustomerService.Customer where CustomerPANNumber= @CustomerPANNumber
end
go
--Created by Asmita Chandrakar
--Procedure to ViewCustomerBy customer Aadhar Number
create procedure ViewsCustomerByCustomerAadharNumber(@CustomerAadharNumber char(12)) 
as
begin 
	select * from CustomerService.Customer where CustomerAadharNumber= @CustomerAadharNumber
end

go

--Created by Asmita Chandrakar
--Procedure to ViewCustomerBy customer EmailID
create procedure ViewsCustomerByEmail(@Email varchar(50)) 
as
begin 
	select * from CustomerService.Customer where Email= @Email
end
go
--Created by Asmita Chandrakar
--Procedure to ViewCustomerBy customer Mobile Number
create procedure ViewsCustomerByCustomerMobile(@CustomerMobile char(10)) 
as
begin 
	select * from CustomerService.Customer where CustomerMobile= @CustomerMobile
end
go
--Created by Asmita Chandrakar
--Procedure to View all customer
Create Procedure GetsAllCustomer
  AS
  BEGIN
  Select * From CustomerService.Customer
  End

  go
--Created by Asmita Chandrakar
--Procedure to Update customer based on customer number
create procedure UpdatesCustomer(@CustomerNumber char(6),@CustomerName varchar(40),@CustomerMobile char(10) ,@Email varchar(50),@CustomerAddress varchar(200) ,@LastModified DateTime) 
as
begin 

	 update CustomerService.Customer
		set

		CustomerName=@CustomerName,
		CustomerMobile=@CustomerMobile,
		Email=@Email,
		CustomerAddress=@CustomerAddress,
		LastModified=@LastModified

        where CustomerNumber=@CustomerNumber
end

go


create procedure CreateRegularAccount
(@AccountID uniqueIdentifier,@CustomerID uniqueIdentifier, @AccountNo char(10), @CurrentBalance money,
	@AccountType varchar(10),@Branch varchar(30),@Status char(10),@MinimumBalance money,@InterestRate decimal,@CreationDateTime datetime,@LastModifiedTime datetime)
as
begin

		---THROWING EXCEPTION IF ACCOUNT ID IS NULL OR INVALID
		if @AccountID is null OR @AccountID = ' '
			throw 50001,'Invalid Account ID',1

		---THROWING EXCEPTION IF CUSTOMER ID IS NULL OR INVALID
		if @CustomerID is null OR @CustomerID = ' '
			throw 50001,'Invalid Customer ID',2

		---THROWING EXCEPTION IF ACCOUNT NO IS NULL OR INVALID
		if @AccountNo is null OR @AccountNo = '' OR @AccountNo NOT like '1________'
			throw 50001,'Invalid Account No',4

		---THROWING EXCEPTION IF CURRENT BALANCE IS NULL OR LESS THAN 0
		if @CurrentBalance < 0 OR @CurrentBalance = '' OR @CurrentBalance = null
			throw 50001, 'Invalid Current Balance',5

		---THROWING EXCEPTION IF ACCOUNT TYPE IS NOT SAVINGS OR CURRENT
		if @AccountType = null OR @AccountType = ''OR @AccountType NOT IN('Fixed')
			throw 50001,'Invalid Account Type',6

		---THROWING EXCEPTION IF HOME BRANCH IS INVALID OR NULL
		if @Branch = null OR @Branch = ''OR @Branch NOT IN('Mumbai','Delhi','Chennai','Bengaluru')
			throw 50001,'Invalid Branch',7

			INSERT INTO CustomerService.RegularAccount(AccountID, CustomerID, AccountNo, CurrentBalance,
	AccountType ,Branch,Status,MinimumBalance,InterestRate,CreationDateTime,LastModifiedTime)VALUES(@AccountID, @CustomerID, @AccountNo, @CurrentBalance,
	@AccountType ,@Branch,@Status,@MinimumBalance,@InterestRate,@CreationDateTime,@LastModifiedTime)

end

GO



---CREATED PROCEDURE FOR ADDING ITEMS IN FIXED ACCOUNT TABLE

create procedure CreateFixedAccount
(@AccountID uniqueIdentifier,@CustomerID uniqueIdentifier, @AccountNo char(10), @CurrentBalance money,
	@AccountType varchar(10),@Branch varchar(30),@Tenure decimal,@FDDeposit money,@Status char(10),@MinimumBalance money,@InterestRate decimal,@CreationDateTime datetime,@LastModifiedTime datetime)
as
begin

		---THROWING EXCEPTION IF ACCOUNT ID IS NULL OR INVALID
		if @AccountID is null OR @AccountID = ' '
			throw 50001,'Invalid Account ID',1

		---THROWING EXCEPTION IF CUSTOMER ID IS NULL OR INVALID
		if @CustomerID is null OR @CustomerID = ' '
			throw 50001,'Invalid Customer ID',2

		---THROWING EXCEPTION IF ACCOUNT NO IS NULL OR INVALID
		if @AccountNo is null OR @AccountNo = '' OR @AccountNo NOT like '1________'
			throw 50001,'Invalid Account No',4

		---THROWING EXCEPTION IF CURRENT BALANCE IS NULL OR LESS THAN 0
		if @CurrentBalance < 0 OR @CurrentBalance = '' OR @CurrentBalance = null
			throw 50001, 'Invalid Current Balance',5

		---THROWING EXCEPTION IF ACCOUNT TYPE IS NOT SAVINGS OR CURRENT
		if @AccountType = null OR @AccountType = ''OR @AccountType NOT IN('Savings','Current')
			throw 50001,'Invalid Account Type',6

		---THROWING EXCEPTION IF HOME BRANCH IS INVALID OR NULL
		if @Branch = null OR @Branch = ''OR @Branch NOT IN('Mumbai','Delhi','Chennai','Bengaluru')
			throw 50001,'Invalid Branch',7

		---THROWING EXCEPTION IF TENURE IS INVALID 
		if @Tenure <= 0 OR @Tenure = '' OR @Tenure = null
			throw 50001, 'Invalid Tenure',5

		---THROWING EXCEPTION IF FDDEPOSIT AMOUNT IS INVALID 
		if @FDDeposit <= 0 OR @FDDeposit = '' OR @FDDeposit = null
			throw 50001, 'Invalid FDDeposit Amount',5

			INSERT INTO CustomerService.FixedAccount(AccountID, CustomerID, AccountNo, CurrentBalance,
	AccountType ,Branch,Tenure,FDDeposit,Status,MinimumBalance,InterestRate,CreationDateTime,LastModifiedTime)VALUES(@AccountID, @CustomerID, @AccountNo, @CurrentBalance,
	@AccountType ,@Branch,@Tenure,@FDDeposit,@Status,@MinimumBalance,@InterestRate,@CreationDateTime,@LastModifiedTime)


end


GO






------CREATED PROCEDURE FOR DELETING ITEMS FROM REGULAR ACCOUNT TABLE

create procedure DeleteRegularAccount(@AccountNo char(10))

as 
begin

		---THROWING EXCEPTION IF ACCOUNT No IS NULL OR INVALID
		if @AccountNo is null OR @AccountNo = ' '
			throw 50001,'Invalid Account No',1

		---THROWING EXCEPTION IF THE ACCOUNT DOESN'T EXISTS
		if NOT EXISTS(SELECT * from CustomerService.RegularAccount WHERE AccountNo = @AccountNo)
			throw 50001,'Account does not exists',1

		---SETTING THE VALUE OF STATUS FROM "ACTIVE" TO "CLOSED"
		update CustomerService.RegularAccount
		set Status = 'Closed' where AccountNo = @AccountNo;

end

GO





------CREATED PROCEDURE FOR DELETING ITEMS FROM FIXED ACCOUNT TABLE

create procedure DeleteFixedAccount(@AccountNo char(10))

as 
begin

		---THROWING EXCEPTION IF ACCOUNT No IS NULL OR INVALID
		if @AccountNo is null OR @AccountNo = ' '
			throw 50001,'Invalid Account No',1

		---THROWING EXCEPTION IF THE ACCOUNT DOESN'T EXISTS
		if NOT EXISTS(SELECT * from CustomerService.FixedAccount WHERE AccountNo = @AccountNo)
			throw 50001,'Account does not exists',1

		---SETTING THE VALUE OF STATUS FROM "ACTIVE" TO "CLOSED"
		update CustomerService.FixedAccount
		set Status = 'Closed' where AccountNo = @AccountNo;

end

GO



---CREATING A VIEW TO GET ACTIVE REGULAR ACCOUNTS BY ACCOUNT NO

create view [GetAccountByAccountNo]
as
SELECT * from CustomerService.RegularAccount WHERE Status = 'Active'

GO


---CREATED PROCEDURE FOR CHANGING HOME BRANCH OF REGULAR ACCOUNT

create procedure ChangeRegularAccountBranch(@AccountNo char(10),@Branch varchar(30))

as 
begin

		---THROWING EXCEPTION IF ACCOUNT No IS NULL OR INVALID
		if @AccountNo is null OR @AccountNo = ' '
			throw 50001,'Invalid Account No',1
					
		---THROWING EXCEPTION IF THE ACCOUNT DOESN'T EXISTS
		if NOT EXISTS(SELECT * from CustomerService.RegularAccount WHERE AccountNo = @AccountNo)
			throw 50001,'Account does not exists',1

		---THROWING EXCEPTION IF THE HOME BRANCH ENTERED IS NOT VALID
		if @Branch NOT IN ('Mumbai','Delhi','Chennai','Bengaluru')
			throw 50001,'Home branch entered is invalid',1

		---CHANGING THE HOME BRANCH IF ACCOUNT NO MATCHES
		update CustomerService.RegularAccount
		set Branch = @Branch where ((AccountNo = @AccountNo)AND(Branch IN ('Mumbai','Delhi','Chennai','Bengaluru')))

end

GO





---CREATED PROCEDURE FOR CHANGING HOME BRANCH OF FIXED ACCOUNT

create procedure ChangeFixedAccountBranch(@AccountNo char(10),@Branch varchar(30))

as 
begin

		---THROWING EXCEPTION IF ACCOUNT No IS NULL OR INVALID
		if @AccountNo is null OR @AccountNo = ' '
			throw 50001,'Invalid Account No',1

		---THROWING EXCEPTION IF THE ACCOUNT DOESN'T EXISTS
		if NOT EXISTS(SELECT * from CustomerService.FixedAccount WHERE AccountNo = @AccountNo)
			throw 50001,'Account does not exists',1

		---THROWING EXCEPTION IF THE HOME BRANCH ENTERED IS NOT VALID
		if @Branch NOT IN ('Mumbai','Delhi','Chennai','Bengaluru')
			throw 50001,'Home branch entered is invalid',1

		---CHANGING THE HOME BRANCH IF ACCOUNT NO MATCHES
		update CustomerService.FixedAccount
		set Branch = @Branch where ((AccountNo = @AccountNo)AND(Branch IN ('Mumbai','Delhi','Chennai','Bengaluru')))



end

GO



---CREATED PROCEDURE FOR CHANGING THE ACCOUNT TYPE OF REGULAR ACCOUNTS

create procedure ChangeRegularAccountType(@AccountNo char(10),@AccountType varchar(10))

as 
begin

		---THROWING EXCEPTION IF ACCOUNT No IS NULL OR INVALID
		if @AccountNo is null OR @AccountNo = ' '
			throw 50001,'Invalid Account No',1

		---THROWING EXCEPTION IF THE ACCOUNT DOESN'T EXISTS
		if NOT EXISTS(SELECT * from CustomerService.RegularAccount WHERE AccountNo = @AccountNo)
			throw 50001,'Regular Account does not exists',1
		
		---THROWING EXCEPTION IF THE ACCOUNT NO ENTERED BELONGS TO FIXED ACCOUNT TABLE
		if EXISTS(SELECT * from CustomerService.FixedAccount WHERE AccountNo = @AccountNo) 
			throw 50001,'Fixed accounts cannot be modified into other account types',1

		---THROWING EXCEPTION IF THE ACCOUNT TYPE ENTERED IS NOT VALID
		if @AccountType NOT IN ('SAVINGS','CURRENT')
			throw 50001,'Account Type entered is invalid',1

		---CHANGING THE ACCOUNT TYPE IF ACCOUNT NO MATCHES
		update CustomerService.RegularAccount
		set AccountType = @AccountType where ((AccountNo = @AccountNo)AND(AccountType IN ('Savings','Current')))


end

GO



---CREATED PROCEDURE FOR LISTING REGULAR ACCOUNT BY ACCOUNT NO

Create procedure GetRegularAccountByAccountNo(@AccountNo char(10))
as
begin

		
		SELECT c.CustomerName,c.CustomerNumber,a.* from CustomerService.RegularAccount a, CustomerService.Customer c WHERE (AccountNo = @AccountNo) 
		AND (c.CustomerID = a.CustomerID )

end


GO

---CREATED PROCEDURE FOR LISTING FIXED ACCOUNT BY ACCOUNT NO

Create procedure GetFixedAccountByAccountNo(@AccountNo char(10)) 
as
begin

		SELECT c.CustomerName,c.CustomerNumber,a.* from CustomerService.FixedAccount a, CustomerService.Customer c WHERE (AccountNo = @AccountNo) 
		AND (c.CustomerID = a.CustomerID )

end


GO

---CREATED PROCEDURE FOR LISTING REGULAR ACCOUNTS BY CUSTOMER NO

Create procedure GetRegularAccountByCustomerNo(@CustomerID uniqueIdentifier)
as
begin

		SELECT c.CustomerName,c.CustomerNumber,a.* from CustomerService.RegularAccount a, CustomerService.Customer c WHERE (@CustomerID IN(SELECT CustomerID from CustomerService.RegularAccount))AND(c.CustomerID = a.CustomerID )

end


GO


---CREATED PROCEDURE FOR LISTING FIXED ACCOUNTS BY CUSTOMER NO

Create procedure GetFixedAccountByCustomerNo(@CustomerID uniqueIdentifier)
as
begin

		SELECT c.CustomerName,c.CustomerNumber,a.* from CustomerService.FixedAccount a, CustomerService.Customer c WHERE (@CustomerID IN(SELECT CustomerID from CustomerService.FixedAccount))AND(c.CustomerID = a.CustomerID )

end

GO

---CREATED PROCEDURE FOR LISTING REGULAR ACCOUNTS BY ACCOUNT TYPE

Create procedure GetRegularAccountsByAccountType(@AccountType varchar(10))
as
begin

		SELECT c.CustomerName,c.CustomerNumber,a.* from CustomerService.RegularAccount a, CustomerService.Customer c WHERE (AccountType = @AccountType) 
		AND (c.CustomerID = a.CustomerID )

end

GO


---CREATED PROCEDURE FOR LISTING REGULAR ACCOUNTS BY ACCOUNT OPENING DATE

Create procedure GetRegularAccountsByAccountOpeningDate(@StartDate datetime,@EndDate datetime)
as
begin
		
		---THROWING EXCEPTION IF END DATE IS LATER THAN TODAY
		if (@EndDate > = GETDATE())
			throw 50001,'End date cannot be later than today',1

		SELECT c.CustomerName,c.CustomerNumber,a.* from CustomerService.RegularAccount a, CustomerService.Customer c WHERE ((CreationDateTime >= @StartDate) 
		AND (CreationDateTime <= @EndDate))

end

GO


---CREATED PROCEDURE FOR LISTING FIXED ACCOUNTS BY ACCOUNT OPENING DATE

Create procedure GetFixedAccountsByAccountOpeningDate(@StartDate datetime,@EndDate datetime)
as
begin
		
		---THROWING EXCEPTION IF END DATE IS LATER THAN TODAY
		if (@EndDate > = GETDATE())
			throw 50001,'End date cannot be later than today',1

		SELECT c.CustomerName,c.CustomerNumber,a.* from CustomerService.FixedAccount a, CustomerService.Customer c WHERE ((CreationDateTime >= @StartDate) 
		AND (CreationDateTime <= @EndDate))

end

GO

---To Add New CarLoan----
create procedure Loans.CreateCarLoan
( @CustomerID varchar(36),  @LoanAmount money,
	@LoanDuration decimal,@License char(15))
as
begin
	---THROWING EXCEPTION IF  Customer Number IS NULL OR INVALID
	if @CustomerID is null or @CustomerID = ' ' 
		throw 50001, 'Invalid Customer No',3

	---THROWING EXCEPTION IF Amount of Loan IS NULL OR LESS THAN 0
	if @LoanAmount < 0 
	throw 50002, 'Invalid Amount of Loan',5
		
   ---THROWING EXCEPTION IF LoanDuration IS INVALID 
	if @LoanDuration < 0 
	throw 50003, 'Invalid Tenure',5

   ---THROWING EXCEPTION IF License IS NULL OR INVALID---
	if @License = null OR @License = ' ' OR @License LIKE '[a-zA-Z][a-zA-Z]%'
	throw 50004, 'Invalid License',5

	---Declaring Auto Genrated Values like ID Date Time---
declare @LoanId uniqueidentifier ,@Creationdate date,@Modificationdate date , @LoanStatus varchar(10) , @LoanType varchar(20 )
set @LoanId = Cast(NEWID() as varchar(36))
 
set @Creationdate = SysDateTime()
set @Modificationdate = SysDateTime()
set @LoanStatus = 'Pending'   
set @LoanType = 'Car'
 ---Inserting Into Values---
Insert Into CarLoan(LoanID , CustomerID  , LoanAmount , LoanStatus , LoanDuration , License , CreationDateTime, LastModifiedTime, LoanType) Values (@LoanId , @CustomerID  , @LoanAmount , @LoanStatus , @LoanDuration , @License , @Creationdate, @Modificationdate , @LoanType)
end

go
---To Show Loan By Loan Status---
Create Procedure Loans.ShowLoanByLoanStatus(@LoanStatus varchar(10))
as begin 

		---THROWING EXCEPTION IF Loan Status IS INVALID OR NULL
		if @LoanStatus = null OR @LoanStatus = ''OR @LoanStatus NOT IN('Pending','Approved','Rejected')
			throw 500005,'Invalid Status',7

Select * from Loans.CarLoan
Where LoanStatus = @LoanStatus
end

go

---To Show Loan By Car Loan ID---
Create Procedure Loans.ShowLoanByLoanID(@LoanID varchar(36))
as begin
   ---THROWING EXCEPTION IF Loan ID IS INVALID OR NULL
	if @LoanID = null OR @LoanID = ''OR @LoanID NOT IN(Select LoanID from Loans.CarLoan)
		throw 500006,'Invalid Status',8
 
--- Selecting Value Based on Loan ID---
Select * from Loans.CarLoan
Where LoanID = @LoanID
end

go
---To Show All Car Loan data
Create Procedure Loans.ShowAllLoan
as begin 
Select * from Loans.CarLoan
end

go

---To Delete Car Loan By Loan ID 
Create Procedure Loans.DeleteLoanByLoanID(@LoanID1 varchar(36))
as begin 

   ---THROWING EXCEPTION IF Loan ID IS INVALID OR NULL
	if @LoanID1 = null OR @LoanID1 = ''OR @LoanID1 NOT IN(Select LoanID from Loans.CarLoan)
		throw 500006,'Invalid Status',8

Delete from Loans.CarLoan
Where LoanID = @LoanID1
end

go


---To Update Car Loan By using Loan ID
Create Procedure Loans.UpdateLoanByLoanID (@LoanID1 varchar(36),  @LoanAmount money,
	@LoanDuration decimal,@License char(15))
	as begin
	

	---THROWING EXCEPTION IF Amount of Loan IS NULL OR LESS THAN 0
	 if @LoanAmount < 0 
		throw 50002, 'Invalid Amount of Loan',5

	---THROWING EXCEPTION IF LoanDuration IS INVALID 
	 if @LoanDuration < 0 
		throw 50003, 'Invalid Tenure',5

	---THROWING EXCEPTION IF License IS NULL OR INVALID---
	 if @License = null OR @License = ' ' OR @License LIKE '[a-zA-Z][a-zA-Z]%'
		throw 50004, 'Invalid License',5

	---THROWING EXCEPTION IF Loan ID IS INVALID OR NULL
	if @LoanID1 = null OR @LoanID1 = ''OR @LoanID1 NOT IN(Select LoanID from Loans.CarLoan)
		throw 500006,'Invalid Status',8

	---Updating Values---
Update Loans.CarLoan
Set LoanAmount = @LoanAmount,
    LoanDuration = @LoanDuration,
	License = @License
Where LoanID = @LoanID1
end

go

	---To Add New HomeLoan----
create procedure Loans.CreateEducationLoan
( @CustomerID varchar(36),  @LoanAmount money,
	@LoanDuration decimal,@Collateral money , @CollegeName varchar(36),@AdmissionID varchar(36), @Sponseror varchar(36))
as
begin
	---THROWING EXCEPTION IF  Customer Number IS NULL OR INVALID
	if @CustomerID is null or @CustomerID = ' ' 
		throw 50001, 'Invalid Customer No',3

	---THROWING EXCEPTION IF Amount of Loan IS NULL OR LESS THAN 0
	if @LoanAmount < 0 
	throw 50002, 'Invalid Amount of Loan',5
		
   ---THROWING EXCEPTION IF LoanDuration IS INVALID 
	if @LoanDuration < 0 
	throw 50003, 'Invalid Tenure',5

	
	---THROWING EXCEPTION IF Amount of Collateral IS NULL OR LESS THAN 0
	if @Collateral < 0 
	throw 50004, 'Invalid Amount of Collateral',5

	---THROWING EXCEPTION IF  College Name IS NULL OR INVALID
	if @CollegeName is null or @CollegeName = ' ' 
		throw 50005, 'Invalid Customer No',3

	---THROWING EXCEPTION IF Admission ID IS NULL OR INVALID
	if @AdmissionID is null or @AdmissionID = ' ' 
		throw 50006, 'Invalid Customer No',3

	---THROWING EXCEPTION IF  Sponseror IS NULL OR INVALID
	if @Sponseror is null or @Sponseror = ' ' 
		throw 50007, 'Invalid Customer No',3
	
	---Declaring Auto Genrated Values like ID Date Time---
declare @LoanId uniqueidentifier ,@Creationdate date,@Modificationdate date , @LoanStatus varchar(10)
set @LoanId = Cast(NEWID() as varchar(36))
 
set @Creationdate = SysDateTime()
set @Modificationdate = SysDateTime()
set @LoanStatus = 'Pending'   

 ---Inserting Into Values---
Insert Into EducationLoan(LoanID , CustomerID  , LoanAmount , LoanStatus , LoanDuration ,Collateral , CreationDateTime, LastModifiedTime , CollegeName , AdmissionID , Sponseror) Values (@LoanId , @CustomerID  , @LoanAmount , @LoanStatus , @LoanDuration , @Collateral , @Creationdate, @Modificationdate , @CollegeName , @AdmissionID, @Sponseror)
end

go

---To Show Loan By Loan Status---
Create Procedure Loans.ShowEducationLoanByLoanStatus(@LoanStatus varchar(10))
as begin 

		---THROWING EXCEPTION IF Loan Status IS INVALID OR NULL
		if @LoanStatus = null OR @LoanStatus = ''OR @LoanStatus NOT IN('Pending','Approved','Rejected')
			throw 500005,'Invalid Status',7

Select * from Loans.EducationLoan
Where LoanStatus = @LoanStatus
end

go

---To Show All Home Loan data
Create Procedure Loans.ShowAllEducationLoan
as begin 
Select * from Loans.EducationLoan
end

go

---To Add Personal HomeLoan----
create procedure Loans.CreatePersonalLoan
( @CustomerID varchar(36),  @LoanAmount money,
	@LoanDuration decimal,@Collateral money )
as
begin
	---THROWING EXCEPTION IF  Customer Number IS NULL OR INVALID
	if @CustomerID is null or @CustomerID = ' ' 
		throw 50001, 'Invalid Customer No',3

	---THROWING EXCEPTION IF Amount of Loan IS NULL OR LESS THAN 0
	if @LoanAmount < 0 
	throw 50002, 'Invalid Amount of Loan',5
		
   ---THROWING EXCEPTION IF LoanDuration IS INVALID 
	if @LoanDuration < 0 
	throw 50003, 'Invalid Tenure',5

	
	---THROWING EXCEPTION IF Amount of Collateral IS NULL OR LESS THAN 0
	if @Collateral < 0 
	throw 50004, 'Invalid Amount of Collateral',5

	---Declaring Auto Genrated Values like ID Date Time---
declare @LoanId uniqueidentifier ,@Creationdate date,@Modificationdate date , @LoanStatus varchar(10)
set @LoanId = Cast(NEWID() as varchar(36))
 
set @Creationdate = SysDateTime()
set @Modificationdate = SysDateTime()
set @LoanStatus = 'Pending'   

 ---Inserting Into Values---
Insert Into PersonalLoan(LoanID , CustomerID  , LoanAmount , LoanStatus , LoanDuration ,Collateral , CreationDateTime, LastModifiedTime) Values (@LoanId , @CustomerID  , @LoanAmount , @LoanStatus , @LoanDuration , @Collateral , @Creationdate, @Modificationdate)
end

go

---To Show Loan By Loan Status---
Create Procedure Loans.ShowPersonalLoanByLoanStatus(@LoanStatus varchar(10))
as begin 

		---THROWING EXCEPTION IF Loan Status IS INVALID OR NULL
		if @LoanStatus = null OR @LoanStatus = ''OR @LoanStatus NOT IN('Pending','Approved','Rejected')
			throw 500005,'Invalid Status',7

Select * from Loans.PersonalLoan
Where LoanStatus = @LoanStatus
end

go

---To Show All Home Loan data
Create Procedure Loans.ShowAllHomeLoan
as begin 
Select * from Loans.PersonalLoan
end



go
---To Delete Car Loan By Loan ID 
Create Procedure Loans.DeletePersonalLoanByLoanID(@LoanID1 varchar(36))
as begin 

   ---THROWING EXCEPTION IF Loan ID IS INVALID OR NULL
	if @LoanID1 = null OR @LoanID1 = ''OR @LoanID1 NOT IN(Select LoanID from Loans.CarLoan)
		throw 500006,'Invalid Status',8

Delete from Loans.PersonalLoan
Where LoanID = @LoanID1
end


go

---To Update Personal Loan By using Loan ID
Create Procedure Loans.UpdatePersonalLoanByLoanID (@LoanID1 varchar(36),  @LoanAmount money,
	@LoanDuration decimal,@Collateral money)
	as begin
	

	---THROWING EXCEPTION IF Amount of Loan IS NULL OR LESS THAN 0
	 if @LoanAmount < 0 
		throw 50002, 'Invalid Amount of Loan',5

	---THROWING EXCEPTION IF LoanDuration IS INVALID 
	 if @LoanDuration < 0 
		throw 50003, 'Invalid Tenure',5

	---THROWING EXCEPTION IF Amount of Collateral IS NULL OR LESS THAN 0
	if @Collateral < 0 
	throw 50004, 'Invalid Amount of Collateral',5

	---THROWING EXCEPTION IF Loan ID IS INVALID OR NULL
	if @LoanID1 = null OR @LoanID1 = ''OR @LoanID1 NOT IN(Select LoanID from Loans.CarLoan)
		throw 500006,'Invalid Status',8

	---Updating Values---
Update Loans.PersonalLoan
Set LoanAmount = @LoanAmount,
    LoanDuration = @LoanDuration,
	Collateral = @Collateral
Where LoanID = @LoanID1
end

go

/*Procedure for adding Credit card details into the CreditCards table

Project name    : Pecunia
Module name     : Utilites-CreditCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

create procedure AddCreditCard
(@creditCardID uniqueidentifier, @custID uniqueidentifier, @custName varchar(50),@cardNumber char(12),@creditLimit decimal,@expiry varchar(7),@cardType varchar(20),@cardStatus varchar(12),@cardIssueDate DateTime,
        @lastModifiedDate Datetime)
as
begin
begin try

--throws error if customer does not exist
if (not exists(select *from Customer where CustomerID=@custID))
	throw 50000,'Customer not found',1;

--throws error if length of customer name is less than 2 or greater than 40
if ((len(@custName)<=2) or (len(@custName)>=40))
    throw 100,'Customer name should be beween 2 and 40 characters',1;

--throws error if length of card number is not equal to 12
if(len(@cardNumber)!=12)
     throw 3000,'InvalID card number',1;

--throws error if credit limit is negative
if(@creditLimit<=0)
     throw 3000,'Credit Limit should not be negative',1;

--throws error if card type is not one among Platinum plus or Visa signature or Infinia
if(@cardType!='Platinum Plus' and @cardType!='Visa Signature' and @cardType!='Infinia')
     throw 3000,'Card Type should be Platinum Plus  or Visa Signature or Infinia',1;

--throws error if card type is not either active or blokced
if(@cardStatus!='Active' and @cardStatus!='Blocked')
throw 3000,'Card status should be aactive or blocked',1;


insert into CustomerService.CreditCard
(CreditCardID,CustomerID,CustomerNameAsPerCard,CardNumber,CreditLimit,ExpiryMMYYYY,CardType,CardStatus,CardIssueDatE,
 LastModifiedDate) 
	values(@creditCardID,@custID,@custName,@cardNumber,@creditLimit,@expiry,@cardType,@cardStatus,@cardIssueDate,
        @lastModifiedDate)
end try
begin catch
throw;
end catch
end
go

/*

Procedure to view details of all the credit cards

Project name    : Pecunia
Module name     : Utilites-CreditCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

create procedure GetAllCreditCards
as
begin
	select credit.*,cust.* from CustomerService.CreditCard as credit join CustomerService.Customer as cust on credit.CustomerID=cust.CustomerID
end
go

/*

Procedure to update the status of credit card as per the request of user

Project name    : Pecunia
Module name     : Utilites-CreditCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

create procedure UpdateCreditCardStatus(@cardNumber char(12) ,@cardStatus varchar(12))
as
begin
if (not exists(select *from CustomerService.CreditCard where CardNumber=@cardNumber))
	throw 50000,'Customer not found',1;
update CustomerService.CreditCard
set
CardStatus=@cardStatus,
LastModifiedDate=GetDate()
where CardNumber=@cardNumber
end
go
 







 /*

Procedure to view the credit cards details of a respective customer

Project name    : Pecunia
Module name     : Utilites-CreditCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

create procedure GetCreditCardsByCustomerID(@custID uniqueIdentifier)
as
begin
	select credit.*,cust.* from CustomerService.CreditCard as credit join CustomerService.Customer as cust on credit.CustomerID=cust.CustomerID
 where CustomerID=@custID
 end
 go


 /*

Procedure to view the credit card details based on the card number

Project name    : Pecunia
Module name     : Utilites-CreditCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

 create procedure GetCreditCardByCreditCardNumber(@cardNumber char(12))
 as
 begin
	 select credit.*,cust.* from CustomerService.CreditCard as credit join CustomerService.Customer as cust on credit.CustomerID=cust.CustomerID
 where CardNumber=@cardNumber
 end
 go


 /*

Procedure for adding debit card details into Debitcards table

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

create procedure AddDebitCard
(@debitCardID uniqueidentifier, @accountID uniqueidentifier, @custName varchar(50),@cardNumber char(12),@expiry varchar(7),@cardType varchar(20),@cardStatus varchar(12),@cardIssueDate DateTime,
        @lastModifiedDate Datetime)
as
begin
begin try
--throws error if account does not exist
if (not exists(select *from Account where AccountID=@accountID))
	throw 50000,'Account not found',1;

--throws error if length of customer name is less than 12 or greater than 40
if (2>=len(@custName) or len(@custName)>=40)
	throw 100,'Customer name should be beween 2 and 40 characters',1;

--throws error if length of card number is not equal to 12
if(len(@cardNumber)!=12)
     throw 3000,'Invalid card number',1;

--throws error if card type is not one among below mentioned card types
if(@cardType!='Rupay' and @cardType!='VISA' and @cardType!='Maestro' and @cardType!='MasterCard')
throw 3000,'Card Type should be Rupay or VISA or maestro or mastercard ',1;

--throws error if card type is not either active or blokced
if(@cardStatus!='Active' and @cardStatus!='Blocked')
throw 3000,'Card status should be aactive or blocked',1;

insert into CustomerService.DebitCard(DebitCardID,AccountID,CustomerNameAsPerCard,CardNumber,ExpiryMMYYYY,CardType,CardStatus,CardIssueDate,
        LastModifiedDate) values(@debitCardID,@accountID,@custName,@cardNumber,@expiry,@cardType,@cardStatus,@cardIssueDate,
        @lastModifiedDate)
end try
begin catch
	throw;
end catch
end 
go





/*

Procedure to view details of all the debit cards

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/


create procedure GetAllDebitCards
as
begin
select debit.*,account.* from CustomerService.DebitCard as debit join CustomerService.RegularAccount as  account on debit.AccountID=account.AccountID
end
go


/*

Procedure to update the status of credit card as per the request of user

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

create procedure UpdateDebitCardStatus(@cardNumber char(12),@cardStatus varchar(12))
as
begin
if (not exists(select *from CustomerService.DebitCard where CardNumber=@cardNumber))
	throw 50000,'Customer not found',1;
update CustomerService.DebitCard
set
CardStatus=@cardStatus,
LastModifiedDate=GetDate()
where CardNumber=@cardNumber
end
go

/*

Procedure to view the debit cards details for a respective account

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

create procedure GetDebitCardsByAccountID(@accountID uniqueidentifier)
as
begin
select debit.*,account.* from CustomerService.DebitCard as debit join CustomerService.RegularAccount as account on debit.AccountID=account.AccountID
 where AccountID=@accountID
 end
 go

/*

Procedure to view the debit card details based on the card number

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

 create procedure GetDebitCardByDebitCardNumber(@cardNumber char(12))
 as
 begin
 select debit.*,account.* from CustomerService.DebitCard as debit join CustomerService.RegularAccount as account on debit.AccountID=account.AccountID
 where CardNumber=@cardNumber
 end
 go

 /*

Procedure for adding cheque book details into ChequeBooks table

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

 create procedure AddChequeBook1
 (@chequeBookID uniqueidentifier,@accountID uniqueidentifier,@accountNo char(10),@seriesStart decimal,@numberOfLeaves int,@chequeBookStatus varchar(12),@chequeBookRequestDate  DateTime,
		@lastModifiedDate Datetime)
 as
 begin
 begin try
 --throws error if account not found
 if (not exists(select *from Account where AccountID=@accountID))
	throw 50000,'Account not found',1;
--throws error if number of leaves is not multiple of five
if(@numberOfLeaves%5!=0)
	throw 3000,'Number of leaves should me multiple of 5',1;
--throws error if cheque book sttaus is not one among requested or approved
if(@chequeBookStatus!='Requested' and @chequeBookStatus!='Approved')
	throw 3000,'Status of cheque book should be either requested or approved',2;
insert into CustomerService.ChequeBook(ChequeBookID ,AccountID,AccountNo,SeriesStart,NumberOfLeaves,ChequeBookStatus,ChequeBookRequestDate,
		LastModifiedDate ) values (@chequeBookID ,@accountID,@accountNo,@seriesStart,@numberOfLeaves,@chequeBookStatus,@chequeBookRequestDate,
		@lastModifiedDate )
	end try
begin catch
	throw;
end catch
end 
go

/*

Procedure to view details of all the cheque books

Project name    : Pecunia
Module name     : Utilites-DebitCard
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

 
create procedure GetAllChequeBooks
as
begin
select cheque.*,account.* from CustomerService.ChequeBook as cheque join CustomerService.RegularAccount as account on cheque.AccountID=account.AccountID
end
go

/*

Procedure to view details of the cheque book based on its ID

Project name    : Pecunia
Module name     : Utilites-ChequeBooks
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

create procedure GetChequeBookByChequeBookID(@chequeBookID uniqueIDentifier)
 as
 begin
 select cheque.*,account.* from CustomerService.ChequeBook as cheque join CustomerService.RegularAccount as account on cheque.AccountID=account.AccountID
 where ChequeBookID=@chequeBookID
 end
 go

/*

Procedure to view details of the cheque book based on its series starting number

Project name    : Pecunia
Module name     : Utilites-ChequeBooks
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

 create procedure GetChequeBookBySeriesStart(@seriesStart decimal)
 as
 begin
 select cheque.*,account.* from CustomerService.ChequeBook as cheque join CustomerService.RegularAccount as account on cheque.AccountID=account.AccountID
 where SeriesStart=@seriesStart
 end
 go

/*

Procedure to view details of the cheque books for respective account and status of cheque book

Project name    : Pecunia
Module name     : Utilites-ChequeBooks
Created by      : Tarunsree
Date of creation: 01-10-2019

*/

 create procedure GetChequeBooksByAccountIDAndStatus(@accountID uniqueidentifier,@chequeBookStatus varchar(12))
 as
 begin
select cheque.*,account.* from CustomerService.ChequeBook as cheque join CustomerService.RegularAccount as account on cheque.AccountID=account.AccountID
 where AccountID=@accountID and ChequeBookStatus=@chequeBookStatus
 end
 go

/*

Procedure to view details of the cheque books for respective account

Project name    : Pecunia
Module name     : Utilites-ChequeBooks
Created by      : Tarunsree
Date of creation: 01-10-2019

*/


create procedure GetChequeBooksByAccountID(@accountID uniqueidentifier)
 as
 begin
select cheque.*,account.* from CustomerService.ChequeBook as cheque join CustomerService.RegularAccount as  account on cheque.AccountID=account.AccountID
 where AccountID=@accountID
 end
 go