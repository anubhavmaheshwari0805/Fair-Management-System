CREATE DATABASE fairdb;
use fairdb;

CREATE TABLE Customer 
    (cust_id varchar(10),
    name varchar(20),
    age int,
    ph_no char(10),
    address varchar(50),
    primary key(cust_id));

CREATE TABLE Cust_family
    (m_id varchar(10) not null,
    name varchar(20),
    age int,
    ph_no char(10),
    cust_id varchar(10) not null,
    primary key(m_id),
    foreign key(cust_id) references Customer(cust_id) on delete cascade on update cascade);
   
CREATE TABLE Area
    (area_id varchar(10) not null,
    name varchar(20),
    primary key(area_id));

CREATE TABLE Healthcare_booths
    (hb_id varchar(10) not null,
    incharge_name varchar(20),
    area_id varchar(10) not null,
    primary key(hb_id),
    foreign key(area_id) references Area(area_id) on delete cascade on update cascade);

CREATE TABLE Police 
    (police_id varchar(10) not null,
    name varchar(20),    
    role varchar(20),
    area_id varchar(10) not null,
    primary key(police_id),
    foreign key(area_id) references Area(area_id) on delete cascade on update cascade);

CREATE TABLE Shops
    (shop_id varchar(10) not null,
    owner_name varchar(20),
    ph_no char(10),
    address varchar(50),
    shop_type varchar(20),
    area_id varchar(10) not null,
    primary key(shop_id),
    foreign key(area_id) references Area(area_id) on delete cascade on update cascade);

CREATE TABLE Health_visit_to
    (cust_id varchar(10) not null,
    hb_id varchar(10) not null,
    regdate date,
    regtime time,
    foreign key(cust_id) references Customer(cust_id) on delete cascade on update cascade,
    foreign key(hb_id) references Healthcare_booths(hb_id) on delete cascade on update cascade);

CREATE TABLE Security_visit_to
    (cust_id varchar(10) not null,
    police_id varchar(10) not null,
    regdate date,
    regtime time,
    foreign key(cust_id) references Customer(cust_id) on delete cascade on update cascade,
    foreign key(police_id) references Police(police_id) on delete cascade on update cascade);

CREATE TABLE Visits
    (cust_id varchar(10) not null,
    shop_id varchar(10) not null,
    regdate date,
    regtime time,
    foreign key(cust_id) references Customer(cust_id) on delete cascade on update cascade,
    foreign key(shop_id) references Shops(shop_id) on delete cascade on update cascade);

CREATE TABLE Managing_staff
    (staff_id varchar(10) not null,
    name varchar(20),
    ph_no char(10),
    specialized_for varchar(20),
    primary key(staff_id));

CREATE TABLE Manages
    (staff_id varchar(10) not null,
    area_id varchar(10) not null,
    foreign key(staff_id) references Managing_staff(staff_id) on delete cascade on update cascade,
    foreign key(area_id) references Area(area_id) on delete cascade on update cascade);
