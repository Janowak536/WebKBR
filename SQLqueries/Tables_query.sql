create table Clients (
	clientID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name varchar(50),
	NIP char(10) ,
	Phone char(11) ,
	Email varchar(100),
	Address varchar(100),
	City varchar(20),
	postalCode char(6),
	clientType varchar(20),
	discountCode varchar(20),
)

CREATE table Models (
	modelID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	modelName char(20),
	Type char (20),
	worthValue decimal(15, 2)
)

CREATE table Colors (
	colorID int NOT NULL PRIMARY KEY,
	colorName char(20),
	Type char(20),
	worthValue decimal(15,2)
)

CREATE table MDF (
	mdfID int NOT NULL PRIMARY KEY,
	mdfName char(20),
	Type char(20),
	worthValue decimal(15,2)
)
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(256) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    ClientID INT NULL,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
	Role NVARCHAR(20),
);


CREATE table Orders (
	orderID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	modelID int NOT NULL FOREIGN KEY REFERENCES Models(modelID),
	colorID int NOT NULL FOREIGN KEY REFERENCES Colors(colorID),
	mdfID int NOT NULL FOREIGN KEY REFERENCES MDF(mdfID),
	totalValue decimal(20,2) NOT NULL
)

CREATE table clientsOrders (
	clientID int NOT NULL FOREIGN KEY REFERENCES Clients(clientID),
	orderID int NOT NULL FOREIGN KEY REFERENCES Orders(orderID) UNIQUE,
	orderDate date NOT NULL,
	orderValue decimal(15,2) NOT NULL
)



--Scaffold-DbContext -Connection 'Server=DESKTOP-0URS1MD;Database=db_2kbr;Trusted_Connection=True;TrustServerCertificate=True' -Provider Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -Context Db2KbrContext


