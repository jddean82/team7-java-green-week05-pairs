--We designed the database with the following assumptions: 
--(1) There is only one hospital location and address
--(2) There is one invoice generated per visit
--(3) Owners with multiple pets will book separate visits for each pet
--(4) Each pet has one owner
--(5) The same procedure will not be carried out multiple times on a pet on the same day.


DROP TABLE IF EXISTS VisitPetProcedure;
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
VisitDate date NOT NULL,
VisitDescription varchar(128),

CONSTRAINT pk_Visit PRIMARY KEY (VisitID)

);


CREATE TABLE VisitPetProcedure 
(

VisitID int NOT NULL,
ProcedureID int NOT NULL,
PetID int NOT NULL,

CONSTRAINT pk_VisitID PRIMARY KEY(VisitID, PetID, ProcedureID),
CONSTRAINT fk_Visit_ProcedureID FOREIGN KEY(ProcedureID) REFERENCES Procedure(ProcedureID),
CONSTRAINT fk_PetID FOREIGN KEY(PetID) REFERENCES Pet(PetID),
CONSTRAINT fk_VisitID FOREIGN KEY (VisitID) REFERENCES Visit(VisitID)

);
--------------------------------------------------------------------------------------------------DATA LOAD------------------------------------------
INSERT INTO Owner(OwnerFirstName, OwnerLastName, OwnerAddress, OwnerCity, OwnerState, OwnerZip) Values('Jeff','Dean','1251 Joyce Lane','Ann Arbor','MI','44444');
INSERT INTO Owner(OwnerFirstName, OwnerLastName, OwnerAddress, OwnerCity, OwnerState, OwnerZip) Values('Mary','Colapietro','1555 Big Street','Columbus','OH','49044-8979');
INSERT INTO Owner(OwnerFirstName, OwnerLastName, OwnerAddress, OwnerCity, OwnerState, OwnerZip) Values('Slim','Jim','3 Grand Dr.','Fredrick','TX','22444');

INSERT INTO Pet(OwnerID,PetName, PetType,PetAge) Values(1,'Scratch','Cat',12);
INSERT INTO Pet(OwnerID,PetName, PetType,PetAge) Values(1,'Henry','Dog',1);
INSERT INTO Pet(OwnerID,PetName, PetType,PetAge) Values(2,'MrBill','Donkey',12);
INSERT INTO Pet(OwnerID,PetName, PetType,PetAge) Values(3,'Whiskery','Bird',10);

INSERT INTO Procedure(ProcedureName, ProcedureCost) VALUES('Whisker check', 900);
INSERT INTO Procedure(ProcedureName, ProcedureCost) VALUES('Flea treatment', 100);
INSERT INTO Procedure(ProcedureName, ProcedureCost) VALUES('Deworming', 300);

INSERT INTO Visit(VisitDate, VisitDescription) VALUES ('2021-10-16', 'Standard kitty checkup');
INSERT INTO Visit(VisitDate, VisitDescription) VALUES ('2021-4-12', 'Annual exam');
INSERT INTO Visit(VisitDate, VisitDescription) VALUES ('2021-10-18', 'Whisker count');

INSERT INTO VisitPetProcedure(VisitID, PetId, ProcedureId) VALUES(3, 2, 1);
INSERT INTO VisitPetProcedure(VisitID, PetId, ProcedureId) VALUES(2, 3, 1);
INSERT INTO VisitPetProcedure(VisitID, PetId, ProcedureId) VALUES(1, 2, 1);