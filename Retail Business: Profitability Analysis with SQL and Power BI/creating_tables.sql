-- Creating tables

CREATE TABLE `orders` (
    `order_id` varchar(50)  NOT NULL ,
    `customer_id` varchar(50)  NOT NULL ,
    `postal_code` varchar(50)  NOT NULL ,
    `order_date` int  NOT NULL ,
    `ship_date` int  NOT NULL ,
    `delivery_duration` int  NOT NULL ,
    `ship_mode` varchar(100)  NOT NULL ,
    PRIMARY KEY (
        `order_id`
    )
);

CREATE TABLE `order_item` (
    `order_item_id` int  NOT NULL ,
    `order_id` varchar(50)  NOT NULL ,
    `product_id` varchar(100)  NOT NULL ,
    `sales` decimal  NOT NULL ,
    `quantity` int  NOT NULL ,
    `discount` decimal  NOT NULL ,
    `discount_value` decimal  NOT NULL ,
    `profit` decimal  NOT NULL ,
    `COGS` decimal  NOT NULL ,
    PRIMARY KEY (
        `order_item_id`
    )
);

CREATE TABLE `customer` (
    `customer_id` varchar(50)  NOT NULL ,
    `customer_name` varchar(50)  NOT NULL ,
    `segment` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `customer_id`
    )
);

CREATE TABLE `address` (
    `postal_code` varchar(50)  NOT NULL ,
    `city` varchar(100)  NOT NULL ,
    `state` varchar(50)  NOT NULL ,
    `region` varchar(50)  NOT NULL ,
    `country` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `postal_code`
    )
);

CREATE TABLE `product` (
    `product_id` varchar(100)  NOT NULL ,
    `category` varchar(100)  NOT NULL ,
    `sub_category` varchar(100)  NOT NULL ,
    PRIMARY KEY (
        `product_id`
    )
);

CREATE TABLE `returned` (
    `order_id` varchar(50)  NOT NULL ,
    `order_status` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `order_id`
    )
);

CREATE TABLE `shipping_cost` (
    `state` varchar(50)  NOT NULL ,
    `shipping_cost_per_unit` decimal  NOT NULL ,
    PRIMARY KEY (
        `state`
    )
);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customer` (`customer_id`);

ALTER TABLE `order_item` ADD CONSTRAINT `fk_order_item_order_id` FOREIGN KEY(`order_id`)
REFERENCES `orders` (`order_id`);

ALTER TABLE `order_item` ADD CONSTRAINT `fk_order_item_product_id` FOREIGN KEY(`product_id`)
REFERENCES `product` (`product_id`);

ALTER TABLE `address` ADD CONSTRAINT `fk_address_state` FOREIGN KEY(`state`)
REFERENCES `shipping_cost` (`state`);