-- test/AuthSpec.hs
module AuthSpec (spec) where

import TestImport
import Web.JWT as JWT (secret, stringOrURI)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE

spec :: Spec
spec = withApp $ do
    describe "Register user" $ do
        it "gives a 200 status code" $ do
            postJson RegisterR $ object ["email" .= ("test@email.com" :: Text), "password" .= ("password123" :: Text)]
            statusIs 200

    describe "Login user" $ do
        it "gives a 200 status code and returns a JWT token" $ do
            postJson LoginR $ object ["email" .= ("test@email.com" :: Text), "password" .= ("password123" :: Text)]
            statusIs 200
            token <- getJsonBody
            assertEqual "Should return a token" (T.isPrefixOf "Bearer " token) True

    describe "Validate token" $ do
        it "validates a JWT token" $ do
            get $ ValidateR $ [("token", "YOUR_JWT_TOKEN_HERE")]
            statusIs 200
