-- Make "Voice Type" Table
CREATE TABLE voice_type (
    id SERIAL NOT NULL PRIMARY KEY,
    voice_type VARCHAR(40) NOT NULL
);

-- Make "People" Table
CREATE TABLE people (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30),
    nickname VARCHAR(30) NOT NULL,
    id_voice_type INT,
    CONSTRAINT fk_voice_type FOREIGN KEY (id_voice_type) REFERENCES voice_type(id)
);

-- Make "Social Media" Table
CREATE TABLE social_media(
    id SERIAL NOT NULL PRIMARY KEY,
    id_people INT,
    ChannelA VARCHAR(300),
    ChannelB VARCHAR(300),
    DiscordA VARCHAR(300),
    DiscordB VARCHAR(300),
    Instagram VARCHAR(300),
    TikTok VARCHAR(300),
    CONSTRAINT fk_people FOREIGN KEY (id_people) REFERENCES people(id),
);

-- Make "Project" Table
CREATE TABLE project (
    id SERIAL NOT NULL PRIMARY KEY,
    id_people INT,
    project_name VARCHAR(100) NOT NULL,
    genderA VARCHAR(30),
    genderB VARCHAR(30),
    CONSTRAINT fk_people FOREIGN KEY (id_people) REFERENCES people(id)
);

-- Make "Frequency" Table
CREATE TABLE frequency (
    id SERIAL NOT NULL PRIMARY KEY,
    id_name INT,
    id_project INT,
    frequency VARCHAR(20) NOT NULL,
    CONSTRAINT fk_name FOREIGN KEY (id_name) REFERENCES people(id),
    CONSTRAINT fk_project FOREIGN KEY (id_project) REFERENCES project(id)
);

-- Make "Frequency_People" relation
CREATE TABLE frequency_people (
    id SERIAL NOT NULL PRIMARY KEY,
    id_people INT NOT NULL,
    id_frequency INT NOT NULL,
    CONSTRAINT fk_people FOREIGN KEY (id_people) REFERENCES people(id),
    CONSTRAINT fk_frequency FOREIGN KEY (id_frequency) REFERENCES frequency(id)
);

-- Make "History_Dub" Table
CREATE TABLE history_dub (
    id SERIAL NOT NULL PRIMARY KEY,
    id_people INT NOT NULL,
    id_project INT NOT NULL,
    history TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT fk_people FOREIGN KEY (id_people) REFERENCES people(id),
    CONSTRAINT fk_project FOREIGN KEY (id_project) REFERENCES project(id)
);






-- Constraints


-- Unique Constraint in Voice Type
ALTER TABLE voice_type
ADD CONSTRAINT unq_voice_type UNIQUE (voice_type);

-- Unique Constraint in Voice Typet remote 
ALTER TABLE project
ADD CONSTRAINT unq_project_name UNIQUE (project_name);


-- Unique and Date Constraint in Frequency
ALTER TABLE frequency
ADD CONSTRAINT unq_frequency UNIQUE (id)
ADD CONSTRAINT chk_data_passada CHECK (data <= CURRENT_DATE);


-- Unique history
ALTER TABLE history_dub
ADD CONSTRAINT unq_history_dub UNIQUE (id_people, id_project, history);