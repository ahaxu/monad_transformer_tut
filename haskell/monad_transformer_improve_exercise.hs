-- Exercise purpose
--
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
    UserInfo Name Age Address
    deriving Show

-- newtype ExceptT e m a =
--  ExceptT (m (Either e a))
--
getName :: ExceptT Error IO String
        -- ^ ExcepT IO Either Error String
getName = do
    name <- lift $ prompt "nhap ten" --ExceptT IO String
    if name == ""
        then ExceptT $ return $ Left "vui long nhap ten"
        else ExceptT $ return $ Right name

getAge :: ExceptT Error IO Int
getAge = ExceptT $ do
    age <- prompt "nhap tuoi"
    if age == "" || (read age :: Int) <=0
        then return $ Left "nhap tuoi cho dung nhe"
        else return $ Right (read age :: Int)


getAddress :: ExceptT Error IO String
getAddress = ExceptT $ do
    address <- prompt "nhap address"
    if address == ""
        then return $ Left "nhap dia chia chua dung"
        else return $ Right address


getUserInfo :: ExceptT Error IO UserInfo
getUserInfo = do
    name <- getName
    age <- getAge
    address <- getAddress
    return $ UserInfo name age address


improvedMain2 :: IO ()
improvedMain2 = do
    eU <- runExceptT getUserInfo
    case eU of
        Left err -> print err
        Right u -> print u

-- newtype MaybeT m a = MaybeT {runMaybeT :: m (Maybe a)}

