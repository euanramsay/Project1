DROP TABLE pubs;
DROP TABLE votes;

CREATE TABLE pubs (
  id serial4 PRIMARY KEY,
  name VARCHAR(255),
  postcode VARCHAR(255),
  score INT4,
);

CREATE TABLE votes (
  id serial4 PRIMARY KEY,
  pub_id INT4,
  vote1_id INT4,
  vote2_id INT4,
  vote3_id INT4
);