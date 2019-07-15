/*
Created: 2019/6/29
Modified: 2019/7/9
Model: MySQL 5.7
Database: MySQL 5.7
*/




-- Create tables section -------------------------------------------------

-- Table Recipient
drop table if exists `Recipient`;
CREATE TABLE `Recipient`
(
  `recipient_id` Int NOT NULL AUTO_INCREMENT,
  `first_name` Varchar(55) NOT NULL,
  `last_name` Varchar(55) NOT NULL,
  `address_num_street` Varchar(255) NOT NULL,
  `town_city` Varchar(25) NOT NULL,
  `postcode` Int,
  `phone_number` Varchar(20) NOT NULL,
  `email` Varchar(55),
  `dog_on_property` Tinyint(1),
  `nearest_branch` Int NOT NULL,
  `referral_reason` Int NOT NULL,
  `other_referral_info` Varchar(2555),
  `adults_num` Tinyint NOT NULL,
  `under5_children_num` Tinyint NOT NULL,
  `5-10_children_num` Tinyint NOT NULL,
  `11-17_children_num` Tinyint NOT NULL,
  `dietary_requirement` Int,
  `referrer_id` Int,
  `other_allergy_info` Varchar(2555),
  `additional_info` Varchar(2555),
  `created_date` Datetime NOT NULL,
  PRIMARY KEY (`recipient_id`)
)
;

-- Create triggers for table Recipient



drop trigger if exists `recipient_date_created`;
create trigger `recipient_date_created` before insert
on `recipient`
for each row
set new.`created_date` = now();


-- Table Branch
drop table if exists `Branch`;
CREATE TABLE `Branch`
(
  `branch_id` Int NOT NULL AUTO_INCREMENT,
  `name` Varchar(25) NOT NULL,
  `phone_number` Varchar(25),
  `address_num_street` Varchar(55),
  `town_city` Varchar(20),
  PRIMARY KEY (`branch_id`)
)
;

-- Table Referral Reason
drop table if exists `Branch`;
CREATE TABLE `Referral Reason`
(
  `referral_reason_id` Int NOT NULL AUTO_INCREMENT,
  `content` Varchar(255) NOT NULL,
  PRIMARY KEY (`referral_reason_id`)
)
;

-- Table Dietary Requirement

CREATE TABLE `Dietary Requirement`
(
  `dietary_requirement_id` Int NOT NULL AUTO_INCREMENT,
  `dietary_name` Varchar(255) NOT NULL,
  PRIMARY KEY (`dietary_requirement_id`)
)
;

-- Table Referrer

CREATE TABLE `Referrer`
(
  `referrer_id` Int NOT NULL AUTO_INCREMENT,
  `first_name` Varchar(55) NOT NULL,
  `last_name` Varchar(55) NOT NULL,
  `organisation_name` Varchar(55),
  `phone_number` Varchar(25) NOT NULL,
  `email` Varchar(55),
  `town_city` Varchar(20),
  `ReferringAs` Int NOT NULL,
  PRIMARY KEY (`referrer_id`)
)
;

-- Table Referrer_role

CREATE TABLE `Referrer_role`
(
  `role_id` Int NOT NULL AUTO_INCREMENT,
  `role_name` Varchar(35) NOT NULL,
  PRIMARY KEY (`role_id`)
)
;

-- Table order

CREATE TABLE `order`
(
  `recipient_id` Int NOT NULL,
  `order_id` Int NOT NULL AUTO_INCREMENT
)
;

ALTER TABLE `order` ADD PRIMARY KEY (`recipient_id`,`order_id`)
;

-- Table Order

CREATE TABLE `Order`
(
  `order_id` Int NOT NULL AUTO_INCREMENT,
  `status` Tinyint NOT NULL,
  `delivery_man` Int NOT NULL,
  `recipient_id` Int NOT NULL,
  `created_datetime` Datetime,
  `assign_datetime` Datetime,
  `pickup_datetime` Datetime,
  `delivered_datetime` Datetime,
  `status_id` Tinyint NOT NULL,
  PRIMARY KEY (`order_id`,`status_id`,`recipient_id`)
)
;

-- Table order_status

CREATE TABLE `order_status`
(
  `status_id` Tinyint NOT NULL AUTO_INCREMENT,
  `content` Varchar(25) NOT NULL,
  PRIMARY KEY (`status_id`)
)
;

ALTER TABLE `order_status` ADD UNIQUE `content` (`content`)
;

-- Table Volunteer

CREATE TABLE `Volunteer`
(
  `volunteer_id` Int NOT NULL AUTO_INCREMENT,
  `first_name` Varchar(55) NOT NULL,
  `last_name` Varchar(5) NOT NULL,
  `DOB` Datetime NOT NULL,
  `email` Tinyint NOT NULL,
  `preferred_phone` Varchar(25) NOT NULL,
  `alternative_phone` Varchar(25) NOT NULL,
  `address` Varchar(55) NOT NULL,
  `town_city` Varchar(25) NOT NULL,
  `post_code` Varchar(10),
  `status_id` Tinyint NOT NULL,
  `branch_belonged` Int NOT NULL,
  `role_id` Int,
  PRIMARY KEY (`volunteer_id`)
)
;

