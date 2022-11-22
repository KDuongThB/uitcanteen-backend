CREATE DATABASE UITCanteen;
USE uitcanteen;  

CREATE TABLE usr(  
    userId int NOT NULL AUTO_INCREMENT,  
    studentId int NOT NULL,  
    passwork varchar(64) NOT NULL,  
	email varchar(64) NOT NULL,
    firstName varchar(64) NOT NULL,
    lastName varchar(64) NOT NULL,
    mobile varchar(10) NOT NULL,
    creatAt datetime NOT NULL DEFAULT NOW(),
    updateAt datetime DEFAULT NOW(),
    primary key(userId)
);  

CREATE TABLE DISH_TYPE(
	dishTypeId int NOT NULL AUTO_INCREMENT,
    dishTypeName varchar(64) NOT NULL,
    primary key(dishTypeId)
);

CREATE TABLE DISH(  
    DishId int NOT NULL AUTO_INCREMENT,  
    dishTypeId int NOT NULL,
    dishName varchar(64) NOT NULL,  
    image varchar(512) NOT NULL,
    description text,
    updateAt datetime DEFAULT NOW(),
    quantity int NOT NULL,
    primary key(DishId),
    foreign key(dishTypeId) references DISH_TYPE(dishTypeId)	
);  

CREATE TABLE ORDER_STATUS(
	statusOrderId int NOT NULL AUTO_INCREMENT,
    statusOrderName varchar(64) NOT NULL,
    primary key(statusOrderId)
);

CREATE TABLE ORDR(
	orderId int NOT NULL AUTO_INCREMENT,
    updateAt datetime DEFAULT NOW(),
    userId int NOT NULL,
    statusOrderId int NOT NULL,
    primary key(orderId),
    foreign key(userId) references USR(userId),
    foreign key(statusOrderId) references ORDER_STATUS(statusOrderId)
);

CREATE TABLE ORDER_DETAIL(
	orderDetailId int NOT NULL AUTO_INCREMENT,
    dishId int NOT NULL,
    quantity int NOT NULL,
    orderId int NOT NULL,
    primary key(orderDetailId),
    foreign key(dishId) references DISH(dishId),
    foreign key(orderId) references ORDR(orderId)
);

CREATE TABLE PAYMENT(
	paymentId int NOT NULL AUTO_INCREMENT,
    paymentType varchar(64) NOT NULL,
    primary key(paymentId)
);

CREATE TABLE INVOICE(
	invoiceId int NOT NULL AUTO_INCREMENT,
    orderId int NOT NULL,
    userId int NOT NULL,
    total float NOT NULL,
    paymentId int NOT NULL,
    payAt datetime NOT NULL DEFAULT NOW(),
    primary key(invoiceId),
    foreign key(orderId) references ORDR(orderId),
    foreign key(userId) references USR(userId),
    foreign key(paymentId) references PAYMENT(paymentId)
);

CREATE TABLE INGREDIENT_TYPE(
	ingredientTypeId int NOT NULL AUTO_INCREMENT,
    ingredientTypeName varchar(64) NOT NULL,
    primary key(ingredientTypeId)
);

CREATE TABLE INGREDIENT(
	ingredientId int NOT NULL AUTO_INCREMENT,
    ingredientName varchar(64) NOT NULL,
    ingredientTypeId int NOT NULL,
    updateAt datetime NOT NULL DEFAULT NOW(),
    quantity int NOT NULL,
    primary key(ingredientId),
    foreign key(IngredientTypeId) references INGREDIENT_TYPE(IngredientTypeId)
);

Insert into ingredient_type(ingredientTypeName)
VALUE ('Tươi sống');
Insert into ingredient_type(ingredientTypeName)
VALUE ('Rau củ quả');
Insert into ingredient_type(ingredientTypeName)
VALUE ('Phụ gia');

INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity)
VALUES ('Thịt heo', 1, 5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Thịt bò',1,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Cá biển',1,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Thịt gà',1,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Trứng',1,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Bạch tuộc',1,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Chả cá',1,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Đậu hũ',1,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Khổ qua',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Cà rốt',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Bí đỏ',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Đậu cô ve',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Dưa chuột',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Khoai tây',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Susu',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Củ cải',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Rau muống',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Hành tây',2,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Ớt',3,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Sả',3,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Gừng',3,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Tỏi',3,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Hành khô',3,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Hành lá',3,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Nước mắm',3,5);
INSERT INTO INGREDIENT(ingredientName, ingredientTypeId, quantity) 
VALUES ('Tiêu',3,5);

INSERT INTO dish_type(dishTypeName)
VALUES ('Món chính');
INSERT INTO dish_type(dishTypeName)
VALUES ('Món phụ');

INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Thịt kho trứng','https://drive.google.com/file/d/153iOnbzc9rfiQAsGyEjolJ8KIv0-TPUk/view?usp=sharing',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Thịt gà kho sả ớt','https://drive.google.com/file/d/14VHsez5I6N-JvVLOjoxHmyuiJF8WkusC/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Cá lóc kho tộ','https://drive.google.com/file/d/14Y-UMUwG7Yx3VooC7zaIySlIhOkYlbmJ/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Thịt heo kho măng','https://drive.google.com/file/d/14Z6l54wpZ57IcZxQeMkn0nGc0TZ55QRW/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Thịt heo kho củ cải','https://drive.google.com/file/d/14aEYRLfPIe2IR69E_aJz-D5yf6ATF9y-/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Đậu hũ nhồi thịt','https://drive.google.com/file/d/14abxF6ENFgFo3SsXqygv-09B3S8i5V2b/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Chả cá sốt mắm tỏi','https://drive.google.com/file/d/14dIl6nGMl_t9ty7HfILQUNyBtH9Z3XWd/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Trứng chiên thịt','https://drive.google.com/file/d/14er4B97SHGy8nDIP1PkvR9gWpIIrmT2D/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Bạch tuộc xào sả ớt','https://drive.google.com/file/d/14f3W3PH1hjDDyQ2wn1IOXcgforZYyD4O/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Đậu hũ sả ớt','https://drive.google.com/file/d/14f_Mtmp_FIQhxdDJjd3ZjZDZUkzKkIpT/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Nem nướng','https://drive.google.com/file/d/14n33WXaQUCieqccSP9sX5Sul6rdyy2tJ/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Lòng gà xào thơm','https://drive.google.com/file/d/153zqu-ELKGJFDbmia7PErG-UX59QtnBj/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Cánh gà chiên nước mắm','https://drive.google.com/file/d/14kyQ3u0Nb6W7nFGkntYGVP_MHS-3V-hc/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Bò kho','https://drive.google.com/file/d/14r9E0nuWD2cwuMkDbuvq8GnTpvDtD4Je/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (1,'Thịt luộc cà pháo mắm tôm','https://drive.google.com/file/d/14rIjdpvmn9pEy-wldmRufQOaRkmUupvW/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (2,'Khổ qua xào trứng','https://drive.google.com/file/d/14tRNPru2lPcNpEEG1YYuggrhPyTsJXlM/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (2,'Đậu cô ve xào','https://drive.google.com/file/d/157esdCeb1P0uwygv4Kj-2o5dP6cEaipq/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (2,'Cà rốt xào trứng','https://drive.google.com/file/d/14uzBdmRNMW06j17VGOfTpTqRAaFde66k/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (2,'Khoai tây xào tỏi','https://drive.google.com/file/d/14xLJXotAb1Z8HY_EAYM9_jQR5BwsF5NX/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (2,'Su su xào','https://drive.google.com/file/d/150DRCC32ikdL2TWiva0yZ22TwW45yWsY/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (2,'Nộm dưa chuột','https://drive.google.com/file/d/151BHV7-B83NFdYdjXtjF7-ImizXOfGqz/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (2,'Bí đỏ xào tỏi','https://drive.google.com/file/d/151i0cVd5aalwpzYN2oBWWEljjV7huh_4/view?usp=share_link',30);
INSERT INTO dish(dishTypeId, dishName, image, quantity) 
VALUES (2,'Rau muống xào tỏi','https://drive.google.com/file/d/152mgFNQiKgWPMPQBRy2Nrqg0hNPDM1ap/view?usp=share_link',30);