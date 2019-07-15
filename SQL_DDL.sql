

USE [bellyful] 

-- Create tables section -------------------------------------------------

-- Table meal_instock

--drop table [meal_instock]

-- Table meal_type
--drop table [meal_type]
CREATE TABLE [meal_type]
(
 [meal_type_id] Int identity(1000,1) NOT NULL,
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
 [meal_type_id] Int NOT NULL,
 [instock_amount] Int NOT NULL,
 PRIMARY KEY ([meal_type_id])
)
ALTER TABLE [meal_instock] ADD CONSTRAINT [one meal type has one instock] 
FOREIGN KEY ([meal_type_id]) REFERENCES [meal_type] ([meal_type_id]) 
ON DELETE CASCADE         
ON UPDATE CASCADE 
--select * from [meal_instock]
go
INSERT INTO [meal_instock] VALUES (1000,15);
INSERT INTO [meal_instock] VALUES (1001,10);
INSERT INTO [meal_instock] VALUES (1002,12);
INSERT INTO [meal_instock] VALUES (1003,8);--select * from [meal_instock]

-- Table batch
--drop table [batch]
CREATE TABLE [batch]
(
 [batch_id] Int identity(1,1),
 [add_amount] Int NOT NULL,
 [expiring_date] Date NOT NULL,
 [meal_type_id] Int NOT NULL,
 PRIMARY KEY ([batch_id])
)

ALTER TABLE [batch] ADD CONSTRAINT [a batch has a meal type] 
FOREIGN KEY ([meal_type_id]) REFERENCES [meal_type] ([meal_type_id]) 
ON DELETE CASCADE         
ON UPDATE CASCADE 
go
INSERT INTO [batch] VALUES (7,'12-aug-2019',1000);
INSERT INTO [batch] VALUES (11,'12-aug-2019',1001);
INSERT INTO [batch] VALUES (10,'12-aug-2019',1003);
INSERT INTO [batch] VALUES (10,'12-aug-2019',1002);
INSERT INTO [batch] VALUES (12,'18-aug-2019',1002);
INSERT INTO [batch] VALUES (12,'18-aug-2019',1001);
INSERT INTO [batch] VALUES (9,'19-aug-2019',1003);
INSERT INTO [batch] VALUES (13,'18-aug-2019',1000);
--select * from [batch]
go

select * from  [meal_instock]
select * from  [batch]
select * from  [meal_type]
drop table [meal_instock]
drop table [batch]
drop table [meal_type]


--########grey done#######


--########blue #######

-- Table volunteer_role
--drop table[volunteer_role]
CREATE TABLE [volunteer_role]
(
 [role_id] Int  identity(1,1),
 [role_name] Varchar(35) NOT NULL,
 PRIMARY KEY ([role_id])
)
INSERT INTO [volunteer_role] VALUES ('Delivery Man');
INSERT INTO [volunteer_role] VALUES ('Chef');
INSERT INTO [volunteer_role] VALUES ('Kitchen Helper');
go
select * from  [volunteer_role]
-- Add keys for table volunteer_role


-- Table volunteer_status
drop TABLE[volunteer_status]
CREATE TABLE [volunteer_status]
(
 [status_id] Smallint  identity(1,1),
 [content] Varchar(25) NOT NULL,
 PRIMARY KEY ([status_id])
)
INSERT INTO [volunteer_role] VALUES ('Delivery Man');
INSERT INTO [volunteer_role] VALUES ('Chef');
INSERT INTO [volunteer_role] VALUES ('Kitchen Helper');
go
select * from  [volunteer_role]
go

-- Add keys for table volunteer_status

ALTER TABLE [batch] ADD CONSTRAINT [a batch has a meal type] 
FOREIGN KEY ([meal_type_id]) REFERENCES [meal_type] ([meal_type_id]) 
ON DELETE CASCADE         
ON UPDATE CASCADE 




/*
Created: 2019/7/13
Modified: 2019/7/14
Model: Microsoft SQL Server 2017
Database: MS SQL Server 2017
*/

-- Table volunteer

CREATE TABLE [volunteer]
(
 [volunteer_id] Int NOT NULL,
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(5) NOT NULL,
 [DOB] Datetime2 NOT NULL,
 [email] Smallint NOT NULL,
 [preferred_phone] Varchar(25) NOT NULL,
 [alternative_phone] Varchar(25) NOT NULL,
 [address] Varchar(55) NOT NULL,
 [town_city] Varchar(25) NOT NULL,
 [post_code] Varchar(10) NULL,
 [status_id] Smallint NOT NULL,
 [branch_belonged] Int NOT NULL,
 [role_id] Int NULL
)
go

-- Add keys for table volunteer

ALTER TABLE [volunteer] ADD CONSTRAINT [Key10] PRIMARY KEY ([volunteer_id])
go

-- Table order_status

CREATE TABLE [order_status]
(
 [status_id] Tinyint NOT NULL,
 [content] Varchar(25) NOT NULL
)
go

-- Add keys for table order_status

ALTER TABLE [order_status] ADD CONSTRAINT [Key9] PRIMARY KEY ([status_id])
go

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

-- Add keys for table order

ALTER TABLE [order] ADD CONSTRAINT [Key8] PRIMARY KEY ([order_id],[status_id],[recipient_id])
go

-- Table referrer_role

CREATE TABLE [referrer_role]
(
 [role_id] Int NOT NULL,
 [role_name] Varchar(35) NOT NULL
)
go

