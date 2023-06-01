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
ALTER TABLE users MODIFY id_user INT(11) NOT NULL;

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
ALTER TABLE links MODIFY id_link INT(11) NOT NULL;


-- TRIGGER 
DROP TRIGGER IF EXISTS check_id_links_before_insert;

DELIMITER //
CREATE TRIGGER check_id_links_before_insert
BEFORE INSERT
ON db_links.links
FOR EACH ROW
BEGIN
	DECLARE max_id INT;
    DECLARE id_search INT;
	DECLARE cont INT;
	SET cont = 0;
    SET max_id = (SELECT MAX(id_link) FROM db_links.links);
    WHILE cont < max_id DO
        SET cont = cont + 1;
        SELECT COUNT(*) INTO id_search FROM db_links.links WHERE db_links.links.id_link = cont;
  		IF id_search = 0 THEN
        	SET NEW.id_link = cont;
            SET cont = max_id + 1;
        ELSE
        	SET NEW.id_link = max_id + 1;
        END IF;
    END WHILE;
    
    IF cont = 0 THEN
    	SET NEW.id_link = 1;
    END IF;
END// 
DELIMITER ;


-- PRUEBA
-- INSERT INTO links (title, url, description) VALUES ("TITULO", "link:http", "DESCRIP");
-- INSERT INTO links (id_link, title, url, description) VALUES (1, "TITULO", "link:http", "DESCRIP");

