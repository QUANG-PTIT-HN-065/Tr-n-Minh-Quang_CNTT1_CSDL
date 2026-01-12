DROP DATABASE IF EXISTS social_network;
CREATE DATABASE social_network;
USE social_network;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE friends (
    user_id INT,
    friend_id INT,
    status VARCHAR(20) CHECK (status IN ('pending','accepted')),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (friend_id) REFERENCES users(user_id)
);

CREATE TABLE likes (
    user_id INT,
    post_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);

INSERT INTO users(username,password,email) VALUES
('an','123','an@email.com'),
('binh','123','binh@email.com'),
('chi','123','chi@email.com');

CREATE VIEW vw_public_users AS
SELECT user_id, username, created_at FROM users;

CREATE INDEX idx_users_username ON users(username);

DELIMITER //

CREATE PROCEDURE sp_create_post(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE user_id = p_user_id) THEN
        INSERT INTO posts(user_id, content) VALUES (p_user_id, p_content);
    ELSE
        SELECT 'user not found' AS error;
    END IF;
END//

CREATE VIEW vw_recent_posts AS
SELECT * FROM posts
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY);

CREATE INDEX idx_posts_user ON posts(user_id);
CREATE INDEX idx_posts_user_time ON posts(user_id, created_at);

CREATE PROCEDURE sp_count_posts(
    IN p_user_id INT,
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total FROM posts WHERE user_id = p_user_id;
END//

CREATE VIEW vw_active_users AS
SELECT * FROM users WHERE user_id > 0
WITH CHECK OPTION;

CREATE PROCEDURE sp_add_friend(
    IN p_user_id INT,
    IN p_friend_id INT
)
BEGIN
    IF p_user_id = p_friend_id THEN
        SELECT 'invalid' AS error;
    ELSE
        INSERT INTO friends VALUES (p_user_id, p_friend_id, 'pending');
    END IF;
END//

CREATE PROCEDURE sp_suggest_friends(
    IN p_user_id INT,
    INOUT p_limit INT
)
BEGIN
    DECLARE cnt INT DEFAULT 0;
    WHILE cnt < p_limit DO
        SELECT user_id, username FROM users
        WHERE user_id <> p_user_id
        LIMIT p_limit;
        SET cnt = p_limit;
    END WHILE;
END//

CREATE INDEX idx_likes_post ON likes(post_id);

CREATE VIEW vw_top_posts AS
SELECT post_id, COUNT(*) AS total_likes
FROM likes
GROUP BY post_id
ORDER BY total_likes DESC
LIMIT 5;

CREATE PROCEDURE sp_add_comment(
    IN p_user_id INT,
    IN p_post_id INT,
    IN p_content TEXT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM users WHERE user_id = p_user_id) THEN
        SELECT 'user not found' AS error;
    ELSEIF NOT EXISTS (SELECT 1 FROM posts WHERE post_id = p_post_id) THEN
        SELECT 'post not found' AS error;
    ELSE
        INSERT INTO comments(user_id, post_id, content)
        VALUES (p_user_id, p_post_id, p_content);
    END IF;
END//

CREATE VIEW vw_post_comments AS
SELECT c.content, u.username, c.created_at
FROM comments c JOIN users u ON c.user_id = u.user_id;

CREATE PROCEDURE sp_like_post(
    IN p_user_id INT,
    IN p_post_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM likes WHERE user_id = p_user_id AND post_id = p_post_id) THEN
        SELECT 'already liked' AS error;
    ELSE
        INSERT INTO likes VALUES (p_user_id, p_post_id);
    END IF;
END//

CREATE VIEW vw_post_likes AS
SELECT post_id, COUNT(*) AS total_likes
FROM likes
GROUP BY post_id;

CREATE PROCEDURE sp_search_social(
    IN p_option INT,
    IN p_keyword VARCHAR(100)
)
BEGIN
    IF p_option = 1 THEN
        SELECT * FROM users WHERE username LIKE CONCAT('%', p_keyword, '%');
    ELSEIF p_option = 2 THEN
        SELECT * FROM posts WHERE content LIKE CONCAT('%', p_keyword, '%');
    ELSE
        SELECT 'invalid option' AS error;
    END IF;
END//

DELIMITER ;

CALL sp_search_social(1,'an');
CALL sp_search_social(2,'database');