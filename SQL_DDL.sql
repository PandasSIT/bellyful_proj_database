

USE [bellyful] 

-- Create tables section -------------------------------------------------


--drop table [meal_type]
DROP TABLE IF EXISTS [meal_type]
CREATE TABLE [meal_type]
(
 [meal_type_id] Tinyint identity(1,1) NOT NULL,
 [meal_type_name] Varchar(35) NOT NULL,
 [shelf_location] Varchar(2) NOT NULL,
 PRIMARY KEY ([meal_type_id])
)
INSERT INTO [meal_type] VALUES ('Beef Lasagne', 'A');
INSERT INTO [meal_type] VALUES ('Beef Bolognese Sauce', 'B');
INSERT INTO [meal_type] VALUES ('Macaroni Cheese', 'C');
INSERT INTO [meal_type] VALUES ('Tomato and Red Lentil Soup', 'D');
go
--select * from [meal_type]
--select * from [meal_instock]

--drop table [meal_instock]
DROP TABLE IF EXISTS [meal_instock]
CREATE TABLE [meal_instock]
(
 [meal_type_id] Tinyint NOT NULL,
 [instock_amount] Int NOT NULL,
 PRIMARY KEY ([meal_type_id])
)
ALTER TABLE [meal_instock] ADD CONSTRAINT [one meal type has one instock] 
FOREIGN KEY ([meal_type_id]) REFERENCES [meal_type] ([meal_type_id]) 
ON DELETE CASCADE        
ON UPDATE no action 

go
INSERT INTO [meal_instock] VALUES (1,0);
INSERT INTO [meal_instock] VALUES (2,0);
INSERT INTO [meal_instock] VALUES (3,0);
INSERT INTO [meal_instock] VALUES (4,0);

--select  [meal_type_name],[instock_amount] from [meal_instock] ,[meal_type] where [meal_instock].[meal_type_id] = [meal_type].[meal_type_id]
--select  [meal_type_name],[instock_amount] from [meal_type] ,[meal_instock] where [meal_instock].[meal_type_id] = [meal_type].[meal_type_id]
--update [meal_instock] 
-- set  [instock_amount] = [instock_amount]-1
-- where [meal_type_id] = 1
-- --dosen't affect 

-- DELETE FROM [meal_type]
--WHERE [meal_type_id] = 2;


-- drop table [meal_instock]
-- drop table [meal_type]

-- Table batch
--drop table [batch]
DROP TABLE IF EXISTS [batch]
CREATE TABLE [batch]
(
 [batch_id] Int identity(1,1),
 [add_amount] Int NOT NULL,
 [production_date] Date NOT NULL,
 [meal_type_id] Tinyint NOT NULL,
 PRIMARY KEY ([batch_id])
)
DROP trigger IF EXISTS [IncreaseInventoryforInsertBatch]
go
CREATE TRIGGER
 [IncreaseInventoryforInsertBatch] ON [batch]
 After INSERT as
update [meal_instock] 
set [instock_amount] += (select add_amount from Inserted)
where [meal_type_id] =(select [meal_type_id] from Inserted) ;
go
--drop trigger [IncreaseInventoryforInsertBatch]


ALTER TABLE [batch] ADD CONSTRAINT [a batch has a meal type] 
FOREIGN KEY ([meal_type_id]) REFERENCES [meal_type] ([meal_type_id]) 
ON DELETE CASCADE    ON UPDATE CASCADE 
go
INSERT INTO [batch] VALUES (7,'12-aug-2019',1);
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
DROP TABLE IF EXISTS [volunteer]
CREATE TABLE [volunteer]
(
 [volunteer_id] Int  identity(1,1),
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(55) NOT NULL,
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
  PRIMARY KEY ([volunteer_id]),
  UNIQUE ([first_name],[last_name],[DOB]) -- set unique rule
)
go

