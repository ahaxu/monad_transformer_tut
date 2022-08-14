module MonadTransTut where

prompt :: String -> IO String
prompt question = do
    putStrLn question
    res <- getLine -- res :: String
    pure res -- IO String

getName :: IO (Maybe String)
getName = do
    -- putStrLn "type your name"
    -- name <- getLine
    name <- prompt "your name"
    if name == "" then
        return Nothing
    else
        return $ Just name

getAge :: IO (Maybe Int)
getAge = do
    -- putStrLn "type your age"
    -- age <- getLine
    age <- prompt "your age"
    if age == "" || (read age :: Int) <= 0 then
        return Nothing
    else
        return $ Just (read age:: Int)

getAddress :: IO (Maybe String)
getAddress = do
    putStrLn "type your address"
    address <- getLine
    if address == "" then
        return Nothing
    else
        return $ Just address

type Name = String
type Age = Int
type Address = String
data UserInfo = UserInfo Name Age Address
    deriving Show

getUserInfo :: IO (Maybe UserInfo)
getUserInfo = do -- IO
    name <- getName -- name:: Maybe String
    case name of
        Nothing -> return Nothing
        Just name' -> do
            age <- getAge -- age:: Maybe Int
            case age of
                Nothing -> return Nothing
                Just age' -> do
                    address <- getAddress
                    case address of
                        Nothing -> return Nothing
                        Just address' -> return $ Just $ UserInfo name' age' address' -- IO Maybe UserInfo

main :: IO ()
main = do
    userInfo <- getUserInfo -- IO Maybe UserInfo
    -- ^ :: Maybe UserInfo
    case userInfo of
        Nothing -> print "no valid info"
        Just uI -> print uI
