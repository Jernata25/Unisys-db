DELIMITER $$
CREATE OR REPLACE FUNCTION validate_order(
    _order TEXT
) RETURNS BOOLEAN
BEGIN
    RETURN _order IN ('ASC', 'DESC', 'asc', 'desc');
END;
$$
DELIMITER ;