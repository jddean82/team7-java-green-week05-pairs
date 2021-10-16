DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Pet;
DROP TABLE IF EXISTS Owner ;
DROP TABLE IF EXISTS Procedure ;

CREATE TABLE Owner
(

OwnerId serial, 
OwnerFirstName varchar(64) NOT NULL,
OwnerLastName varchar(64) NOT NULL,
OwnerAddress varchar(128) NOT NULL, 
OwnerCity varchar(128) NOT NULL, 
OwnerZip varchar(10) NOT NULL, 
OwnerState varchar(15),

CONSTRAINT pk_Owner PRIMARY KEY(OwnerID)


);


CREATE TABLE Procedure
(

ProcedureID serial,
ProcedureName varchar(128) NOT NULL,
ProcedureCost money NOT NULL,

CONSTRAINT pk_Procedure PRIMARY KEY(ProcedureID)

);

CREATE TABLE Pet 
(

PetID serial, 
OwnerID int NOT NULL,
PetName varchar(128) NOT NULL,
PetType varchar(128) NOT NULL, 
PetAge int NOT NULL,

CONSTRAINT pk_PetId PRIMARY KEY (PetID),
CONSTRAINT fk_OwnerId FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)


);

CREATE TABLE Visit
(

VisitID serial,
ProcedureID int NOT NULL,
PetID int NOT NULL,
VisitDate date NOT NULL,

CONSTRAINT pk_VisitID PRIMARY KEY(VisitID),
CONSTRAINT fk_Visit_ProcedureID FOREIGN KEY(ProcedureID) REFERENCES Procedure(ProcedureID) ,
CONSTRAINT fk_PetID FOREIGN KEY(PetID) REFERENCES Pet(PetID)

);
--------------------------------------------------------------------------------------------------DATA LOAD------------------------------------------
INSERT INTO Owner(OwnerFirstName, OwnerLastName, OwnerAddress, OwnerCity, OwnerState, OwnerZip) Values('Jeff','Dean','1251 Joyce Lane','Ann Arbor','MI','44444');
INSERT INTO Owner(OwnerFirstName, OwnerLastName, OwnerAddress, OwnerCity, OwnerState, OwnerZip) Values('Mary','Colapietro','1555 Big Street','Columbus','OH','49044-8979');
INSERT INTO Owner(OwnerFirstName, OwnerLastName, OwnerAddress, OwnerCity, OwnerState, OwnerZip) Values('Slim','Jim','3 Grand Dr.','Fredrick','TX','22444');

INSERT INTO Pet(OwnerID,PetName, PetType,PetAge) Values(1,'Scratch','Cat',12);
INSERT INTO Pet(OwnerID,PetName, PetType,PetAge) Values(1,'Henry','Dog',1);
INSERT INTO Pet(OwnerID,PetName, PetType,PetAge) Values(2,'MrBill','Donkey',12);
INSERT INTO Pet(OwnerID,PetName, PetType,PetAge) Values(3,'Whiskery','Bird',10);

