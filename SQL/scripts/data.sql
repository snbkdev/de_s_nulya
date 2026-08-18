INSERT INTO characters (id, name, status, species, type, gender, origin_id) VALUES
(1, 'Rick Sanchez', 'Alive', 'Human', 'Scientist', 'Male', NULL),
(2, 'Morty Smith', 'Alive', 'Human', 'Student', 'Male', NULL),
(3, 'Summer Smith', 'Alive', 'Human', 'Student', 'Female', NULL),
(4, 'Beth Smith', 'Alive', 'Human', 'Veterinarian', 'Female', NULL),
(5, 'Jerry Smith', 'Alive', 'Human', 'Salesman', 'Male', NULL),
(6, 'Birdperson', 'Dead', 'Birdperson', NULL, 'Male', NULL),
(7, 'Mr. Meeseeks', 'Alive', 'Humanoid', NULL, 'Male', NULL),
(8, 'Squanchy', 'Alive', 'Cat', NULL, 'Male', NULL),
(9, 'Evil Morty', 'Alive', 'Human', 'Robot', 'Male', NULL),
(10, 'Pickle Rick', 'Alive', 'Human', 'Pickle', 'Male', NULL);

INSERT INTO locations (id, name, type, dimension) VALUES
(1, 'Earth (C-137)', 'Planet', 'Dimension C-137'),
(2, 'Earth (Replacement)', 'Planet', 'Replacement Dimension'),
(3, 'Birdperson''s Planet', 'Planet', 'Unknown'),
(4, 'Purge Planet', 'Planet', 'Unknown'),
(5, 'Giant''s Dimension', 'Dimension', 'Giant Dimension'),
(6, 'Rick''s Garage', 'Garage', 'Dimension C-137'),
(7, 'The Citadel', 'Space Station', 'The Citadel'),
(8, 'Pizza Planet', 'Planet', 'Fast Food Dimension'),
(9, 'Blips and Chitz', 'Arcade', 'Dimension C-137'),
(10, 'Planet Squanch', 'Planet', 'Squanch Dimension');

INSERT INTO episodes (id, name, air_date, episode_id) VALUES
(1, 'Pilot', '2013-12-02', 'S01E01'),
(2, 'Lawnmower Dog', '2013-12-09', 'S01E02'),
(3, 'Anatomy Park', '2013-12-16', 'S01E03'),
(4, 'M. Night Shaym-Aliens!', '2013-12-23', 'S01E04'),
(5, 'Meeseeks and Destroy', '2014-01-13', 'S01E05'),
(6, 'Rick Potion #9', '2014-01-20', 'S01E06'),
(7, 'The Ricks Must Be Crazy', '2015-07-26', 'S02E06'),
(8, 'The Wedding Squanchers', '2015-10-04', 'S02E10'),
(9, 'The Ricklantis Mixup', '2017-09-10', 'S03E07'),
(10, 'The Vat of Acid Episode', '2020-05-31', 'S04E08');


INSERT INTO char_ep (character_id, episode_id) VALUES
(1, 1), (2, 1), (1, 2), (2, 2), (1, 3), (2, 3),
(3, 4), (4, 4), (5, 4), (1, 5), (7, 5),
(1, 6), (2, 6), (8, 6),
(1, 7), (2, 7), (6, 8), (8, 8), (9, 9),
(10, 10), (1, 10), (2, 10);


INSERT INTO char_loc (character_id, location_id) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
(1, 6), (2, 6),
(6, 3), (8, 3),
(9, 7),
(10, 1),
(1, 9), (2, 9);