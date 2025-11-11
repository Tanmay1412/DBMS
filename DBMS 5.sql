CREATE DATABASE IF NOT EXISTS college_db;
USE college_db;

DROP TABLE IF EXISTS O_Roll_Call;
DROP TABLE IF EXISTS N_Roll_Call;

CREATE TABLE O_Roll_Call (
  Roll_No INT PRIMARY KEY,
  Name VARCHAR(100),
  Class VARCHAR(50)
);

CREATE TABLE N_Roll_Call (
  Roll_No INT PRIMARY KEY,
  Name VARCHAR(100),
  Class VARCHAR(50)
);

INSERT INTO N_Roll_Call VALUES 
(1, 'Riya Kulkarni', 'A'),
(2, 'Aditya Deshmukh', 'B'),
(3, 'Sneha Patil', 'A'),
(4, 'Manav Joshi', 'C');

INSERT INTO O_Roll_Call VALUES 
(5, 'Karan Shah', 'C');

DELIMITER $$;

CREATE PROCEDURE IF NOT EXISTS merge_roll_call()
BEGIN
  DECLARE v_roll INT;
  DECLARE v_name VARCHAR(100);
  DECLARE v_class VARCHAR(50);
  DECLARE v_exists INT DEFAULT 0;
  DECLARE done INT DEFAULT FALSE;
  DECLARE cur CURSOR FOR 
    SELECT Roll_No, Name, Class FROM N_Roll_Call;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_roll, v_name, v_class;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT COUNT(*) INTO v_exists 
    FROM O_Roll_Call 
    WHERE Roll_No = v_roll;
    IF v_exists = 0 THEN
      INSERT INTO O_Roll_Call (Roll_No, Name, Class)
      VALUES (v_roll, v_name, v_class);
      SELECT CONCAT('Inserted: ', v_name, ' into O_Roll_Call') AS Message;
    ELSE
      SELECT CONCAT('Skipped: ', v_name, ' (already exists in O_Roll_Call)') AS Message;
    END IF;
  END LOOP;
  CLOSE cur;
END$$

DELIMITER ;

CALL merge_roll_call();

SELECT * FROM O_Roll_Call ORDER BY Roll_No;
