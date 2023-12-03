CREATE DATABASE IF NOT EXISTS `gamedatabase`;
USE `gamedatabase`;

CREATE TABLE Language (
    language_name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Publisher (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL
);

CREATE TABLE Platform (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(255) NOT NULL
);

CREATE TABLE Genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE Game (
    game_id INT PRIMARY KEY,
    game_title VARCHAR(255) NOT NULL,
    release_date DATE,
    developer_name VARCHAR(255) NOT NULL,
    publisher_id INT NOT NULL,
    category VARCHAR(255) NOT NULL,
    genre_id INT NOT NULL,
    related_movies BOOLEAN,
    FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

-- Associative tables for many-to-many relationships
CREATE TABLE GameLanguage (
    game_id INT,
    language_name VARCHAR(100),
    PRIMARY KEY (game_id, language_name),
    FOREIGN KEY (game_id) REFERENCES Game(game_id),
    FOREIGN KEY (language_name) REFERENCES Language(language_name)
);

CREATE TABLE GamePlatform (
    game_id INT,
    platform_id INT,
    PRIMARY KEY (game_id, platform_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id),
    FOREIGN KEY (platform_id) REFERENCES Platform(platform_id)
);

CREATE TABLE PublisherPlatform (
    publisher_id INT,
    platform_id INT,
    PRIMARY KEY (publisher_id, platform_id),
    FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id),
    FOREIGN KEY (platform_id) REFERENCES Platform(platform_id)
);

-- Indexes (optional, for performance optimization)
CREATE INDEX idx_game_publisher ON Game(publisher_id);
CREATE INDEX idx_game_genre ON Game(genre_id);
CREATE INDEX idx_game_platform ON GamePlatform(platform_id);
CREATE INDEX idx_game_language ON GameLanguage(language_name);
