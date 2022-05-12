CREATE DATABASE homework1;
USE homework1;

CREATE TABLE book(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title TEXT NOT NULL,
	release_year YEAR,
	image TEXT,
	id_company INT
);

CREATE TABLE category(
	id INT PRIMARY KEY NOT NULL,
	category_name TEXT,
	discription TEXT
);

CREATE TABLE company(
	id INT PRIMARY KEY NOT NULL,
	company_name TEXT,
	phone VARCHAR(13),
	email TEXT,
	fax VARCHAR(13),
	address TEXT
);

CREATE TABLE author(
	id INT PRIMARY KEY NOT NULL,
	author_name TEXT,
	birth DATE,
	country TEXT,
	gender ENUM('male', 'female')
);

CREATE TABLE book_category(
	id_book INT,
	id_category INT,
	PRIMARY KEY (id_book, id_category),
	FOREIGN KEY (id_book) REFERENCES book(id),
	FOREIGN KEY (id_category) REFERENCES category(id)
);

CREATE TABLE book_company(
	id_book INT,
	id_company INT,
	PRIMARY KEY (id_book, id_company),
	FOREIGN KEY (id_book) REFERENCES book(id),
	FOREIGN KEY (id_company) REFERENCES company(id)
);

CREATE TABLE book_author(
    id_book INT,
    id_author INT,
    PRIMARY KEY (id_book, id_author),
    FOREIGN KEY (id_book) REFERENCES author(id),
    FOREIGN KEY (id_author) REFERENCES author(id)
);