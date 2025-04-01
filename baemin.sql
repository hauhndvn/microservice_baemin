-- -------------------------------------------------------------
-- TablePlus 6.4.2(600)
--
-- https://tableplus.com/
--
-- Database: baemin
-- Generation Time: 2025-03-31 17:22:51.7880
-- -------------------------------------------------------------


-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS banneritems_id_seq;

-- Table Definition
CREATE TABLE "public"."banneritems" (
    "id" int4 NOT NULL DEFAULT nextval('banneritems_id_seq'::regclass),
    "name" varchar(255) NOT NULL,
    "url" varchar(255) NOT NULL,
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS branch_branch_id_seq;

-- Table Definition
CREATE TABLE "public"."branch" (
    "branch_id" int4 NOT NULL DEFAULT nextval('branch_branch_id_seq'::regclass),
    "branch_name" varchar(255) NOT NULL,
    "address" varchar(700) NOT NULL,
    "area_classify" varchar(200) NOT NULL,
    "featured" bool NOT NULL,
    "thumbnail" varchar(255) NOT NULL,
    "eatery_id" int4 NOT NULL
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS category_category_id_seq;

-- Table Definition
CREATE TABLE "public"."category" (
    "category_id" int4 NOT NULL DEFAULT nextval('category_category_id_seq'::regclass),
    "category_name" varchar(255) NOT NULL,
    "description" varchar(1000) NOT NULL,
    "cat_thumbnail" varchar(255)
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."commentfood" (
    "food_id" int4 NOT NULL,
    "customer_id" int4 NOT NULL,
    "body" varchar(1000) NOT NULL,
    "star_evaluate" int2,
    PRIMARY KEY ("food_id","customer_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS customer_customer_id_seq;

-- Table Definition
CREATE TABLE "public"."customer" (
    "customer_id" int4 NOT NULL DEFAULT nextval('customer_customer_id_seq'::regclass),
    "email" varchar(255) NOT NULL,
    "password" varchar(255) NOT NULL,
    "phone" varchar(25) NOT NULL,
    "address" varchar(255) NOT NULL,
    "accountName" varchar(255) NOT NULL DEFAULT ''::character varying,
    "surname" varchar(255) NOT NULL DEFAULT ''::character varying,
    "name" varchar(255) NOT NULL DEFAULT ''::character varying,
    PRIMARY KEY ("customer_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS eatery_eatery_id_seq;

-- Table Definition
CREATE TABLE "public"."eatery" (
    "eatery_id" int4 NOT NULL DEFAULT nextval('eatery_eatery_id_seq'::regclass),
    "thumbnail" varchar(255) NOT NULL,
    "name" varchar(255) NOT NULL,
    "time_open" time NOT NULL,
    "time_close" time NOT NULL,
    "min_price" int4 NOT NULL,
    "max_price" int4 NOT NULL,
    "service_fee" float4 NOT NULL,
    "description" text,
    "address" varchar(500) NOT NULL DEFAULT 'Đang cập nhật'::character varying,
    PRIMARY KEY ("eatery_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS food_food_id_seq;

-- Table Definition
CREATE TABLE "public"."food" (
    "food_id" int4 NOT NULL DEFAULT nextval('food_food_id_seq'::regclass),
    "thumbnail" varchar(255) NOT NULL,
    "description" varchar(1000) NOT NULL,
    "name_food" varchar(255) NOT NULL,
    "price" int4 NOT NULL,
    "inventory" int4 NOT NULL,
    "featured" bool NOT NULL,
    "promotion" varchar(255) NOT NULL,
    "kind" varchar(100) NOT NULL,
    "eatery_id" int4 NOT NULL,
    "category_id" int4 NOT NULL,
    PRIMARY KEY ("food_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS logistics_logistics_id_seq;

-- Table Definition
CREATE TABLE "public"."logistics" (
    "logistics_id" int4 NOT NULL DEFAULT nextval('logistics_logistics_id_seq'::regclass),
    "order_id" int4 NOT NULL,
    "logistics_name" varchar(50) NOT NULL,
    "fee" int4 NOT NULL,
    "start_date" timestamp DEFAULT CURRENT_TIMESTAMP,
    "expected_end_date" timestamp,
    "surname" varchar(255) NOT NULL,
    "name" varchar(255) NOT NULL,
    "email" varchar(255) NOT NULL,
    "address" varchar(255) NOT NULL,
    "phone" varchar(25) NOT NULL,
    "total_payment" int4 NOT NULL,
    PRIMARY KEY ("logistics_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS orderfood_order_id_seq;

-- Table Definition
CREATE TABLE "public"."orderfood" (
    "order_id" int4 NOT NULL DEFAULT nextval('orderfood_order_id_seq'::regclass),
    "customer_id" int4 NOT NULL,
    "total_price" int4 NOT NULL,
    "statusOrder" int4 DEFAULT 1 CHECK ("statusOrder" = ANY (ARRAY[0, 1, 2])),
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("order_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS "orderItems_id_seq";

-- Table Definition
CREATE TABLE "public"."orderItems" (
    "id" int4 NOT NULL DEFAULT nextval('"orderItems_id_seq"'::regclass),
    "order_id" int4 NOT NULL,
    "food_id" int4 NOT NULL,
    "qty" int4 NOT NULL CHECK (qty > 0),
    "price" int4 NOT NULL CHECK (price > 0),
    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS shippingunit_shipping_id_seq;

-- Table Definition
CREATE TABLE "public"."shippingunit" (
    "shipping_id" int4 NOT NULL DEFAULT nextval('shippingunit_shipping_id_seq'::regclass),
    "shipping_name" varchar(255) NOT NULL,
    "fee_min" int4 NOT NULL CHECK ((fee_min >= 10000) AND (fee_min <= 50000)),
    "fee_max" int4 CHECK ((fee_max >= 30000) AND (fee_max <= 50000)),
    PRIMARY KEY ("shipping_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."statusorder" (
    "order_id" int4 NOT NULL,
    "state_ship1" varchar(255) NOT NULL,
    "status1" bool NOT NULL,
    "state_ship2" varchar(255) NOT NULL,
    "status2" bool NOT NULL,
    "state_ship3" varchar(255) NOT NULL,
    "status3" bool NOT NULL,
    "state_ship4" varchar(255) NOT NULL,
    "status4" bool NOT NULL,
    "state_ship5" varchar(255) NOT NULL,
    "status5" bool NOT NULL,
    "state_ship6" varchar(255) NOT NULL,
    "status6" bool NOT NULL,
    PRIMARY KEY ("order_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS voucher_voucher_id_seq;

-- Table Definition
CREATE TABLE "public"."voucher" (
    "voucher_id" int4 NOT NULL DEFAULT nextval('voucher_voucher_id_seq'::regclass),
    "food_id" int4 NOT NULL,
    "discount" numeric(3,2) NOT NULL CHECK ((discount >= (0)::numeric) AND (discount <= 1.0)),
    "duration_from" timestamp DEFAULT CURRENT_TIMESTAMP,
    "duration_to" timestamp,
    PRIMARY KEY ("voucher_id")
);

INSERT INTO "public"."banneritems" ("id", "name", "url") VALUES
(1, 'anh 1', '/images/map1.png'),
(2, 'anh 2', '/images/map2.png'),
(3, 'anh 3', '/images/map3.png'),
(4, 'anh 4', '/images/map4.png'),
(5, 'anh 5', '/images/map5.png'),
(6, 'anh 6', '/images/map6.png'),
(7, 'anh 7', '/images/map7.png'),
(8, 'anh 8', '/images/map8.png'),
(9, 'anh 9', '/images/map9.png'),
(10, 'anh 10', '/images/map10.png');

INSERT INTO "public"."branch" ("branch_id", "branch_name", "address", "area_classify", "featured", "thumbnail", "eatery_id") VALUES
(1, 'Chi nhánh 1', '123 Nguyễn Trãi, Quận 1', 'Quận 1', 't', '/images/branch1.png', 4),
(2, 'Chi nhánh 2', '456 Cách Mạng Tháng 8, Quận 3', 'Quận 3', 'f', '/images/branch2.png', 4),
(3, 'Chi nhánh 1', '789 Phạm Văn Đồng, Quận Thủ Đức', 'Thủ Đức', 't', '/images/branch3.png', 5),
(4, 'Chi nhánh 2', '321 Hoàng Văn Thụ, Quận Tân Bình', 'Tân Bình', 'f', '/images/branch4.png', 5),
(5, 'Chi nhánh 1', '567 Điện Biên Phủ, Quận Bình Thạnh', 'Bình Thạnh', 't', '/images/branch5.png', 6),
(6, 'Chi nhánh 2', '890 Võ Văn Kiệt, Quận 5', 'Quận 5', 'f', '/images/branch6.png', 6),
(7, 'Chi nhánh 3', '101 Hùng Vương, Quận 6', 'Quận 6', 'f', '/images/branch7.png', 6),
(8, 'Chi nhánh 1', '246 Lý Thường Kiệt, Quận 10', 'Quận 10', 't', '/images/branch8.png', 7),
(9, 'Chi nhánh 2', '369 Nguyễn Thị Minh Khai, Quận 1', 'Quận 1', 'f', '/images/branch9.png', 7),
(10, 'Chi nhánh 3', '159 Trần Não, Quận 2', 'Quận 2', 'f', '/images/branch1.png', 7),
(11, 'Chi nhánh 1', '753 Nguyễn Văn Cừ, Quận 5', 'Quận 5', 't', '/images/branch2.png', 8),
(12, 'Chi nhánh 1', '852 Lê Văn Sỹ, Quận 3', 'Quận 3', 't', '/images/branch3.png', 9),
(13, 'Chi nhánh 2', '951 Đường D2, Quận Bình Thạnh', 'Bình Thạnh', 'f', '/images/branch4.png', 9),
(14, 'Chi nhánh 1', '741 Âu Cơ, Quận Tân Phú', 'Tân Phú', 't', '/images/branch5.png', 10),
(15, 'Chi nhánh 2', '369 Trường Chinh, Quận 12', 'Quận 12', 'f', '/images/branch6.png', 10),
(16, 'Chi nhánh 3', '258 Nguyễn Tri Phương, Quận 10', 'Quận 10', 'f', '/images/branch7.png', 10),
(17, 'Chi nhánh 4', '147 Võ Văn Ngân, Quận Thủ Đức', 'Thủ Đức', 'f', '/images/branch8.png', 10),
(18, 'Chi nhánh 5', '369 Lê Quang Định, Quận Bình Thạnh', 'Bình Thạnh', 'f', '/images/branch9.png', 10);

INSERT INTO "public"."category" ("category_id", "category_name", "description", "cat_thumbnail") VALUES
(10, 'Mì phở', 'Các món mì, bún, phở đặc trưng của Việt Nam và quốc tế', '/images/noddle.png'),
(1, 'Vỉa hè', 'Các món ăn đường phố phổ biến và hấp dẫn', '/images/noddle.png'),
(2, 'Món lẩu', 'Các loại lẩu đa dạng từ truyền thống đến hiện đại', '/images/noddle.png'),
(3, 'Cơm hộp', 'Cơm phần tiện lợi, phù hợp cho dân văn phòng', '/images/noddle.png'),
(4, 'Đồ uống', 'Các loại đồ uống từ trà sữa, cà phê đến nước ép', '/images/noddle.png'),
(5, 'Đồ chay', 'Các món ăn chay từ rau củ và nguyên liệu tự nhiên', '/images/Ga.png'),
(6, 'Bánh kem', 'Các loại bánh kem, bánh ngọt cho các dịp đặc biệt', '/images/Ga.png'),
(7, 'Tráng miệng', 'Món ăn tráng miệng như chè, pudding, bánh flan', '/images/Ga.png'),
(8, 'Homemade', 'Món ăn tự làm tại nhà với nguyên liệu tự nhiên', '/images/Ga.png'),
(9, 'Sushi', 'Các loại sushi từ truyền thống Nhật Bản đến biến tấu hiện đại', '/images/Ga.png'),
(11, 'Đồ ăn', 'Danh mục chung cho các loại đồ ăn khác nhau', '/images/noddle.png'),
(12, 'Pizza', 'Pizza phong cách Ý với nhiều loại topping hấp dẫn', '/images/noddle.png'),
(13, 'Burger', 'Burger kiểu Mỹ với nhiều loại nhân phong phú', '/images/noddle.png'),
(14, 'Món gà', 'Các món ăn từ gà như gà rán, gà nướng, gà sốt', '/images/noddle.png');

INSERT INTO "public"."commentfood" ("food_id", "customer_id", "body", "star_evaluate") VALUES
(1, 1, 'Món ăn rất ngon, gỏi cuốn tươi và nước chấm đậm đà.', 5),
(2, 2, 'Phở bò có hương vị tuyệt vời, nước dùng đậm đà.', 4),
(3, 3, 'Chè bưởi thơm ngon nhưng hơi ngọt.', 3),
(4, 4, 'Bánh bèo rất mềm và ngon, topping vừa miệng.', 5),
(5, 5, 'Bún bò Huế cay nồng đúng vị miền Trung.', 4),
(6, 6, 'Rau câu dừa mát lạnh, rất thích.', 5),
(7, 7, 'Nem rán giòn, nhưng hơi nhiều dầu.', 3),
(8, 8, 'Cơm tấm sườn mềm, chả thơm ngon.', 5),
(9, 9, 'Bánh chuối nướng rất ngon, nước cốt dừa béo.', 4);

INSERT INTO "public"."customer" ("customer_id", "email", "password", "phone", "address", "accountName", "surname", "name") VALUES
(1, 'ndhhndvn@yahoo.com', 'password123', '0912345678', '12 Lý Tự Trọng, Quận 1', 'user1', 'Nguyễn', 'Văn A'),
(2, 'hauhndvn112@yahoo.com', 'password123', '0923456789', '45 Hai Bà Trưng, Quận 3', 'user2', 'Hoàng', 'Anh B'),
(3, 'haund112@yahoo.com.vn', 'password123', '0934567890', '78 Lê Văn Sỹ, Quận Phú Nhuận', 'user3', 'Trần', 'Quốc C'),
(4, 'vanhoa0685@yahoo.com.vn', 'password123', '0945678901', '123 Điện Biên Phủ, Quận Bình Thạnh', 'user4', 'Phạm', 'Hải D'),
(5, 'user5@example.com', 'password123', '0956789012', '234 Nguyễn Đình Chiểu, Quận 3', 'user5', 'Lê', 'Hồng E'),
(6, 'user6@example.com', 'password123', '0967890123', '56 Phạm Ngọc Thạch, Quận 1', 'user6', 'Vũ', 'Thái F'),
(7, 'user7@example.com', 'password123', '0978901234', '678 Trường Sa, Quận Phú Nhuận', 'user7', 'Đặng', 'Duy G'),
(8, 'user8@example.com', 'password123', '0989012345', '789 Hoàng Sa, Quận 3', 'user8', 'Bùi', 'Minh H'),
(9, 'user9@example.com', 'password123', '0990123456', '90 Lý Chính Thắng, Quận 3', 'user9', 'Đỗ', 'Ngọc I'),
(10, 'user10@example.com', 'password123', '0901234567', '102 Nguyễn Văn Trỗi, Quận Phú Nhuận', 'user10', 'Hồ', 'Thanh J'),
(11, 'hauhndvn11@gmail.com', '1234', '0983529988', '105 Quán Thánh, Ba Đình, Hà Nội', 'hau1', 'Nguyễn', 'Hậu K'),
(12, 'hauhndvn112@gmail.com', '1234', '0983526688', '105 Quán Thánh, Ba Đình, Hà Nội', 'hau2', 'Nguyễn', 'Hậu L'),
(13, 'ndhhndvn@gmail.com', '1234', '0704822374', '105 Quán Thánh, Ba Đình, Hà Nội', 'hieu1', 'Nguyễn', 'Hiếu'),
(14, 'hau.nguyenduc@gmail.com', '1234', '0986177364', '12 hẻm 38/15 đường Đại Cát, Liên Mạc, Bắc Từ Liêm, Hà Nội', 'thanh1', 'Trấn', 'Thành'),
(15, 'chiboTrungtamCNTT@protonmail.com', '1234', '0916752451', '9 Tôn Thất Thuyết, Nam Từ Liêm, Hà Nội', 'anh1', 'Lê Quỳnh', 'Anh'),
(16, 'hauhndvn@gmail.com', '1234', '0912985312', '2 Ngọc Hà, Ba Đình, Hà Nội', 'dai1', '', '');

INSERT INTO "public"."eatery" ("eatery_id", "thumbnail", "name", "time_open", "time_close", "min_price", "max_price", "service_fee", "description", "address") VALUES
(1, '/images/map1.png', 'Quán Ăn Ngon', '08:00:00', '22:00:00', 50000, 500000, 5, 'Nhà hàng nổi tiếng với các món ăn truyền thống Việt Nam.', '24 Nguyễn Huệ, Quận 1'),
(2, '/images/map2.png', 'Nhà hàng Gánh', '07:00:00', '21:30:00', 70000, 700000, 7.5, 'Phục vụ đặc sản miền Trung với không gian hoài cổ.', '16 Lê Lợi, Quận 3'),
(3, '/images/map3.png', 'Bếp Nhà', '09:00:00', '20:00:00', 60000, 600000, 6, 'Không gian ấm cúng, món ăn mang hương vị gia đình.', '19 Hoàng Sa, Quận Phú Nhuận'),
(4, '/images/map4.png', 'Nhà hàng Sài Gòn', '10:00:00', '23:00:00', 80000, 1000000, 10, 'Không gian sang trọng, phục vụ ẩm thực Á - Âu.', '123 Nguyễn Trãi, Quận 1'),
(5, '/images/map1.png', 'Ẩm Thực Quê Hương', '06:30:00', '21:00:00', 40000, 400000, 4, 'Chuyên các món ăn dân dã, đặc sản ba miền.', '789 Phạm Văn Đồng, Quận Thủ Đức'),
(6, '/images/map2.png', 'BBQ Garden', '17:00:00', '00:00:00', 150000, 900000, 12, 'Lẩu nướng không khói, không gian ngoài trời thoáng đãng.', '567 Điện Biên Phủ, Quận Bình Thạnh'),
(7, '/images/map3.png', 'Nhà hàng Biển Đông', '09:00:00', '22:30:00', 100000, 800000, 9, 'Chuyên hải sản tươi sống, chế biến theo yêu cầu.', '246 Lý Thường Kiệt, Quận 10'),
(8, '/images/map4.png', 'Pizza & Pasta', '10:00:00', '22:00:00', 120000, 700000, 8, 'Thực đơn phong phú với các món Ý truyền thống.', '753 Nguyễn Văn Cừ, Quận 5'),
(9, '/images/map1.png', 'Nhà hàng Chay Sen', '07:00:00', '21:00:00', 50000, 600000, 6, 'Không gian yên tĩnh, thực đơn thuần chay tốt cho sức khỏe.', '852 Lê Văn Sỹ, Quận 3'),
(10, '/images/map2.png', 'Lẩu Thái Sài Gòn', '11:00:00', '23:30:00', 90000, 750000, 7, 'Chuyên các món lẩu chua cay, đậm đà hương vị Thái.', '741 Âu Cơ, Quận Tân Phú');

INSERT INTO "public"."food" ("food_id", "thumbnail", "description", "name_food", "price", "inventory", "featured", "promotion", "kind", "eatery_id", "category_id") VALUES
(1, '/food/ga1.jpg', 'Gỏi cuốn tôm thịt, chấm nước mắm chua ngọt.', 'Gỏi cuốn', 100000, 9, 't', 'Giảm 10%', 'Khai vị', 1, 11),
(2, '/food/lau1.jpg', 'Phở bò tái nạm thơm ngon, nước dùng đậm đà.', 'Phở bò', 150000, 5, 'f', 'Giảm 15%', 'Món chính', 1, 10),
(3, '/food/ga1.jpg', 'Chè bưởi giòn ngon, nước cốt dừa béo ngậy.', 'Chè bưởi', 120000, 5, 't', 'Giảm 5%', 'Tráng miệng', 1, 7),
(4, '/food/lau1.jpg', 'Bánh bèo chén, rắc tôm cháy, mỡ hành.', 'Bánh bèo', 200000, 9, 'f', 'Giảm 20%', 'Khai vị', 2, 11),
(5, '/food/ga1.jpg', 'Bún bò Huế cay nồng, đầy đủ thịt bò và chả cua.', 'Bún bò Huế', 180000, 6, 't', 'Giảm 25%', 'Món chính', 2, 10),
(6, '/food/lau1.jpg', 'Rau câu dừa mát lạnh, thích hợp tráng miệng.', 'Rau câu dừa', 130000, 5, 'f', 'Giảm 30%', 'Tráng miệng', 2, 7),
(7, '/food/ga1.jpg', 'Nem rán giòn rụm, nhân thịt băm và miến.', 'Nem rán', 140000, 4, 't', 'Giảm 10%', 'Khai vị', 3, 11),
(8, '/food/lau1.jpg', 'Cơm tấm sườn bì chả, nước mắm pha đậm đà.', 'Cơm tấm', 160000, 3, 'f', 'Giảm 15%', 'Món chính', 3, 11),
(9, '/food/ga1.jpg', 'Bánh chuối nướng, chan nước cốt dừa.', 'Bánh chuối nướng', 110000, 9, 't', 'Giảm 5%', 'Tráng miệng', 3, 5),
(10, '/food/bo1.jpg', 'Bò kho thơm lừng, ăn kèm bánh mì giòn rụm.', 'Bò kho', 220000, 8, 't', 'Giảm 10%', 'Món chính', 1, 11),
(11, '/food/cha1.jpg', 'Chả giò giòn tan, nhân thịt heo băm và miến.', 'Chả giò', 90000, 7, 'f', 'Giảm 5%', 'Khai vị', 2, 11),
(12, '/food/bo1.jpg', 'Lẩu Thái chua cay, hải sản tươi ngon.', 'Lẩu Thái', 280000, 6, 't', 'Giảm 15%', 'Món chính', 3, 11),
(13, '/food/cha1.jpg', 'Bánh xèo vàng giòn, nhân tôm thịt.', 'Bánh xèo', 180000, 5, 'f', 'Giảm 10%', 'Khai vị', 1, 11),
(14, '/food/bo1.jpg', 'Bún thịt nướng thơm ngon, mỡ hành béo ngậy.', 'Bún thịt nướng', 160000, 4, 't', 'Giảm 20%', 'Món chính', 2, 10),
(15, '/food/cha1.jpg', 'Bánh tráng trộn ngon khó cưỡng, đầy đủ topping.', 'Bánh tráng trộn', 70000, 3, 'f', 'Giảm 5%', 'Khai vị', 3, 11),
(16, '/food/bo1.jpg', 'Cơm cháy giòn rụm, chà bông đậm đà.', 'Cơm cháy chà bông', 120000, 9, 't', 'Giảm 10%', 'Món chính', 1, 11),
(17, '/food/cha1.jpg', 'Sữa chua nếp cẩm thơm ngon, mát lạnh.', 'Sữa chua nếp cẩm', 80000, 8, 'f', 'Giảm 15%', 'Tráng miệng', 2, 7),
(18, '/food/bo1.jpg', 'Bánh bao nhân thịt trứng muối hấp dẫn.', 'Bánh bao trứng muối', 110000, 7, 't', 'Giảm 5%', 'Khai vị', 3, 11),
(19, '/food/cha1.jpg', 'Chè Thái với sầu riêng thơm ngon, béo ngậy.', 'Chè Thái', 100000, 10, 'f', 'Giảm 10%', 'Tráng miệng', 1, 7);

INSERT INTO "public"."logistics" ("logistics_id", "order_id", "logistics_name", "fee", "start_date", "expected_end_date", "surname", "name", "email", "address", "phone", "total_payment") VALUES
(1, 1, 'Grab', 30000, '2025-03-28 10:30:00', '2025-03-28 12:30:00', 'Nguyễn', 'Văn A', 'ndhhndvn@yahoo.com', '12 Lý Tự Trọng, Quận 1', '0912345678', 100000),
(2, 2, 'Ahamove', 35000, '2025-02-27 10:35:00', '2025-02-27 12:35:00', 'Hoàng', 'Anh B', 'hauhndvn112@yahoo.com', '45 Hai Bà Trưng, Quận 3', '0923456789', 100000),
(3, 3, 'GoViet', 25000, '2025-02-28 10:30:00', '2025-02-28 12:30:00', 'Trần', 'Quốc C', 'haund112@yahoo.com.vn', '78 Lê Văn Sỹ, Quận Phú Nhuận', '0934567890', 100000),
(4, 4, 'Bee', 20000, '2025-02-28 10:35:00', '2025-02-28 12:35:00', 'Phạm', 'Hải D', 'vanhoa0685@yahoo.com.vn', '123 Điện Biên Phủ, Quận Bình Thạnh', '0945678901', 100000),
(5, 5, 'ShopeeFood', 30000, '2025-02-27 10:30:00', '2025-02-27 12:30:00', 'Lê', 'Hồng E', 'user5@example.com', '234 Nguyễn Đình Chiểu, Quận 3', '0956789012', 100000),
(6, 6, 'Lalamove', 35000, '2025-02-28 10:35:00', '2025-02-28 12:35:00', 'Vũ', 'Thái F', 'user6@example.com', '56 Phạm Ngọc Thạch, Quận 1', '0967890123', 100000),
(7, 7, 'Baemin', 25000, '2025-02-27 10:30:00', '2025-02-27 12:30:00', 'Đặng', 'Duy G', 'user7@example.com', '678 Trường Sa, Quận Phú Nhuận', '0978901234', 100000),
(8, 8, 'Now', 30000, '2025-02-28 10:35:00', '2025-02-28 12:35:00', 'Bùi', 'Minh H', 'user8@example.com', '789 Hoàng Sa, Quận 3', '0989012345', 100000),
(9, 9, 'ShopeeFood', 20000, '2025-02-27 10:30:00', '2025-02-27 12:30:00', 'Đỗ', 'Ngọc I', 'user9@example.com', '90 Lý Chính Thắng, Quận 3', '0990123456', 100000),
(10, 10, 'Ahamove', 25000, '2025-02-28 10:35:00', '2025-02-28 12:35:00', 'Hồ', 'Thanh J', 'user10@example.com', '102 Nguyễn Văn Trỗi, Quận Phú Nhuận', '0901234567', 100000),
(11, 17, 'GoViet', 25000, '2025-03-30 09:31:56.124', '2025-03-30 09:31:56.124', 'Phạm', 'Hải D', 'vanhoa0685@yahoo.com.vn', '123 Điện Biên Phủ, Quận Bình Thạnh', '0945678901', 335000),
(12, 18, 'Bee', 20000, '2025-03-30 10:15:29.101', '2025-03-30 10:15:29.101', 'Lê', 'Hồng E', 'user5@example.com', '234 Nguyễn Đình Chiểu, Quận 3', '0956789012', 335000),
(13, 19, 'Bee', 20000, '2025-03-30 10:20:31.903', '2025-03-30 10:20:31.903', 'Vũ', 'Thái F', 'user6@example.com', '56 Phạm Ngọc Thạch, Quận 1', '0967890123', 470000),
(14, 20, 'Bee', 20000, '2025-03-30 10:31:18.637', '2025-03-30 12:31:18.637', 'Đặng', 'Duy G', 'user7@example.com', '678 Trường Sa, Quận Phú Nhuận', '0978901234', 470000);

INSERT INTO "public"."orderfood" ("order_id", "customer_id", "total_price", "statusOrder", "created_at") VALUES
(1, 1, 250000, 1, '2025-03-29 15:01:11.91149'),
(2, 2, 400000, 1, '2025-03-29 15:01:11.91149'),
(3, 3, 320000, 1, '2025-03-29 15:01:11.91149'),
(4, 4, 150000, 1, '2025-03-29 15:01:11.91149'),
(5, 5, 220000, 1, '2025-03-29 15:01:11.91149'),
(6, 6, 260000, 1, '2025-03-29 15:01:11.91149'),
(7, 7, 280000, 1, '2025-03-29 15:01:11.91149'),
(8, 8, 340000, 1, '2025-03-29 15:01:11.91149'),
(9, 9, 150000, 1, '2025-03-29 15:01:11.91149'),
(10, 10, 120000, 1, '2025-03-29 15:01:11.91149'),
(12, 1, 40000, 1, '2025-03-30 07:35:00'),
(13, 2, 66000, 1, '2025-03-29 06:35:00'),
(14, 3, 230000, 1, '2025-03-29 06:35:00'),
(15, 4, 230000, 1, '2025-03-29 06:35:00'),
(16, 4, 230000, 1, '2025-03-29 06:35:00'),
(17, 4, 350000, 1, '2025-03-29 06:35:00'),
(18, 5, 350000, 1, '2025-03-30 10:15:29.029'),
(19, 6, 350000, 1, '2025-03-30 10:20:31.859'),
(20, 7, 350000, 1, '2025-03-30 10:31:18.602');

INSERT INTO "public"."orderItems" ("id", "order_id", "food_id", "qty", "price") VALUES
(1, 12, 1, 1, 100000),
(2, 12, 2, 2, 150000),
(3, 13, 3, 3, 120000),
(4, 13, 2, 2, 150000),
(5, 14, 4, 1, 200000),
(6, 14, 2, 2, 150000),
(7, 15, 2, 2, 15000),
(9, 16, 4, 1, 200000),
(10, 16, 2, 2, 135000),
(11, 17, 2, 2, 135000),
(12, 17, 4, 1, 200000),
(13, 18, 4, 1, 200000),
(14, 18, 2, 2, 135000),
(15, 19, 4, 1, 200000),
(16, 19, 2, 2, 270000),
(17, 20, 4, 1, 200000),
(18, 20, 2, 2, 270000);

INSERT INTO "public"."shippingunit" ("shipping_id", "shipping_name", "fee_min", "fee_max") VALUES
(1, 'Grab', 10000, 45000),
(2, 'Ahamove', 12000, 50000),
(3, 'GoViet', 11000, 40000),
(4, 'Bee', 12000, 45000),
(5, 'ShopeeFood', 10000, 45000),
(6, 'Lalamove', 15000, 50000),
(7, 'Baemin', 11000, 40000),
(8, 'Now', 10000, 45000);

INSERT INTO "public"."statusorder" ("order_id", "state_ship1", "status1", "state_ship2", "status2", "state_ship3", "status3", "state_ship4", "status4", "state_ship5", "status5", "state_ship6", "status6") VALUES
(1, 'Nhà hàng đã nhận đơn', 't', 'Shipper đã nhận đơn', 't', 'Shipper đang đến nhà hàng', 't', 'Shipper đã đến nhà hàng', 't', 'Shipper đang giao hàng', 't', 'Đơn hàng hoàn tất', 'f'),
(2, 'Nhà hàng đã nhận đơn', 't', 'Shipper đã nhận đơn', 't', 'Shipper đang đến nhà hàng', 't', 'Shipper đã đến nhà hàng', 'f', 'Shipper đang giao hàng', 'f', 'Đơn hàng hoàn tất', 'f'),
(3, 'Nhà hàng đã nhận đơn', 't', 'Shipper đã nhận đơn', 't', 'Shipper đang đến nhà hàng', 't', 'Shipper đã đến nhà hàng', 't', 'Shipper đang giao hàng', 'f', 'Đơn hàng hoàn tất', 'f'),
(4, 'Nhà hàng đã nhận đơn', 't', 'Shipper đã nhận đơn', 't', 'Shipper đang đến nhà hàng', 'f', 'Shipper đã đến nhà hàng', 'f', 'Shipper đang giao hàng', 'f', 'Đơn hàng hoàn tất', 'f');

INSERT INTO "public"."voucher" ("voucher_id", "food_id", "discount", "duration_from", "duration_to") VALUES
(1, 1, 0.10, '2025-03-28 10:35:00', '2025-03-28 12:35:00'),
(2, 4, 0.20, '2025-03-29 11:00:00', '2025-03-29 13:00:00'),
(3, 5, 0.25, '2025-03-29 10:30:00', '2025-03-29 12:30:00'),
(4, 6, 0.30, '2025-03-30 09:45:00', '2025-03-30 11:45:00'),
(5, 7, 0.10, '2025-03-31 10:45:00', '2025-03-31 12:45:00');

ALTER TABLE "public"."branch" ADD FOREIGN KEY ("eatery_id") REFERENCES "public"."eatery"("eatery_id") ON DELETE CASCADE;


-- Indices
CREATE UNIQUE INDEX branch_branch_id_key ON public.branch USING btree (branch_id);


-- Indices
CREATE UNIQUE INDEX category_category_id_key ON public.category USING btree (category_id);
ALTER TABLE "public"."commentfood" ADD FOREIGN KEY ("customer_id") REFERENCES "public"."customer"("customer_id") ON DELETE CASCADE;
ALTER TABLE "public"."commentfood" ADD FOREIGN KEY ("food_id") REFERENCES "public"."food"("food_id") ON DELETE CASCADE;
ALTER TABLE "public"."food" ADD FOREIGN KEY ("eatery_id") REFERENCES "public"."eatery"("eatery_id") ON DELETE CASCADE;
ALTER TABLE "public"."food" ADD FOREIGN KEY ("category_id") REFERENCES "public"."category"("category_id") ON DELETE CASCADE;
ALTER TABLE "public"."logistics" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orderfood"("order_id") ON DELETE CASCADE;
ALTER TABLE "public"."orderfood" ADD FOREIGN KEY ("customer_id") REFERENCES "public"."customer"("customer_id") ON DELETE CASCADE;
ALTER TABLE "public"."orderItems" ADD FOREIGN KEY ("food_id") REFERENCES "public"."food"("food_id") ON DELETE CASCADE;
ALTER TABLE "public"."orderItems" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orderfood"("order_id") ON DELETE CASCADE;
ALTER TABLE "public"."statusorder" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orderfood"("order_id") ON DELETE CASCADE;
ALTER TABLE "public"."voucher" ADD FOREIGN KEY ("food_id") REFERENCES "public"."food"("food_id") ON DELETE CASCADE;
