CREATE DATABASE library_db;
USE library_db;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50),
  password VARCHAR(50),
  role ENUM('admin','reader')
);

CREATE TABLE books (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  author VARCHAR(100),
  publisher VARCHAR(100),
  year INT,
  category VARCHAR(100),
  available INT DEFAULT 1
);

CREATE TABLE readers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  card_number VARCHAR(20),
  dob DATE,
  address VARCHAR(150),
  phone VARCHAR(15)
);

CREATE TABLE borrows (
  id INT AUTO_INCREMENT PRIMARY KEY,
  reader_id INT,
  book_id INT,
  borrow_date DATE,
  return_date DATE,
  status ENUM('Đang mượn','Đã trả'),
  FOREIGN KEY (reader_id) REFERENCES readers(id),
  FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO users VALUES (1,'admin','123','admin'),(2,'user1','123','reader');
