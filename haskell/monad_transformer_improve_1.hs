-- improved version
-- in this improved version we want to print out what is exactly error

module MonadTransTut where

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

getName :: IO (Either Error Name)
-- public static Name getName () throw Error
getName = do
    name <- prompt "your name" -- name :: String
    if name == "" then
        return $ Left "no name"
    else
        return $ Right name

getAge :: IO (Either Error Age)
getAge = do
    age <- prompt "your age"
    if (read age :: Int) <= 0 then
        return $ Left "no age"
    else
        return $ Right (read age:: Int)

getAddress :: IO (Either Error Address)
getAddress = do
    address <- prompt "type your address"
    if address == "" then
        return $ Left "no address"
    else
        return $ Right address


getUserInfo :: IO (Either Error UserInfo)
getUserInfo = do
    name <- getName -- Either Error UserInfo
    case name of
        Left err -> return $ Left err
        Right name' -> do
            age <- getAge
            case age of
                Left err -> return $ Left err
                Right age' -> do
                    address <- getAddress
                    case address of
                        Left err -> return $ Left err
                        Right address' -> return $ Right $ UserInfo name' age' address'

improvedMain1 :: IO ()
improvedMain1 = do
    userInfo <- getUserInfo
    -- in this improved version we want to print out what is exactly error
    case userInfo of
        Left err -> print err
        Right uI -> print uI
