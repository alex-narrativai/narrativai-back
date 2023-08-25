FROM haskell:9.6

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        sqlite3

WORKDIR /app

# Copy all Haskell and SQL files
COPY . .

# Build the Haskell app
RUN stack build

# Initialize the SQLite database
RUN sqlite3 dev.sqlite3 < db_init.sql

CMD ["stack", "exec", "narrativai-auth-sec-service"]