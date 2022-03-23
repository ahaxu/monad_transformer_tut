-- improved version
-- in this improved version we want to print out what is exactly error
-- we want to reduce code jungle in getUserInfo

module MonadTransTut where

import Control.Monad.Trans.Except
import Control.Monad.Trans.Class (lift)

prompt :: String -> IO String
prompt question = do
    putStrLn question
    res <- getLine
    return res

type Error = String
type Name = String
type Age = Int
type Address = String

data UserInfo =
    UserInfo Name Age String
    deriving Show

getName :: ExceptT Error IO String
getName = do
    name <- lift $ prompt "your name"
    if name == "" then
        ExceptT $ return $ Left "no name"
    else
        ExceptT $ return $ Right name

getAge :: ExceptT Error IO Int
getAge = ExceptT $ do
    -- no need to `lift` on `prompt`, because we are already in ExceptT context
    age <- prompt "your age"
    if (read age :: Int) <= 0 then
        return $ Left "no age"
    else
        return $ Right (read age:: Int)

getAddress :: ExceptT Error IO String
getAddress = ExceptT $ do
    address <- prompt "type your address"
    if address == "" then
        return $ Left "no address"
    else
        return $ Right address


getUserInfo :: ExceptT Error IO UserInfo
getUserInfo = do
    name <- getName
    age <- getAge
    address <- getAddress
    return $ UserInfo name age address

improvedMain2 :: IO ()
improvedMain2 = do
    userInfo <- runExceptT getUserInfo
    case userInfo of
        Left err -> print err
        Right u -> print u

