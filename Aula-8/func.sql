CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    species TEXT NOT NULL,
    age INT
);
INSERT INTO animals (name, species, age) VALUES
('Luna', 'Dog', 3),
('Milo', 'Cat', 2),
('Charlie', 'Parrot', 5),
('Bella', 'Rabbit', 1),
('Rocky', 'Turtle', 10);

SELECT * FROM animals;

CREATE TEMP TABLE temp_animals AS
SELECT * FROM animals;

SELECT * FROM temp_animals

-- Temp tables are a simple way to test one db without interact with the
-- real db, we can create a copy of it and use it on tests.

-- Temp tables exists just in the session on PG, when u close it,
-- temp tables are erased.

-- This is the basic structure in functions
CREATE FUNCTION sum_two_numbers(num1 INT, num2 INT)  
RETURNS INT AS $$
BEGIN
    RETURN num1 + num2;
END;
$$ LANGUAGE plpgsql;


SELECT sum_two_numbers(num1, num2);


CREATE FUNCTION classify_animal_age(age INT)  
RETURNS TEXT AS $$
BEGIN
    IF age < 3 THEN
        RETURN 'Young';
    ELSE
        RETURN 'Old';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT classify_animal_age(2);
SELECT classify_animal_age(6);


CREATE FUNCTION get_and_use_animal_age(animal_name TEXT)
RETURNS INT AS $$
DECLARE	
	animal_age INT;
	new_age INT;
BEGIN	
	SELECT age INTO animal_age
	FROM animals
	WHERE name = animal_name;
	new_age := animal_age + 5;

	RETURN new_age;
END;
$$ LANGUAGE plpgsql;

SELECT get_and_use_animal_age('Luna');



CREATE FUNCTION check_valid_age(animal_name TEXT)
RETURNS VOID AS $$
DECLARE
    animal_age INT;
BEGIN
    -- Fetch animal's age
    SELECT age INTO animal_age 
	FROM animals 
	WHERE name = animal_name;

    -- If no age is found, raise an exception
    IF animal_age IS NULL THEN
        RAISE EXCEPTION 'Animal % not found!', animal_name;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT check_valid_age('NonExistentAnimal');

CREATE FUNCTION check_animal_age(animal_name TEXT, age_threshold INT)
RETURNS VOID AS $$
DECLARE
    animal_age INT;
BEGIN
    -- Fetch the age of the animal
    SELECT age INTO animal_age
    FROM animals
    WHERE name = animal_name;

    -- If the animal's age is greater than the threshold, print a message
    IF animal_age > age_threshold THEN
        RAISE NOTICE 'The age of animal % is greater than %: %', animal_name, age_threshold, animal_age;
    ELSE
        RAISE NOTICE 'The age of animal % is less than or equal to %: %', animal_name, age_threshold, animal_age;
    END IF;
END;
$$ LANGUAGE plpgsql;



SELECT check_animal_age('Luna', 4);




	

