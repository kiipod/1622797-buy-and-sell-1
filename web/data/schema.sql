CREATE DATABASE buyandsell CHARACTER SET utf8 COLLATE utf8_general_ci;
USE buyandsell;

/* Таблица пользователей */
CREATE TABLE users (
  id int AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(64) NOT NULL UNIQUE,
  password VARCHAR(64)  NOT NULL,
  avatarSrc VARCHAR(255) NULL,
  vkId int,
  admin BOOLEAN NULL
);

/* Таблица типа товаров */
CREATE TABLE adTypes (
  id int AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL
);

/* Таблица категорий объявлений */
CREATE TABLE adCategories (
  id int AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL
);

/* Таблица объявлений */
CREATE TABLE ads (
  id int AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price int NOT NULL,
  imageSrc VARCHAR(255) NOT NULL,
  typeId int NOT NULL,
  description TEXT NOT NULL,
  author int NOT NULL,
  dateCreation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (typeId) REFERENCES adTypes (id),
  FOREIGN KEY (author) REFERENCES users (id)
);

/* Таблица категорий объявлений */
CREATE TABLE adsToCategories (
  id int AUTO_INCREMENT PRIMARY KEY,
  adsId int NOT NULL,
  categoryId int NOT NULL,
  FOREIGN KEY (adsId) REFERENCES ads (id),
  FOREIGN KEY (categoryId) REFERENCES adCategories (id),
);

/* Таблица с комментариями к товару */
CREATE TABLE comments (
  id int AUTO_INCREMENT PRIMARY KEY,
  author int NOT NULL,
  adId int NOT NULL,
  text TEXT NOT NULL,
  dateCreation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (author) REFERENCES users (id),
  FOREIGN KEY (adId) REFERENCES ads (id)
);

/* Создаем индекс для полнотекстового поиска */
CREATE FULLTEXT INDEX ads_ft_search ON ads(name, description);
