

USE [bellyful] 

-- Create tables section -------------------------------------------------


--drop table [meal_type]
CREATE TABLE [meal_type]
(
 [meal_type_id] Tinyint identity(1,1) NOT NULL,
 [name] Varchar(35) NOT NULL,
 [shelf_location] Varchar(2) NOT NULL,
 PRIMARY KEY ([meal_type_id])
)
INSERT INTO [meal_type] VALUES ('Beef Lasagne', 'A');
INSERT INTO [meal_type] VALUES ('Beef Bolognese Sauce', 'B');
INSERT INTO [meal_type] VALUES ('Macaroni Cheese', 'C');
INSERT INTO [meal_type] VALUES ('Tomato and Red Lentil Soup', 'D');
go
--select * from [meal_type]

--drop table [meal_instock]
CREATE TABLE [meal_instock]
(
 [meal_type_id] Tinyint NOT NULL,
 [instock_amount] Int NOT NULL,
 PRIMARY KEY ([meal_type_id])
)
ALTER TABLE [meal_instock] ADD CONSTRAINT [one meal type has one instock] 
FOREIGN KEY ([meal_type_id]) REFERENCES [meal_type] ([meal_type_id]) 
ON DELETE CASCADE         
ON UPDATE CASCADE 
--select * from [meal_instock]
go
INSERT INTO [meal_instock] VALUES (1,15);
INSERT INTO [meal_instock] VALUES (2,10);
INSERT INTO [meal_instock] VALUES (3,12);
INSERT INTO [meal_instock] VALUES (4,8);
--select * from [meal_instock]

-- Table batch
--drop table [batch]
CREATE TABLE [batch]
(
 [batch_id] Int identity(1,1),
 [add_amount] Int NOT NULL,
 [expiring_date] Date NOT NULL,
 [meal_type_id] Tinyint NOT NULL,
 PRIMARY KEY ([batch_id])
)

ALTER TABLE [batch] ADD CONSTRAINT [a batch has a meal type] 
FOREIGN KEY ([meal_type_id]) REFERENCES [meal_type] ([meal_type_id]) 
ON DELETE CASCADE    ON UPDATE CASCADE 
go
INSERT INTO [batch] VALUES (7,'12-aug-2019',1);
INSERT INTO [batch] VALUES (11,'12-aug-2019',2);
INSERT INTO [batch] VALUES (10,'12-aug-2019',4);
INSERT INTO [batch] VALUES (10,'12-aug-2019',3);
INSERT INTO [batch] VALUES (12,'18-aug-2019',3);
INSERT INTO [batch] VALUES (12,'18-aug-2019',2);
INSERT INTO [batch] VALUES (9,'19-aug-2019',4);
INSERT INTO [batch] VALUES (13,'18-aug-2019',1);
--select * from [batch]
go

--select * from  [meal_instock]
--select * from  [batch]
--select * from  [meal_type]
--drop table [batch]
--drop table [meal_instock]
--drop table [meal_type]


--########grey done#######


--########blue #######


-- Table volunteer
--drop table [volunteer]
CREATE TABLE [volunteer]
(
 [volunteer_id] Int  identity(1,1),
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(5) NOT NULL,
 [DOB] Date NOT NULL,
 [email] Varchar(55) NOT NULL,
 [preferred_phone] Varchar(25) NOT NULL,
 [alternative_phone] Varchar(25) ,
 [address] Varchar(255) NOT NULL,
 [town_city] Varchar(25) NOT NULL,
 [post_code] Varchar(10) NULL,
 [status_id] Tinyint NULL,
 [branch_belonged] Int  NULL,
 [role_id] Tinyint NULL,
  PRIMARY KEY ([volunteer_id])
)
go

-- Table volunteer_role
--drop table[volunteer_role]
CREATE TABLE [volunteer_role]
(
 [role_id] Tinyint  identity(1,1),
 [role_name] Varchar(35) NOT NULL,
 PRIMARY KEY ([role_id])
)
INSERT INTO [volunteer_role] VALUES ('Delivery Man');
INSERT INTO [volunteer_role] VALUES ('Chef');
INSERT INTO [volunteer_role] VALUES ('Kitchen Helper');
go

