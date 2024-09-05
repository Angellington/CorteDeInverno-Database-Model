-- Make "Voice Type" Table - (Unique Voice Type Constraint)
CREATE TABLE voice_type (
    id SERIAL NOT NULL PRIMARY KEY,
    voice_type VARCHAR(40) NOT NULL,
    CONSTRAINT unq_voice_type UNIQUE (voice_type)
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
    CONSTRAINT fk_people_social FOREIGN KEY (id_people) REFERENCES people(id)
);

-- Make "Project" Table
CREATE TABLE project (
    id SERIAL NOT NULL PRIMARY KEY,
    id_people INT,
    project_name VARCHAR(100) NOT NULL,
    genderA VARCHAR(30),
    genderB VARCHAR(30),
    CONSTRAINT fk_people_project FOREIGN KEY (id_people) REFERENCES people(id),
    CONSTRAINT unq_project_name UNIQUE (project_name)
);

-- Make "Frequency" Table
CREATE TABLE frequency (
    id SERIAL NOT NULL PRIMARY KEY,
    id_people INT,
    id_project INT,
    frequency VARCHAR(20) NOT NULL,
    CONSTRAINT fk_people_frequency FOREIGN KEY (id_people) REFERENCES people(id),
    CONSTRAINT fk_project_frequency FOREIGN KEY (id_project) REFERENCES project(id),
);

-- Make "Frequency_People" relation
CREATE TABLE frequency_people (
    id SERIAL NOT NULL PRIMARY KEY,
    id_people INT NOT NULL,
    id_frequency INT NOT NULL,
    CONSTRAINT fk_people_frequency_people FOREIGN KEY (id_people) REFERENCES people(id),
    CONSTRAINT fk_frequency_frequency_people FOREIGN KEY (id_frequency) REFERENCES frequency(id)
);

-- Make "History_Dub" Table
CREATE TABLE history_dub (
    id SERIAL NOT NULL PRIMARY KEY,
    id_people INT NOT NULL,
    id_project INT NOT NULL,
    history TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT fk_people_history_dub FOREIGN KEY (id_people) REFERENCES people(id),
    CONSTRAINT fk_project_history_dub FOREIGN KEY (id_project) REFERENCES project(id),
    CONSTRAINT unq_history_history_dub UNIQUE (id_people, id_project, history)
);