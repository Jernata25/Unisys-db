DELIMITER $$
CREATE OR REPLACE PROCEDURE validate_order(
    _order TEXT
)
BEGIN
    SELECT _order IN ('ASC', 'DESC', 'asc', 'desc');
END;
$$
DELIMITER ;