-- Add keys for table volunteer_role


-- Table volunteer_status

--select * from  [volunteer_status]
--drop TABLE[volunteer_status]
CREATE TABLE [volunteer_status]
(
 [status_id] Tinyint  identity(1,1),
 [content] Varchar(25) NOT NULL,
 PRIMARY KEY ([status_id])
)
INSERT INTO [volunteer_status] VALUES ('Active');
INSERT INTO [volunteer_status] VALUES ('Dimission');
INSERT INTO [volunteer_status] VALUES ('Unavailable');
go

ALTER TABLE [volunteer] ADD CONSTRAINT [a volunteer has a status] FOREIGN KEY ([status_id]) REFERENCES [volunteer_status] ([status_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [volunteer] ADD CONSTRAINT [a volunteer has a role] FOREIGN KEY ([role_id]) REFERENCES [volunteer_role] ([role_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


--drop table [branch]
CREATE TABLE [branch]
(
 [branch_id] int  identity(1,1),
 [name] Varchar(25) NOT NULL,
 [phone_number] Varchar(25) NULL,
 [address_num_street] Varchar(55) NULL,
 [town_city] Varchar(20) NULL,
 PRIMARY KEY ([branch_id])
)

go
INSERT INTO [branch] VALUES ('Invercargill','02223333','123 Tay St','Invercargill');
INSERT INTO [branch] VALUES ('Auckland','02223333','11 Tay St','Auckland');
INSERT INTO [branch] VALUES ('Queenstown','02223333','555 Tay St','Queenstown');
ALTER TABLE [volunteer] ADD CONSTRAINT [a volunteer belones to a branch] FOREIGN KEY ([branch_belonged]) REFERENCES [branch] ([branch_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

--select * from [branch]




INSERT INTO [volunteer] VALUES ('Tim','G','12-aug-1989','asd@asd.com','0212912123',null,'111 Tay St ','Invercargill',null,2,3,2);
INSERT INTO [volunteer] VALUES ('Tim1','G','12-aug-1989','asd@asd.com','0212912123',null,'111 Tay St ','Invercargill',null,2,3,2);
INSERT INTO [volunteer] VALUES ('Tim122','G','12-aug-1989','asd@asd.com','0212912123',null,'111 Tay St ','Invercargill',null,2,3,2);
INSERT INTO [volunteer] VALUES ('Tim1232','G','12-aug-1989','asd@asd.com','0212912123',null,'111 Tay St ','Invercargill',null,null,3,2);





--drop table [volunteer_police_info]
CREATE TABLE [volunteer_police_info]
(
 [volunteer_id] Int NOT NULL,
 [police_vet_date] Date NOT NULL,
 [police_vet_verified] tinyint NOT NULL,
  PRIMARY KEY ([volunteer_id])
)
go
--One to one relationship
ALTER TABLE [volunteer_police_info] ADD CONSTRAINT [a volunteer has a police info] FOREIGN KEY ([volunteer_id]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

INSERT INTO [volunteer_police_info] VALUES (4,'12-may-2019',1);
INSERT INTO [volunteer_police_info] VALUES (2,'15-apr-2019',1);
INSERT INTO [volunteer_police_info] VALUES (1,'02-mar-2019',1);
INSERT INTO [volunteer_police_info] VALUES (3,'22-may-2019',1);

--select * from [volunteer_police_info]

-- Table volunteer_training_info
--drop table [volunteer_training_info]
CREATE TABLE [volunteer_training_info]
(
 [volunteer_id] Int NOT NULL,
 [delivery_training] Tinyint NOT NULL,
 [H&S_training] Tinyint NOT NULL,
 [first_aid_raining] Tinyint NOT NULL,
 [other_training_skill] Varchar(255) NULL,
  PRIMARY KEY ([volunteer_id])
)
go
--One to one relationship
ALTER TABLE [volunteer_training_info] ADD CONSTRAINT [a voluteer has a train info] FOREIGN KEY ([volunteer_id]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go
INSERT INTO [volunteer_training_info] VALUES (2,1,0,1,null);
INSERT INTO [volunteer_training_info] VALUES (1,1,1,1,null);
INSERT INTO [volunteer_training_info] VALUES (3,1,0,0,null);
INSERT INTO [volunteer_training_info] VALUES (4,1,1,1,null);
--select * from [volunteer_training_info]



-- Table volunteer_emergency_contact
--drop table [volunteer_emergency_contact]
CREATE TABLE [volunteer_emergency_contact]
(
 [volunteer_id] Int NOT NULL,
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(55) NOT NULL,
 [phone_number] Varchar(25) NOT NULL,
 [relationship] Varchar(20) NOT NULL,
  PRIMARY KEY ([volunteer_id])
)
go

--One to one relationship
ALTER TABLE [volunteer_emergency_contact] ADD CONSTRAINT [a volunteer has a emergency contact] FOREIGN KEY ([volunteer_id]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go
INSERT INTO [volunteer_emergency_contact] VALUES (2,'Ivan ','Morris','025-123123','Son');
INSERT INTO [volunteer_emergency_contact] VALUES (1,'Keith','Tyler','025-123123','Mother');
INSERT INTO [volunteer_emergency_contact] VALUES (3,'Antonia','Virginia','022-125555','Father');
INSERT INTO [volunteer_emergency_contact] VALUES (4,'Tracy ','Symons','021-222222','Father');

--******Drop tables for Blues Area
--drop table [volunteer_police_info]
--drop table [volunteer_training_info]
--drop table [volunteer_emergency_contact]
--drop table [volunteer]
--drop table [volunteer_role]
--drop table [volunteer_status]
--drop table [branch]

--select * from  [volunteer_role]
--select * from  [volunteer_status]
--select * from  [volunteer]
--select * from  [volunteer_police_info]
--select * from  [volunteer_training_info]
--select * from  [volunteer_emergency_contact]
--select * from  [branch]

--########blue #######



--########green #######

-- Table referrer_role
--drop table [referrer_role]
CREATE TABLE [referrer_role]
(
 [role_id] TinyInt identity(1,1),
 [role_name] Varchar(35) NOT NULL,
  PRIMARY KEY ([role_id])
)
go

INSERT INTO [referrer_role] VALUES ('Doctor');
INSERT INTO [referrer_role] VALUES ('Midwife');
INSERT INTO [referrer_role] VALUES ('Specialist');
--select * from [referrer_role]

-- Table referrer
--drop table [referrer]
CREATE TABLE [referrer]
(
 [referrer_id] Int identity(1,1),
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(55) NOT NULL,
 [organisation_name] Varchar(55) NULL,
 [phone_number] Varchar(25) NOT NULL,
 [email] Varchar(55) NULL,
 [town_city] Varchar(20) NULL,
 [ReferringAs] TinyInt NOT NULL,
 PRIMARY KEY ([referrer_id])
)
go
ALTER TABLE [referrer] ADD CONSTRAINT [Referrer has/not has a role] FOREIGN KEY ([ReferringAs]) REFERENCES [referrer_role] ([role_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

INSERT INTO [referrer] VALUES ('Len ','Reade','Sounthland Hospital','020-21212121',null,'Invercargill',2);
INSERT INTO [referrer] VALUES ('Amelia','Kitty','Sounthland Hospital','020-21212121','asd@sdf.com','Invercargill',1);
INSERT INTO [referrer] VALUES ('Emily ','Tours','Sounthland Hospital','020-21212121',null,'Invercargill',3);

--select * from [referrer]

-- Table dietary_requirement

CREATE TABLE [dietary_requirement]
(
 [dietary_requirement_id] Int NOT NULL,
 [dietary_name] Varchar(255) NOT NULL,
 PRIMARY KEY ([dietary_requirement_id])
)
go

INSERT INTO [referrer] VALUES ('Emily ','Tours','Sounthland Hospital','020-21212121',null,'Invercargill',3);
----^&^&^&^&

-- Table referral_reason

CREATE TABLE [referral_reason]
(
 [referral_reason_id] Int NOT NULL,
 [content] Varchar(255) NOT NULL,
 PRIMARY KEY ([referral_reason_id])
)
go







--drop table [referrer]
--drop table [referrer_role]


--select * from [referrer]
--select * from [referrer_role]




--########green #######




/*
Created: 2019/7/20
Modified: 2019/7/20
Model: Microsoft SQL Server 2017
Database: MS SQL Server 2017
*/












-- Table recipient
drop table [recipient]
CREATE TABLE [recipient]
(
 [recipient_id] Int NOT NULL,
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(55) NOT NULL,
 [address_num_street] Varchar(255) NOT NULL,
 [town_city] Varchar(25) NOT NULL,
 [postcode] Int NULL,
 [phone_number] Varchar(20) NOT NULL,
 [email] Varchar(55) NULL,
 [dog_on_property] Smallint NULL,
 [nearest_branch] Int NOT NULL,
 [referral_reason] Int NOT NULL,
 [other_referral_info] Varchar(2555) NULL,
 [adults_num] Smallint NOT NULL,
 [under5_children_num] Smallint NOT NULL,
 [5-10_children_num] Smallint NOT NULL,
 [11-17_children_num] Smallint NOT NULL,
 [dietary_requirement] Int NULL,
 [referrer_id] Int NULL,
 [other_allergy_info] Varchar(2555) NULL,
 [additional_info] Varchar(2555) NULL,
 [created_date] Datetime NOT NULL
)
go

-- Add keys for table recipient

ALTER TABLE [recipient] ADD CONSTRAINT [Key1] PRIMARY KEY ([recipient_id])
go

-- Create triggers for table recipient

CREATE TRIGGER [recipient_date_created]
  ON [recipient]
  BEFORE
  AS
CREATE
    /*!50017 DEFINER = 'root'@'localhost' */
    TRIGGER `recipient_date_created` BEFORE INSERT ON `recipient` 
    FOR EACH ROW 
set new.`date_created` = now();
go

-- Table volunteer_police_info




--######### Final#########

-- Table order_status

CREATE TABLE [order_status]
(
 [status_id] Tinyint NOT NULL,
 [content] Varchar(25) NOT NULL,
 PRIMARY KEY ([status_id])
)
go
INSERT INTO [order_status] VALUES ('Created');
INSERT INTO [order_status] VALUES ('Pushed');
INSERT INTO [order_status] VALUES ('Assigned');
INSERT INTO [order_status] VALUES ('Delivering');
INSERT INTO [order_status] VALUES ('Completed');
INSERT INTO [order_status] VALUES ('Cancelled');
ALTER TABLE [order_status] ADD CONSTRAINT [content] UNIQUE CLUSTERED ([content])
go


-- Table order

CREATE TABLE [order]
(
 [order_id] Int NOT NULL,
 [status_id] Tinyint NOT NULL,
 [delivery_man] Int NOT NULL,
 [recipient_id] Int NOT NULL,
 [created_datetime] Datetime NULL,
 [assign_datetime] Datetime NULL,
 [pickup_datetime] Datetime NULL,
 [delivered_datetime] Datetime NULL
)
go
ALTER TABLE [order] ADD CONSTRAINT [Key8] PRIMARY KEY ([order_id],[status_id],[recipient_id])
go

--######### Final#########















-- Create foreign keys (relationships) section ------------------------------------------------- 



ALTER TABLE [order] ADD CONSTRAINT [an order can assign a volunteer as delivery man] FOREIGN KEY ([delivery_man]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go





ALTER TABLE [order] ADD CONSTRAINT [an order has a recipient] FOREIGN KEY ([recipient_id]) REFERENCES [recipient] ([recipient_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go




ALTER TABLE [order] ADD CONSTRAINT [every order has a status] FOREIGN KEY ([status_id]) REFERENCES [order_status] ([status_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go





ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has/not has a Referrer] FOREIGN KEY ([referrer_id]) REFERENCES [referrer] ([referrer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has a requirement] FOREIGN KEY ([dietary_requirement]) REFERENCES [dietary_requirement] ([dietary_requirement_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has a Reason] FOREIGN KEY ([referral_reason]) REFERENCES [referral_reason] ([referral_reason_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [recipient] ADD CONSTRAINT [Recipient belones to a Branch] FOREIGN KEY ([nearest_branch]) REFERENCES [branch] ([branch_id]) ON UPDATE CASCADE ON DELETE CASCADE
go









