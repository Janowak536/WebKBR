create table Clients (
	ClientID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name varchar(50),
	NIP char(10) ,
	Phone char(11) ,
	Email varchar(100),
	Address varchar(100),
	City varchar(20),
	PostalCode char(6),
	ClientType varchar(20),
	DiscountCode varchar(20),
	Username NVARCHAR(256) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(MAX) NOT NULL,
	UserRole NVARCHAR(20),
)

CREATE table Models (
	ModelID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ModelName char(50),
	Type char (20),
	Value decimal(15, 2)
)

CREATE table Colors (
	ColorID int NOT NULL PRIMARY KEY,
	ColorName char(50),
	Type char(20),
	Value decimal(15,2)
)

CREATE table MDF (
	MdfID int NOT NULL PRIMARY KEY,
	MdfName char(50),
	Type char(20),
	Value decimal(15,2)
)

CREATE table Orders (
	ProductID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ClientID int NOT NULL FOREIGN KEY REFERENCES Clients(clientID),
	OrderID int NOT NULL,
	ModelID int NOT NULL FOREIGN KEY REFERENCES Models(modelID),
	ColorID int NOT NULL FOREIGN KEY REFERENCES Colors(colorID),
	MdfID int NOT NULL FOREIGN KEY REFERENCES MDF(mdfID),
	Width smallint NOT NULL,
	Height smallint NOT NULL,
	OrderValue decimal(20,2) NOT NULL
	--constraint widht_check
		--check(width > 0 and width < 1250)
	--constraint height_check
		--check(height > 0 and height < 2750)
)
CREATE TABLE OrderStatus (
    OrderStatusID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    OrderID int NOT NULL,
    Status varchar(50)
);
