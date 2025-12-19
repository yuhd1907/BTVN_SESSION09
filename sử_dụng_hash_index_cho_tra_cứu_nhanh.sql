CREATE INDEX idx_users_email_hash ON Users USING HASH (email);

CREATE INDEX idx_users_email_hash ON Users(email) USING HASH;

EXPLAIN SELECT * FROM Users WHERE email = 'example@example.com';