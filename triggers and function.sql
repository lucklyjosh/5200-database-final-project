USE gamedatabase;

--  Insert New Game with Associated Info
DELIMITER //
CREATE PROCEDURE AddNewGame(IN title VARCHAR(255), IN releaseDate DATE, IN developer VARCHAR(255), IN publisherId INT, IN genreId INT, IN categoryId INT)
BEGIN
    INSERT INTO game (game_title, release_date, developer_name, publisher_id, genre_id, category_id) 
    VALUES (title, releaseDate, developer, publisherId, genreId, categoryId);
    -- Additional logic for inserting into other associated tables can be added here.
END //
DELIMITER ;

-- Update Game Information
DELIMITER //
CREATE PROCEDURE UpdateGameInfo(IN gameId INT, IN newTitle VARCHAR(255), IN newReleaseDate DATE, IN newDeveloper VARCHAR(255))
BEGIN
    UPDATE game 
    SET game_title = newTitle, release_date = newReleaseDate, developer_name = newDeveloper 
    WHERE game_id = gameId;
END //
DELIMITER ;

-- Delete Game from Personal Collection
DELIMITER //
CREATE PROCEDURE DeleteGameFromCollection(IN userId INT, IN gameId INT)
BEGIN
    DELETE FROM user_game_collection 
    WHERE user_id = userId AND game_id = gameId;
END //
DELIMITER ;

-- Select One Genre and Return All Games
DELIMITER //
CREATE PROCEDURE GetGamesByGenre(IN genreName VARCHAR(255))
BEGIN
    SELECT g.game_title
    FROM game g
    JOIN genre ge ON g.genre_id = ge.genre_id
    WHERE ge.genre_name = genreName;
END //
DELIMITER ;

-- Insert New Rating and Review for Game
DELIMITER //
CREATE PROCEDURE AddReviewAndRating(IN userId INT, IN gameId INT, IN rating INT, IN reviewText TEXT)
BEGIN
    INSERT INTO review (game_id, user_id, rating, review_text)
    VALUES (gameId, userId, rating, reviewText);
END //
DELIMITER ;

-- Update Rating and Review
DELIMITER //
CREATE PROCEDURE UpdateReviewAndRating(IN reviewId INT, IN newRating INT, IN newReviewText TEXT)
BEGIN
    UPDATE review 
    SET rating = newRating, review_text = newReviewText 
    WHERE review_id = reviewId;
END //
DELIMITER ;

-- Delete Review and Rating
DELIMITER //
CREATE PROCEDURE DeleteReviewAndRating(IN reviewId INT)
BEGIN
    DELETE FROM review 
    WHERE review_id = reviewId;
END //
DELIMITER ;

USE gamedatabase;
-- Order All Games by Rating
DELIMITER //
CREATE FUNCTION GetAverageRatingForGame(gameTitle VARCHAR(255))
RETURNS DECIMAL(5, 2)
DETERMINISTIC
BEGIN
    DECLARE avgRating DECIMAL(5, 2);
    
    SELECT AVG(r.rating) INTO avgRating
    FROM game g
    LEFT JOIN review r ON g.game_id = r.game_id
    WHERE g.game_title = gameTitle;
    
    RETURN avgRating;
END //
DELIMITER ;