-- Table volunteer_role
--drop table[volunteer_role]
DROP TABLE IF EXISTS [volunteer_role]
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
DROP TABLE IF EXISTS [volunteer_status]
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
DROP TABLE IF EXISTS [branch]
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
DROP TABLE IF EXISTS [volunteer_police_info]
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
DROP TABLE IF EXISTS [volunteer_training_info]
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
DROP TABLE IF EXISTS [volunteer_emergency_contact]
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
DROP TABLE IF EXISTS [referrer_role]
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
DROP TABLE IF EXISTS [referrer]
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
 PRIMARY KEY ([referrer_id]),
 UNIQUE ([first_name],[last_name],[organisation_name]) -- set unique rule
)
go
ALTER TABLE [referrer] ADD CONSTRAINT [Referrer has/not has a role] FOREIGN KEY ([ReferringAs]) REFERENCES [referrer_role] ([role_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

INSERT INTO [referrer] VALUES ('Len ','Reade','Sounthland Hospital','020-21212121',null,'Invercargill',2);
INSERT INTO [referrer] VALUES ('Amelia','Kitty','Sounthland Hospital','020-21212121','asd@sdf.com','Invercargill',1);
INSERT INTO [referrer] VALUES ('Emily ','Tours','Sounthland Hospital','020-21212121',null,'Invercargill',3);

--select * from [referrer]

-- Table dietary_requirement
--drop table [dietary_requirement]
DROP TABLE IF EXISTS [dietary_requirement]
CREATE TABLE [dietary_requirement]
(
 [dietary_requirement_id] Tinyint identity(1,1),
 [dietary_name] Varchar(55) NOT NULL,
 [matched_set_meal] Varchar(125) NULL,
 [description] Varchar(125)  NULL,
 PRIMARY KEY ([dietary_requirement_id])
)
go

INSERT INTO [dietary_requirement] VALUES ('No spical requirements','Rgular Set','Meal:A,B,C');
INSERT INTO [dietary_requirement] VALUES ('Vegetarian','Vegetarian Set','Meal:A,C,D');
INSERT INTO [dietary_requirement] VALUES ('Vegan','Vegan Set','Meal:C,D');
INSERT INTO [dietary_requirement] VALUES ('Gluten Free','Gluten Free Set','Meal:A,B,D');
INSERT INTO [dietary_requirement] VALUES ('Other',null,null);

--select * from [dietary_requirement]
--drop table [dietary_requirement]
DROP TABLE IF EXISTS [referral_reason]
CREATE TABLE [referral_reason]
(
 [referral_reason_id] Tinyint identity(1,1),
 [content] Varchar(255)  NULL,
 PRIMARY KEY ([referral_reason_id])
)
go
INSERT INTO [referral_reason] VALUES ('We have a baby under 3 months and lack of a good support network');
INSERT INTO [referral_reason] VALUES ('We have young children and are struggling with serious illness in the family');
INSERT INTO [referral_reason] VALUES ('We do not fit the criteria but would like to apply (enter detail below)');
INSERT INTO [referral_reason] VALUES ('Other reasons (enter details below)');

--select * from [dietary_requirement]



--drop table [recipient]
DROP TABLE IF EXISTS [recipient]
CREATE TABLE [recipient]
(
 [recipient_id] Int identity(1,1),
 [first_name] Varchar(55) NOT NULL,
 [last_name] Varchar(55) NOT NULL,
 [address_num_street] Varchar(255) NOT NULL,
 [town_city] Varchar(25) NOT NULL,
 [postcode] Int NULL,
 [phone_number] Varchar(20) NOT NULL,
 [email] Varchar(55) NULL,
 [dog_on_property] Tinyint NULL,
 [nearest_branch] Int NOT NULL,
 [referral_reason] Tinyint NOT NULL,
 [other_referral_info] Varchar(2555) NULL,
 [adults_num] Tinyint NOT NULL,
 [under5_children_num] Tinyint NOT NULL,
 [5-10_children_num] Tinyint NOT NULL,
 [11-17_children_num] Tinyint NOT NULL,
 [dietary_requirement] Tinyint NULL,
 [other_allergy_info] Varchar(2555) NULL,
 [additional_info] Varchar(2555) NULL,
 [referrer_id] Int NULL,
 [created_date] Datetime NULL,
 PRIMARY KEY ([recipient_id]),
 UNIQUE ([first_name],[last_name],[address_num_street]) -- set unique rule
);
go


ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has/not has a Referrer] FOREIGN KEY ([referrer_id]) 
REFERENCES [referrer] ([referrer_id]) ON UPDATE NO ACTION ON DELETE SET NULL

ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has a requirement] FOREIGN KEY ([dietary_requirement]) 
REFERENCES [dietary_requirement] ([dietary_requirement_id]) ON UPDATE NO ACTION ON DELETE NO ACTION

