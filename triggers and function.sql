USE `gamedatabase`;

/* Function to Count Entities Created
Count the number of new entities (games, publishers, platforms, etc.) created by a user.
Increments points based on the type of entity created.*/

DELIMITER //
CREATE FUNCTION CountNewEntities(entityType VARCHAR(100))
RETURNS INT
BEGIN
    DECLARE points INT;
    SET points = 0;

    IF entityType = 'Game' THEN
        SET points = 10;
    ELSEIF entityType = 'Publisher' OR entityType = 'Platform' OR entityType = 'Genre' THEN
        SET points = 5;
    ELSE
        SET points = 1;
    END IF;

    RETURN points;
END //
DELIMITER ;

/* Function to Count Entities Deleted
Count the number of entities deleted by a user.
Increments points based on the type of entity deleted.*/

DELIMITER //
CREATE FUNCTION CountDeletedEntities(entityType VARCHAR(100))
RETURNS INT
BEGIN
    DECLARE points INT;
    SET points = 0;

    IF entityType = 'Game' THEN
        SET points = 10;
    ELSEIF entityType = 'Publisher' OR entityType = 'Platform' OR entityType = 'Genre' THEN
        SET points = 5;
    ELSE
        SET points = 1;
    END IF;

    RETURN points;
END //
DELIMITER ;

/* Trigger for Update in Any Table
Activates when an entity in any table is updated.
Calls the appropriate function to assign points based on the table. */

DELIMITER //

CREATE TRIGGER AfterAnyUpdate
AFTER UPDATE ON Game -- Replace with actual table name
FOR EACH ROW
BEGIN
    UPDATE UserPoints SET points = points + AddPointsForUpdate('Game') WHERE userId = NEW.creatorUserId;
END //

DELIMITER ;

