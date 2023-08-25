-- src/Handler/Auth.hs
module Handler.Auth where

import Import
import Crypto.BCrypt
import Web.JWT as JWT

{-|
    Registers a new user by hashing their password and inserting their information into the database.
    Returns a JSON response indicating that the user has been registered.
-}
postRegisterR :: Handler Value
postRegisterR = do
    user <- requireCheckJsonBody :: Handler User
    hashedPassword <- hashPasswordUsingBcrypt (userPassword user)
    _ <- runDB $ insert (user { userPassword = hashedPassword })
    returnJson ("Registered" :: Text)

{-|
    Logs in a user by validating their email and password against the database.
    If the email and password are valid, returns a JSON response containing a JWT token.
    Otherwise, returns a JSON response indicating that the email or password is invalid.
-}
postLoginR :: Handler Value
postLoginR = do
    user <- requireCheckJsonBody :: Handler User
    dbUser <- runDB $ getBy (UniqueEmail (userEmail user))
    case dbUser of
        Just (Entity _ u) -> do
            if validatePassword (userPassword u) (userPassword user)
                then do
                    let jwtToken = createJwtToken (userEmail user)
                    returnJson ("Bearer " <> jwtToken :: Text)
                else invalidArgs ["Invalid email or password"]
        Nothing -> invalidArgs ["Invalid email or password"]

{-|
    Validates a JWT token by decoding and verifying it.
    If the token is valid, returns a JSON response indicating that the token is valid.
    Otherwise, returns a JSON response indicating that the token is invalid.
-}
getValidateR :: Handler Value
getValidateR = do
    token <- lookupGetParam "token"
    case token of
        Just t -> do
            let decoded = decodeAndVerifyJwtToken t
            case decoded of
                Just email -> returnJson ("Valid token for " <> email :: Text)
                Nothing -> invalidArgs ["Invalid token"]
        Nothing -> invalidArgs ["Missing token"]

{-|
    Hashes a password using the bcrypt algorithm.
    Returns the hashed password as a Text value.
-}
hashPasswordUsingBcrypt :: Text -> IO Text
hashPasswordUsingBcrypt password = do
    hashedPassword <- hashPasswordUsingPolicy slowerBcryptHashingPolicy (encodeUtf8 password)
    return $ decodeUtf8 hashedPassword

{-|
    Validates a password by comparing a hashed password with a plaintext password.
    Returns True if the passwords match, False otherwise.
-}
validatePassword :: Text -> Text -> Bool
validatePassword hashedPassword password = validatePasswordWithPolicy slowerBcryptHashingPolicy (encodeUtf8 hashedPassword) (encodeUtf8 password)

{-|
    Creates a JWT token for a given email address using the HS256 algorithm and a secret key.
    Returns the JWT token as a Text value.
-}
createJwtToken :: Text -> Text
createJwtToken email = encodeSigned HS256 (secret "secret-key") claims
  where
    claims = mempty { sub = Just $ stringOrURI email }

{-|
    Decodes and verifies a JWT token using the HS256 algorithm and a secret key.
    If the token is valid, returns the email address associated with the token.
    Otherwise, returns Nothing.
-}
decodeAndVerifyJwtToken :: Text -> Maybe Text
decodeAndVerifyJwtToken token = do
    let key = secret "secret-key"
    claims <- decodeAndVerifySignature key token
    sub <- sub claims
    return $ stringOrURI sub
