CREATE DATABASE db_links;
USE db_links;

-- TABLE USERS
CREATE TABLE users(
	id_user INT(11) NOT NULL,
	username VARCHAR(16) NOT NULL,
	pass VARCHAR(60) NOT NULL,
	fullname VARCHAR(100) NOT NULL
);

ALTER TABLE users ADD PRIMARY KEY(id_user);
ALTER TABLE users MODIFY id_user INT(11) NOT NULL AUTO_INCREMENT;

DESCRIBE users;

-- TABLE LINKS
CREATE TABLE links(
	id_link INT(11) NOT NULL,
	title VARCHAR(150) NOT NULL,
	url VARCHAR(255) NOT NULL,
	description VARCHAR(255),
	user_id INT(11),
	created_at timestamp NOT NULL DEFAULT current_timestamp,
	CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id_user)
);

ALTER TABLE links ADD PRIMARY KEY(id_link);
ALTER TABLE links MODIFY id_link INT(11) NOT NULL AUTO_INCREMENT;
