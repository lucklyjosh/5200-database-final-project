CREATE DATABASE IF NOT EXISTS `gamedatabase`;
USE `gamedatabase`;


-- Publisher Table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL
);

-- Genre Table
CREATE TABLE genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

-- Category Table
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE game (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_title VARCHAR(255) NOT NULL,
    release_date DATE,
    developer_name VARCHAR(255) NOT NULL,
    publisher_id INT NOT NULL,
    category_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

-- Media Table
CREATE TABLE media (
    media_id INT AUTO_INCREMENT PRIMARY KEY,
    media_type VARCHAR(100) NOT NULL,
    media_name VARCHAR(100) NOT NULL
);

-- Operating System Table
CREATE TABLE operating_system (
    os_id INT AUTO_INCREMENT PRIMARY KEY,
    os_name VARCHAR(100) NOT NULL
);

-- Language Table
CREATE TABLE language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

-- Platform Table
CREATE TABLE platform (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(255) NOT NULL
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255),
    date_joined DATETIME,
    last_login DATETIME
);

CREATE TABLE review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Rating Table
CREATE TABLE rating (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    user_id INT NOT NULL,
    rating_value INT CHECK (rating_value BETWEEN 1 AND 5),
    rating_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- Associative Table for Game and Media (Optional Relationship)
CREATE TABLE GameMedia (
    game_id INT,
    media_id INT,
    PRIMARY KEY (game_id, media_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (media_id) REFERENCES media(media_id)
);

-- Associative Table for Game and Language
CREATE TABLE GameLanguage (
    game_id INT,
    language_id INT,
    PRIMARY KEY (game_id, language_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (language_id) REFERENCES language(language_id)
);

-- Associative Table for Game and Platform
CREATE TABLE GamePlatform (
    game_id INT,
    platform_id INT,
    PRIMARY KEY (game_id, platform_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (platform_id) REFERENCES platform(platform_id)
);

-- Associative Table for Publisher and Language
CREATE TABLE PublisherLanguage (
    publisher_id INT,
    language_id INT,
    PRIMARY KEY (publisher_id, language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES language(language_id)
);

-- Associative Table for Platform and Operating System
CREATE TABLE PlatformOperatingSystem (
    platform_id INT,
    os_id INT,
    PRIMARY KEY (platform_id, os_id),
    FOREIGN KEY (platform_id) REFERENCES platform(platform_id),
    FOREIGN KEY (os_id) REFERENCES operating_system(os_id)
);

-- Indexes (optional, for performance optimization)
CREATE INDEX idx_game_publisher ON game(publisher_id);
CREATE INDEX idx_game_genre ON game(genre_id);
CREATE INDEX idx_game_platform ON GamePlatform(platform_id);
CREATE INDEX idx_game_language ON GameLanguage(language_id);

