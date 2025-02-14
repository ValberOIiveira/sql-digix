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