ALTER TABLE [recipient] ADD CONSTRAINT [Recipient has a Reason] FOREIGN KEY ([referral_reason]) 
REFERENCES [referral_reason] ([referral_reason_id]) ON UPDATE NO ACTION ON DELETE NO ACTION

ALTER TABLE [recipient] ADD CONSTRAINT [Recipient belones to a Branch] FOREIGN KEY ([nearest_branch])
 REFERENCES [branch] ([branch_id]) ON UPDATE NO ACTION ON DELETE NO ACTION

 -- Create triggers for table recipient
go
DROP trigger IF EXISTS [PopulateDatetime_for_recipient]
go
CREATE TRIGGER
 [PopulateDatetime_for_recipient] ON [recipient]
 FOR INSERT as
update [recipient] 
set [created_date] = getdate()
where [recipient_id] =(select [recipient_id] from Inserted) ;
go

--DROP  TRIGGER    [recipient_date_created]
-- Create triggers for table recipient



INSERT INTO [recipient] VALUES ('Chasel','Oscar' ,'111 Tay St ','Invercargill',
'9810','021-2221111','asd@asd.com',0,2,2,null,2,1,0,0,1,null,null,null,null);
INSERT INTO [recipient] VALUES ('Edwiin','Noel' ,'121 Tay St ','Invercargill',
'9810','021-2221111','asd@asd.com',1,2,1,null,5,2,0,1,1,null,null,null,null);
INSERT INTO [recipient] VALUES ('Steward','Franklin' ,'221 Tay St ','Invercargill',
'9810','021-2221111','asd@asd.com',0,2,2,null,2,1,1,0,2,null,null,null,null);
INSERT INTO [recipient] VALUES ('Olivia','Childe' ,'121 Tay St ','Invercargill',
'9810','021-2221111','asd@asd.com',1,2,1,null,3,1,0,1,1,null,null,null,null);
INSERT INTO [recipient] VALUES ('Verna ','Malory' ,'221 Tay St ','Invercargill',
'9810','021-2221111','asd@asd.com',0,2,1,null,2,3,1,0,3,null,null,null,null);
INSERT INTO [recipient] VALUES ('Bess ','FitzGerald' ,'221 Tay St ','Invercargill',
'9810','021-2221111','asd@asd.com',0,2,3,null,3,1,0,0,1,null,null,null,null);

--DELETE FROM [recipient]

--select * from [recipient]







--########green #######





--######### Final#########