-- Table Volunteer_police_info

CREATE TABLE `Volunteer_police_info`
(
  `volunteer_id` Int NOT NULL,
  `police_vet_date` Date NOT NULL,
  `police_vet_verified` Tinyint NOT NULL
)
;

ALTER TABLE `Volunteer_police_info` ADD PRIMARY KEY (`volunteer_id`)
;

-- Table volunteer_training_info

CREATE TABLE `volunteer_training_info`
(
  `volunteer_id` Int NOT NULL,
  `delivery_training` Tinyint NOT NULL,
  `other_training` Varchar(255),
  `H&S_training` Tinyint NOT NULL,
  `first_aid_raining` Tinyint NOT NULL
)
;

ALTER TABLE `volunteer_training_info` ADD PRIMARY KEY (`volunteer_id`)
;

-- Table volunteer_status

CREATE TABLE `volunteer_status`
(
  `status_id` Tinyint NOT NULL AUTO_INCREMENT,
  `content` Varchar(25) NOT NULL,
  PRIMARY KEY (`status_id`)
)
;

ALTER TABLE `volunteer_status` ADD UNIQUE `content` (`content`)
;

-- Table volunteer_emergency_contact

CREATE TABLE `volunteer_emergency_contact`
(
  `volunteer_id` Int NOT NULL,
  `first_name` Varchar(55) NOT NULL,
  `last_name` Varchar(55) NOT NULL,
  `phone_number` Varchar(25) NOT NULL,
  `relationship` Varchar(20) NOT NULL
)
;

ALTER TABLE `volunteer_emergency_contact` ADD PRIMARY KEY (`volunteer_id`)
;

-- Table volunteer_role

CREATE TABLE `volunteer_role`
(
  `role_id` Int NOT NULL AUTO_INCREMENT,
  `role_name` Varchar(35) NOT NULL,
  PRIMARY KEY (`role_id`)
)
;

-- Table Meal_instock

CREATE TABLE `Meal_instock`
(
  `meal_instock_id` Int NOT NULL,
  `meal_type` Varbinary(25) NOT NULL,
  `count` Int NOT NULL,
  `location` Varchar(25) NOT NULL
)
;

ALTER TABLE `Meal_instock` ADD PRIMARY KEY (`meal_instock_id`)
;

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE `Recipient` ADD CONSTRAINT `Recipient belones to a Branch` FOREIGN KEY (`nearest_branch`) REFERENCES `Branch` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE
;


ALTER TABLE `Recipient` ADD CONSTRAINT `Recipient has a Reason` FOREIGN KEY (`referral_reason`) REFERENCES `Referral Reason` (`referral_reason_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Recipient` ADD CONSTRAINT `Recipient has a requirement` FOREIGN KEY (`dietary_requirement`) REFERENCES `Dietary Requirement` (`dietary_requirement_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Recipient` ADD CONSTRAINT `Recipient has/not has a Referrer` FOREIGN KEY (`referrer_id`) REFERENCES `Referrer` (`referrer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Referrer` ADD CONSTRAINT `Referrer has/not has a role` FOREIGN KEY (`ReferringAs`) REFERENCES `Referrer_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `order` ADD CONSTRAINT `Relationship1` FOREIGN KEY (`recipient_id`) REFERENCES `Recipient` (`recipient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Order` ADD CONSTRAINT `Relationship2` FOREIGN KEY (`status_id`) REFERENCES `order_status` (`status_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Order` ADD CONSTRAINT `every order has a status` FOREIGN KEY (`status_id`) REFERENCES `order_status` (`status_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `volunteer_training_info` ADD CONSTRAINT `a voluteer has a train info` FOREIGN KEY (`volunteer_id`) REFERENCES `Volunteer` (`volunteer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Volunteer_police_info` ADD CONSTRAINT `a volunteer has a police info` FOREIGN KEY (`volunteer_id`) REFERENCES `Volunteer` (`volunteer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Volunteer` ADD CONSTRAINT `a volunteer belones to a branch` FOREIGN KEY (`branch_belonged`) REFERENCES `Branch` (`branch_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Volunteer` ADD CONSTRAINT `a volunteer has a status` FOREIGN KEY (`status_id`) REFERENCES `volunteer_status` (`status_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Order` ADD CONSTRAINT `an order has a recipient` FOREIGN KEY (`recipient_id`) REFERENCES `Recipient` (`recipient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `volunteer_emergency_contact` ADD CONSTRAINT `a volunteer has a emergency contact` FOREIGN KEY (`volunteer_id`) REFERENCES `Volunteer` (`volunteer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Volunteer` ADD CONSTRAINT `a volunteer has a role` FOREIGN KEY (`role_id`) REFERENCES `volunteer_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Order` ADD CONSTRAINT `an order can assign a volunteer as delivery man` FOREIGN KEY (`delivery_man`) REFERENCES `Volunteer` (`volunteer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;




