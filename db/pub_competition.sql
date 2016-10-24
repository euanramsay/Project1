DROP TABLE votes;
DROP TABLE pubs;

CREATE TABLE pubs (
  id serial4 PRIMARY KEY,
  name VARCHAR(255),
  postcode VARCHAR(255)
);

CREATE TABLE votes (
  id serial4 PRIMARY KEY,
  pub_id INT4 REFERENCES pubs(id) ON DELETE CASCADE,
  score INT4,
  vote1_id INT4,
  vote2_id INT4,
  vote3_id INT4
);