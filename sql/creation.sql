DROP DATABASE IF EXISTS bdplanta;

CREATE DATABASE IF NOT EXISTS bdplanta DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE bdplanta;

CREATE TABLE IF NOT EXISTS customer (
  id_customer INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(40) NOT NULL,
  type VARCHAR(20) NOT NULL,
  CONSTRAINT pk_customer PRIMARY KEY (id_customer)
);


CREATE TABLE IF NOT EXISTS user (
  rut VARCHAR(10) NOT NULL,
  name VARCHAR(40) NOT NULL,
  profile VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(100) NOT NULL,
  inspect BOOLEAN DEFAULT FALSE NOT NULL,
  CONSTRAINT pk_user PRIMARY KEY (rut)
);

CREATE TABLE IF NOT EXISTS price_list (
  id_price INT NOT NULL AUTO_INCREMENT,
  size VARCHAR(10) NOT NULL,
  price INT NOT NULL,
  guaranty INT NULL,
  CONSTRAINT pk_list_price PRIMARY KEY (id_price)
);

CREATE TABLE IF NOT EXISTS damage (
  cod_damage VARCHAR(5) NOT NULL,
  location VARCHAR(15) NOT NULL,
  type_damage VARCHAR(15) NOT NULL,
  CONSTRAINT pk_damage PRIMARY KEY (cod_damage)
);

CREATE TABLE IF NOT EXISTS tire (
  serial VARCHAR(10) NOT NULL,
  id_customer INT NOT NULL,
  brand VARCHAR(20) NOT NULL,
  design VARCHAR(10) NOT NULL,
  size VARCHAR(10) NOT NULL,
  type VARCHAR(10) NULL,
  no_int VARCHAR(10) NULL,
  position VARCHAR(10) NULL,
  state VARCHAR(20) NOT NULL,
  location VARCHAR(10) NULL,
  img_serial VARCHAR(100) NULL,
  verified BOOLEAN DEFAULT FALSE NOT NULL,
  CONSTRAINT pk_tire PRIMARY KEY (serial),
  CONSTRAINT fk_tire_customer FOREIGN KEY (id_customer) REFERENCES customer (id_customer)
);

CREATE TABLE IF NOT EXISTS transport (
  id_transport INT NOT NULL AUTO_INCREMENT,
  serial VARCHAR(10) NOT NULL,
  type VARCHAR(10) NOT NULL,
  no_dg VARCHAR(15) NULL,
  date DATE NULL,
  CONSTRAINT pk_transport PRIMARY KEY (id_transport),
  CONSTRAINT fk_transport_tire FOREIGN KEY (serial) REFERENCES tire (serial)
);

CREATE TABLE IF NOT EXISTS inspection (
  id_inspection INT NOT NULL AUTO_INCREMENT,
  rut_inspector VARCHAR(10) NOT NULL,
  serial VARCHAR(10) NOT NULL,
  date DATE NOT NULL,
  rt1 INT NULL,
  rt2 INT NULL,
  scrap_reason VARCHAR(100) NULL,
  CONSTRAINT pk_inspection PRIMARY KEY (id_inspection),
  CONSTRAINT fk_inspection_tire FOREIGN KEY (serial) REFERENCES tire (serial),
  CONSTRAINT fk_inspection_user FOREIGN KEY (rut_inspector) REFERENCES user (rut)
);

CREATE TABLE IF NOT EXISTS inspection_damage (
  id_damage INT NOT NULL AUTO_INCREMENT,
  id_inspection INT NOT NULL,
  cod_damage VARCHAR(5) NOT NULL,
  depth INT NULL,
  axial INT NULL,
  radial INT NULL,
  shoulder INT(2) NULL,
  observation VARCHAR(100) NULL,
  image VARCHAR(100) NULL,
  CONSTRAINT pk_inspection_damage PRIMARY KEY (id_damage),
  CONSTRAINT fk_inspection_damage_inspection FOREIGN KEY (id_inspection) REFERENCES inspection (id_inspection),
  CONSTRAINT fk_inspection_damage_damage FOREIGN KEY (cod_damage) REFERENCES damage (cod_damage)
);

CREATE TABLE IF NOT EXISTS quotation (
  id_quotation INT NOT NULL AUTO_INCREMENT,
  id_inspection INT NOT NULL,
  date DATE NOT NULL,
  total INT NOT NULL,
  CONSTRAINT pk_quotation PRIMARY KEY (id_quotation),
  CONSTRAINT fk_quotation_inspection FOREIGN KEY (id_inspection) REFERENCES inspection (id_inspection)
);

