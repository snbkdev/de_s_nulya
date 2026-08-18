CREATE TABLE characters (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    status VARCHAR(50),
    species VARCHAR(100),
    type VARCHAR(100),
    gender VARCHAR(50),
    origin_id INT
);

CREATE TABLE episodes (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    air_date DATE,
    episode_id VARCHAR(20)
);

CREATE TABLE locations (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(100),
    dimension VARCHAR(100)
);

CREATE TABLE char_ep (
    character_id INT,
    episode_id INT,
    PRIMARY KEY (character_id, episode_id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (episode_id) REFERENCES episodes(id)
);

CREATE TABLE char_loc (
    character_id INT,
    location_id INT,
    PRIMARY KEY (character_id, location_id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (location_id) REFERENCES locations(id)
);