-- Add keys for table referrer_role

ALTER TABLE [referrer_role] ADD CONSTRAINT [Key6] PRIMARY KEY ([role_id])
go

-- Table referrer

CREATE TABLE [referrer]
(
 [referrer_id] Int NOT NULL,
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(55) NOT NULL,
 [organisation_name] Varchar(55) NULL,
 [phone_number] Varchar(25) NOT NULL,
 [email] Varchar(55) NULL,
 [town_city] Varchar(20) NULL,
 [ReferringAs] Int NOT NULL
)
go

-- Add keys for table referrer

ALTER TABLE [referrer] ADD CONSTRAINT [Key5] PRIMARY KEY ([referrer_id])
go

-- Table dietary_requirement

CREATE TABLE [dietary_requirement]
(
 [dietary_requirement_id] Int NOT NULL,
 [dietary_name] Varchar(255) NOT NULL
)
go

-- Add keys for table dietary_requirement

ALTER TABLE [dietary_requirement] ADD CONSTRAINT [Key4] PRIMARY KEY ([dietary_requirement_id])
go

-- Table referral_reason

CREATE TABLE [referral_reason]
(
 [referral_reason_id] Int NOT NULL,
 [content] Varchar(255) NOT NULL
)
go

-- Add keys for table referral_reason

ALTER TABLE [referral_reason] ADD CONSTRAINT [Key3] PRIMARY KEY ([referral_reason_id])
go

-- Table branch

CREATE TABLE [branch]
(
 [branch_id] Int NOT NULL,
 [name] Varchar(25) NOT NULL,
 [phone_number] Varchar(25) NULL,
 [address_num_street] Varchar(55) NULL,
 [town_city] Varchar(20) NULL
)
go

-- Add keys for table branch

ALTER TABLE [branch] ADD CONSTRAINT [Key2] PRIMARY KEY ([branch_id])
go

-- Table recipient

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
 [created_date] Datetime2 NOT NULL
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

CREATE TABLE [volunteer_police_info]
(
 [volunteer_id] Int NOT NULL,
 [police_vet_date] Date NOT NULL,
 [police_vet_verified] Smallint NOT NULL
)
go

-- Add keys for table volunteer_police_info

ALTER TABLE [volunteer_police_info] ADD CONSTRAINT [Key11] PRIMARY KEY ([volunteer_id])
go

-- Table volunteer_training_info

CREATE TABLE [volunteer_training_info]
(
 [volunteer_id] Int NOT NULL,
 [delivery_training] Smallint NOT NULL,
 [other_training] Varchar(255) NULL,
 [H&S_training] Smallint NOT NULL,
 [first_aid_raining] Smallint NOT NULL
)
go

-- Add keys for table volunteer_training_info

ALTER TABLE [volunteer_training_info] ADD CONSTRAINT [Key11] PRIMARY KEY ([volunteer_id])
go

-- Table volunteer_emergency_contact

CREATE TABLE [volunteer_emergency_contact]
(
 [volunteer_id] Int NOT NULL,
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(55) NOT NULL,
 [phone_number] Varchar(25) NOT NULL,
 [relationship] Varchar(20) NOT NULL
)
go

-- Add keys for table volunteer_emergency_contact

ALTER TABLE [volunteer_emergency_contact] ADD CONSTRAINT [Key11] PRIMARY KEY ([volunteer_id])
go


-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [order] ADD CONSTRAINT [an order can assign a volunteer as delivery man] FOREIGN KEY ([delivery_man]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [volunteer] ADD CONSTRAINT [a volunteer has a role] FOREIGN KEY ([role_id]) REFERENCES [volunteer_role] ([role_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [volunteer_emergency_contact] ADD CONSTRAINT [a volunteer has a emergency contact] FOREIGN KEY ([volunteer_id]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [order] ADD CONSTRAINT [an order has a recipient] FOREIGN KEY ([recipient_id]) REFERENCES [recipient] ([recipient_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [volunteer] ADD CONSTRAINT [a volunteer has a status] FOREIGN KEY ([status_id]) REFERENCES [volunteer_status] ([status_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [volunteer] ADD CONSTRAINT [a volunteer belones to a branch] FOREIGN KEY ([branch_belonged]) REFERENCES [branch] ([branch_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [volunteer_police_info] ADD CONSTRAINT [a volunteer has a police info] FOREIGN KEY ([volunteer_id]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [volunteer_training_info] ADD CONSTRAINT [a voluteer has a train info] FOREIGN KEY ([volunteer_id]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [order] ADD CONSTRAINT [every order has a status] FOREIGN KEY ([status_id]) REFERENCES [order_status] ([status_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [referrer] ADD CONSTRAINT [Referrer has/not has a role] FOREIGN KEY ([ReferringAs]) REFERENCES [referrer_role] ([role_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has/not has a Referrer] FOREIGN KEY ([referrer_id]) REFERENCES [referrer] ([referrer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has a requirement] FOREIGN KEY ([dietary_requirement]) REFERENCES [dietary_requirement] ([dietary_requirement_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has a Reason] FOREIGN KEY ([referral_reason]) REFERENCES [referral_reason] ([referral_reason_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [recipient] ADD CONSTRAINT [Recipient belones to a Branch] FOREIGN KEY ([nearest_branch]) REFERENCES [branch] ([branch_id]) ON UPDATE CASCADE ON DELETE CASCADE
go