-- Table order_status
DROP TABLE IF EXISTS [order_status]
CREATE TABLE [order_status]
(
 [status_id] Tinyint identity(1,1),
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
--ALTER TABLE [order_status] ADD CONSTRAINT [content] UNIQUE CLUSTERED ([content])
go
--select * from [order_status]
--drop table [order_status]







-- Table order
DROP TABLE IF EXISTS [order]
CREATE TABLE [order]
(
 [order_id] Int identity(1000,1),
 [status_id] Tinyint default 1  NULL,
 [delivery_man] Int NULL,
 [recipient_id] Int NOT NULL,
 [created_datetime] Datetime NULL,
 [assign_datetime] Datetime NULL,
 [pickup_datetime] Datetime NULL,
 [delivered_datetime] Datetime NULL,
  PRIMARY KEY ([order_id])
)

go
DROP trigger IF EXISTS [PopulateDatetime_for_order]
go
CREATE TRIGGER
 [PopulateDatetime_for_order] ON [order]
 FOR INSERT as
update [order] 
set [created_datetime] = getdate()
where order_id =(select order_id from Inserted) ;
go











ALTER TABLE [order] ADD CONSTRAINT [an order can assign a volunteer as delivery man] FOREIGN KEY ([delivery_man]) REFERENCES [volunteer] ([volunteer_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [order] ADD CONSTRAINT [an order has a recipient] FOREIGN KEY ([recipient_id]) REFERENCES [recipient] ([recipient_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [order] ADD CONSTRAINT [every order has a status] FOREIGN KEY ([status_id]) REFERENCES [order_status] ([status_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

--######### Final#########

INSERT INTO [order] ([delivery_man],[recipient_id])VALUES (null,2);
INSERT INTO [order] ([delivery_man],[recipient_id])VALUES (null,3);
INSERT INTO [order] ([delivery_man],[recipient_id])VALUES (null,1);
--select * from [order]


/*
Created: 2019/7/20
Modified: 2019/7/20
Model: Microsoft SQL Server 2017
Database: MS SQL Server 2017
*/

--#######Create Procedures#########
--1.查订单  按订单状态排序， finished  delivering  assigned pushed created
--
go
DROP PROCEDURE IF EXISTS sp_ListAllOrder
go
CREATE PROCEDURE sp_ListAllOrder
AS
BEGIN
SELECT order_id, content as [Order Status] , 
rtrim(v.first_name)+' '+rtrim(v.last_name) AS [Delivery Man FullName],
rtrim(r.first_name)+' '+rtrim(r.last_name) AS [Recipient FullName],
o.created_datetime as [Create Time],o.assign_datetime as[Assign Time],
o.pickup_datetime as [Pickup Time],o.delivered_datetime as [Finished Delivery Time]
from [order]as o
left join [order_status] as os on o.status_id = os.status_id 
left join [volunteer] as v on o.delivery_man = v.volunteer_id
left join [recipient] as r on o.recipient_id = r.recipient_id
order by  o.status_id desc
END
go
--EXEC sp_ListAllOrder;
go
--drop PROCEDURE sp_ListAllOrder

--.查所有已推送订单 
go
DROP PROCEDURE IF EXISTS sp_ListAllPushedOrder
go
CREATE PROCEDURE sp_ListAllPushedOrder
AS
BEGIN
SELECT order_id, content as [Order Status] , 
rtrim(v.first_name)+' '+rtrim(v.last_name) AS [Delivery Man FullName],
rtrim(r.first_name)+' '+rtrim(r.last_name) AS [Recipient FullName],
o.created_datetime as [Create Time],o.assign_datetime as[Assign Time],
o.pickup_datetime as [Pickup Time],o.delivered_datetime as [Finished Delivery Time]
from [order]as o
left join [order_status] as os on o.status_id = os.status_id 
left join [volunteer] as v on o.delivery_man = v.volunteer_id
left join [recipient] as r on o.recipient_id = r.recipient_id
where o.status_id = 2
order by  o.status_id desc
END
go
--EXEC sp_ListAllPushedOrder;
go
--drop PROCEDURE sp_ListAllPushedOrder



-- 查我的订单（指定志愿者ID）
go
DROP PROCEDURE IF EXISTS sp_ListMyOrder
go
CREATE PROCEDURE sp_ListMyOrder @vid int
AS
BEGIN
SELECT order_id, content as [Order Status] , 
rtrim(v.first_name)+' '+rtrim(v.last_name) AS [Delivery Man FullName],
rtrim(r.first_name)+' '+rtrim(r.last_name) AS [Recipient FullName],
o.created_datetime as [Create Time],o.assign_datetime as[Assign Time],
o.pickup_datetime as [Pickup Time],o.delivered_datetime as [Finished Delivery Time]
from [order]as o
left join [order_status] as os on o.status_id = os.status_id 
left join [volunteer] as v on o.delivery_man = v.volunteer_id
left join [recipient] as r on o.recipient_id = r.recipient_id
where o.delivery_man = @vid
order by  o.status_id desc
END
go
--EXEC sp_ListMyOrder 3;
go

--2. 推送指定订单 1002
go
DROP PROCEDURE IF EXISTS sp_PushOrderWithP
go

CREATE PROCEDURE sp_PushOrderWithP @orderID int
AS
begin
	if(select [status_id] from [order] where order_id =  @orderId) = 1 
		--only Created stauts order can be pushed 
		begin 
			update [order] 
			set status_id = 2 
			where order_id = @orderID ;
		END
	else 
		begin
		RAISERROR (15600,-1,-1, 'Only can push Created Order !!'); 
		end
END
go
--Example: EXEC sp_PushOrderWithP 1004;
go
--drop PROCEDURE sp_PushOrderWithP

--2.1 推送全部订单
go
DROP PROCEDURE IF EXISTS sp_PushAllOrders
go
CREATE PROCEDURE sp_PushAllOrders
AS
BEGIN
update [order] 
set status_id = 2 
where status_id = 1 ;
END
go
--Example:EXEC sp_PushAllOrders ;
go
--drop PROCEDURE sp_PushAllOrders

--3. volunteer take order (volunteerID,orderID)
go
DROP PROCEDURE IF EXISTS sp_TakeOrder
go
CREATE PROCEDURE sp_TakeOrder @deliveryMan int, @orderId int
AS
BEGIN
	if(select [status_id] from [order] where order_id =  @orderId) = 2 
	--only pushed stauts order can be taken by volunteer
		begin 
			update [order] 
			set status_id = 3,
			assign_datetime = getdate(),
			delivery_man = @deliveryMan 
			where order_id = @orderId ;
		end
	else 
		begin
		RAISERROR (15600,-1,-1, 'Only can take Pushed Order !!'); 
		end
	END
go
--Example:exec  sp_TakeOrder ;
--drop PROCEDURE sp_TakeOrder
go
--4  volunteer pick up meal (volunteerID,orderID) select * from order_status  select * from [order ]
go
DROP PROCEDURE IF EXISTS sp_PickupMeal
go
CREATE PROCEDURE sp_PickupMeal @deliveryMan int, @orderId int
AS
BEGIN
	if(
	(select [status_id] from [order] where order_id =  @orderId) = 3 
	and (select delivery_man from [order] where order_id =  @orderId) = @deliveryMan
	)--only assigned Order and order owner can pick up meal
		begin 
			update [order] 
			set status_id = 4,
			pickup_datetime = getdate()
			where order_id = @orderId ;
		end
	else 
		begin
		RAISERROR (15600,-1,-1, 'Only can pickup Meal for the your own order and order status must be assigned'); 
		end
	END
go
--Example:exec  sp_PickupMeal 4,1002 ;
--drop PROCEDURE sp_PickupMeal

--5 volunteer finished the order
go
DROP PROCEDURE IF EXISTS sp_FinishedOrder
go
CREATE PROCEDURE sp_FinishedOrder @deliveryMan int, @orderId int
AS
BEGIN
	if(
	(select [status_id] from [order] where order_id =  @orderId) = 4 
	and (select delivery_man from [order] where order_id =  @orderId) = @deliveryMan
	)--only delivering Order status and  order  owner can finish the order
		begin 
			update [order] 
			set status_id = 5,
			delivered_datetime = getdate()
			where order_id = @orderId ;
		end
	else 
		begin
		RAISERROR (15600,-1,-1, 'Only can pickup Meal for the your own order and order status must be assigned'); 
		end
	END
go

--Example:exec  sp_FinishedOrder 4,1002 ;
--drop PROCEDURE sp_FinishedOrder

go

-- 查询受助者
go
DROP PROCEDURE IF EXISTS sp_ListAllRecipient
go
CREATE PROCEDURE sp_ListAllRecipient
AS
BEGIN
SELECT recipient_id,  
rtrim(r.first_name)+' '+rtrim(r.last_name) AS [Recipient FullName],
adults_num as [Adult Number],under5_children_num as [Under 5 Children],[5-10_children_num],[11-17_children_num],
d.matched_set_meal,d.[description],rtrim(r.address_num_street)+' '+rtrim(r.town_city) as [Address],phone_number
from [recipient]as r , [dietary_requirement] as d
where r.dietary_requirement = d.dietary_requirement_id;
END
--exec sp_ListAllRecipient
--drop PROCEDURE sp_ListAllRecipient
go


--- 查询所有志愿者
go
DROP PROCEDURE IF EXISTS sp_ListAllVolunteer
go
CREATE PROCEDURE sp_ListAllVolunteer
AS
BEGIN
SELECT v.volunteer_id,
rtrim(v.first_name)+' '+rtrim(v.last_name) AS [Volunteer FullName],v.DOB, v.preferred_phone as Phone,
rtrim(v.address)+' '+rtrim(v.town_city) as [Address], vr.role_name as [Role]
--,vp.police_vet_verified as [Police Verified], 
--vt.delivery_training ,vt.first_aid_raining,vt.[H&S_training]
from [volunteer]as v 
left join volunteer_police_info as vp on v.volunteer_id = vp.volunteer_id 
left join volunteer_training_info as vt on v.volunteer_id = vt.volunteer_id 
left join volunteer_role as vr on v.role_id = vr.role_id 
END

--exec sp_ListAllVolunteer
--drop PROCEDURE sp_ListAllVolunteer
go

--查询库存 位置
go
DROP PROCEDURE IF EXISTS sp_ListAllInstock
go
CREATE PROCEDURE sp_ListAllInstock
AS
BEGIN
	select meal_type_name as [Meal Type], instock_amount as [Amount] ,t.shelf_location [Shelf Location]
	from meal_instock as i, meal_type as t 
	where i.meal_type_id=t.meal_type_id
end
--exec sp_ListAllInstock
--drop PROCEDURE sp_ListAllInstock
go
DROP PROCEDURE IF EXISTS sp_dropAllTables
go
CREATE PROCEDURE sp_dropAllTables
AS
BEGIN
	drop table [order]
drop table [order_status]
--finial
drop table [batch]
drop table [meal_instock]
drop table [meal_type]
--grey
drop table [volunteer_police_info]
drop table [volunteer_training_info]
drop table [volunteer_emergency_contact]
drop table [volunteer]
drop table [volunteer_role]
drop table [volunteer_status]
--green
--blue
drop table [recipient]
drop table [referrer]
drop Table [referral_reason]
drop table [dietary_requirement]
drop table [referrer_role]
drop table [branch]
--finial
end
go
DROP PROCEDURE IF EXISTS sp_selectAllTables
go
CREATE PROCEDURE sp_selectAllTables
AS
BEGIN
select * from  [meal_instock]
select * from  [batch]
select * from  [meal_type]
--grey
select * from  [volunteer_role]
select * from  [volunteer_status]
select * from  [volunteer]
select * from  [volunteer_police_info]
select * from  [volunteer_training_info]
select * from  [volunteer_emergency_contact]
select * from  [branch]
--blue
select * from [referrer]
select * from [referrer_role]
select * from [referral_reason]
select * from [dietary_requirement]
select * from [recipient]
select * from [order];
select * from [order_status];
--green
end


----#######End of Create Procedures#########

/*========================DML==================*/


----查所有表
--exec sp_selectAllTables

----删除所有表!!!!!!
--exec sp_dropAllTables




---- use procedure for functional List
---- add new  volunteer
--INSERT INTO [volunteer] VALUES ('Yana','F','12-aug-1999','asd@asd.com','0212912123',null,'111 Tay St ','Invercargill',null,2,3,1);

----add new recipient
--INSERT INTO [recipient] VALUES ('Bellyful','Inv' ,'221 Tay St ','Invercargill',
--'9810','021-2221111','asd@asd.com',0,2,3,null,3,1,0,0,1,null,null,null,null);
--select * from volunteer

----  1 库存查询
--exec sp_ListAllInstock

----  2 查volunteer 
--exec sp_ListAllVolunteer

----  3 受助者查询
--exec sp_ListAllRecipient

----  4  列出所有订单
--EXEC sp_ListAllOrder;


---- 5 Place an Order 下订单
--exec sp_ListAllRecipient
--INSERT INTO [order] ([recipient_id])VALUES (8); --指定受助者
--EXEC sp_ListAllOrder;

---- 6 推送指定订单 
--EXEC sp_PushOrderWithP 1011;  --（订单ID）
--EXEC sp_ListAllOrder;

---- 6 经理推送所有已创建订单()
--EXEC sp_PushAllOrders ;
--EXEC sp_ListAllOrder;

----=================================
---- 1 查所有已推送订单
--EXEC sp_ListAllPushedOrder;

---- 2  志愿者接单 take order (volunteerID,orderID) 
--exec sp_ListAllVolunteer
--exec  sp_TakeOrder  8, 1011;  --(志愿者ID，order ID)
--EXEC sp_ListAllOrder;

---- 3 查我的订单 
--exec sp_ListAllVolunteer
--exec sp_ListMyOrder 8 -- (志愿者ID)

---- 4 volunteer pick up meal (volunteerID,orderID) 志愿者取餐 
--exec sp_ListMyOrder 8
--exec  sp_PickupMeal 8,1011 ;  --（志愿者ID，订单ID）
--EXEC sp_ListAllOrder;


---- 5 完成订单
--exec  sp_FinishedOrder 8,1011 ;--（志愿者ID，订单ID）
--EXEC sp_ListAllOrder;

----显示Expeid 批次ID(未完成)
--select * from [batch]


----===========cooking manager======

---- 1 查库存
--exec sp_ListAllInstock

---- 2 添加批次
--INSERT INTO [batch] VALUES (11,'12-aug-2019',2);  --数量，日期，类型
--exec sp_ListAllInstock

---- 3
--exec sp_ListAllVolunteer
---- 4
--EXEC sp_ListAllOrder;
---- 5
--exec sp_ListAllRecipient