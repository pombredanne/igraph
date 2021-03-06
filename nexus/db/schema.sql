CREATE TABLE licence (
       id INTEGER,
       name TEXT,
       text TEXT,	
       fulltext TEXT,
       link TEXT,
       PRIMARY KEY(id)
);

CREATE TABLE dataset (
       id INTEGER,
       sid TEXT,
       name TEXT,
       shortdescription TEXT,
       description TEXT,
       licence INTEGER,
       source TEXT,
       date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       downloads INTEGER,
       PRIMARY KEY(id),
       UNIQUE(sid),
       FOREIGN KEY(licence) REFERENCES licence(id)
);

CREATE TABLE network (
       dataset INTEGER,
       id INTEGER,       
       description TEXT,
       vertices INTEGER,
       edges INTEGER,
       directed BOOLEAN,
       bipartite BOOLEAN,
       weighted BOOLEAN,
       filename TEXT,
       date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       PRIMARY KEY(dataset, id)
);

CREATE TABLE citation (
       id TEXT,
       citation TEXT,
       PRIMARY KEY (id)
);

CREATE TABLE dataset_citation (
       dataset INTEGER,
       citation TEXT,
       PRIMARY KEY(dataset, citation),
       FOREIGN KEY(dataset) REFERENCES dataset(id),
       FOREIGN KEY(citation) REFERENCES citation(id)
);

CREATE TABLE tag (
       id INTEGER,
       tag TEXT,
       description TEXT,
       PRIMARY KEY(id)
);

CREATE TABLE dataset_tag (
       dataset INTEGER,
       tag INTEGER,
       PRIMARY KEY(dataset, tag),
       FOREIGN KEY(dataset) REFERENCES dataset(id),
       FOREIGN KEY(tag) REFERENCES tag(id)
);

CREATE TABLE format (
       name VARCHAR(20),
       shortdesc VARCHAR(100),
       description TEXT,
       link VARCHAR(200),
       extension VARCHAR(20),
       PRIMARY KEY(name)
);

CREATE TABLE metadata (
       dataset INTEGER,
       network INTEGER,
       type VARCHAR(10),
       datatype VARCHAR(10),
       name VARCHAR(30),
       description TEXT,
       PRIMARY KEY(dataset, network, type, name),
       FOREIGN KEY(dataset, network) REFERENCES network(dataset, network)
);

CREATE TABLE filesize (
       dataset INTEGER,
       format VARCHAR(20),
       size INTEGER,
       PRIMARY KEY(dataset, format),
       FOREIGN KEY(dataset) REFERENCES dataset(id),
       FOREIGN KEY(format) REFERENCES format(name)
);

CREATE TABLE user (
       name TEXT,
       openid TEXT,
       admin BOOLEAN,
       PRIMARY KEY(openid),
       UNIQUE(name)
);

CREATE TABLE blog (
       id INTEGER,
       date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       author TEXT,
       title TEXT,
       entry TEXT,
       published INTEGER,
       PRIMARY KEY(id),
       FOREIGN KEY(author) REFERENCES user(name)
);
