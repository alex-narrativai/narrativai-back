-- Create User table
CREATE TABLE IF NOT EXISTS User (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);

-- Add index on email for faster lookup
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_email ON User(email);
