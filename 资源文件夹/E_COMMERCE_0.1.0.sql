create database E_COMMERCE;
use E_COMMERCE;

/*--用户信息表--*/
create table User
(
	U_id int auto_increment not null primary key,
	U_account varchar(15) unique not null,
	U_password varchar(15) not null,
	U_picture varchar(100) not null,
	U_name varchar(20) not null,
	U_age int check(U_age between 1 and 150 ),
	U_sex varchar(10) check('男' or'女'),
	U_email varchar(25) not null,
	U_tel varchar(11)not null,
	U_address varchar(50) not null,
	U_registdate timestamp not null DEFAULT CURRENT_TIMESTAMP() 
);


/*--店铺信息表--*/
create table Shop
(
	S_id int auto_increment not null primary key,
	U_id int not null,
	S_name varchar(40) not null unique,
	S_introduce varchar(150) default'这个商家很懒，什么都没写',
	S_registdate timestamp not null DEFAULT CURRENT_TIMESTAMP(),
	S_shopstock int default 0,
	S_rank float default 0 check( S_rank between 0 and 5),
	S_picture varchar(150) not null,

	foreign key(U_id)references User(U_id)
);

/*--商品种类表--*/
create table Kind
(
	K_id int auto_increment not null primary key,
	K_name varchar(60) not null
);

/*--商品信息表--*/
create table Commodity
(
	C_id int auto_increment not null primary key,
	S_id int not null,
	K_id int not null,
	C_name varchar(50) not null,
	C_stock int check(C_stock>=0),
	C_introduce varchar(100) not null,
	C_picture varchar(100) not null,
	C_price float not null,
	C_discount float default 1 check(C_discount between 0 and 1),
	C_totalsales float default 0,
	C_state varchar(20) default'Y',/*Y表示商品正常销售 N表示已下架*/
	C_saledcount int default 0,
    
	foreign key(S_id)references Shop(S_id),
	foreign key (K_id)references Kind(K_id)
);


/*--购物车信息表--*/
create table ShopCart
(
	SC_id int not null auto_increment primary key,
	U_id int ,
	C_id int ,
	SC_price float not null,

	foreign key(U_id)references User(U_id),
	foreign key(C_id)references Commodity(C_id)
);

/*--交易信息记录表--*/
create table TransactionRecord
(
	TR_id int not null auto_increment primary key,
	U_id int ,
	C_id int,
	TR_name varchar(50) not null,
	TR_introduce varchar(100) not null,
	TR_picture varchar(100) not null,
	TR_price float not null,
	TR_num float not null, 
	TR_date  timestamp not null DEFAULT CURRENT_TIMESTAMP(),
    
	foreign key(U_id) references User(U_id),
	foreign key (C_id) references Commodity(C_id)
);

/*--管理员信息表--*/
create table Admin
(
	A_id int auto_increment not null primary key,
	A_account varchar(15) unique not null ,
	A_password varchar(15) not null,
	A_picture varchar(100) not null,
	A_name varchar(20) not null,
	A_age int check(U_age between 1 and 150 ),
	A_sex varchar(10) check('男' or'女'),
	A_email varchar(25) not null,
	A_tel varchar(11) not null,
	A_address varchar(50) not null
);

/*--收货地址--*/
create table DeliveryAddress
(
	D_id int auto_increment primary key,
    U_id int not null,
    D_adress varchar(50) not null,
    foreign key(U_id) references User(U_id)
)
