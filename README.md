## Monad transformer

### Link youtube bài giảng liên quan 

https://youtu.be/QO8J8vMy7Cc

### Ví dụ đơn giản về monad transformer

Ở ví dụ này, chúng ta làm đơn giản một chuơng trình, yêu cầu nhập vào `tên`, `tuổi`, `địa chỉ`

```
getName
getAge
getAddress
```

Sau đó, combine lại thành 1 hàm `getUserInfo`.

Chuơng trình sẽ in ra lỗi, nếu 1 trong các buớc valiation bị lỗi (validation ở đây đơn giản so sánh chuỗi nhập vào trống hay ko).

Chúng ta sẽ hiện thực theo trình tự xôi thịt (chạy đựoc, quick and dirty), sau đó là các buớc refactor code, ở đây chúng ta dùng `Monad transformer` để refactor code.

### Trình tự 

- Làm theo kiểu xôi thịt [monad_transformer_naive_way](./haskell/monad_transformer_naive_way.hs#L44)
```
getUserInfo :: IO (Maybe UserInfo)
getUserInfo = do
    name <- getName
    case name of
        Nothing -> return Nothing
        Just name' -> do
            age <- getAge
            case age of
                Nothing -> return Nothing
                Just age' -> do
                    address <- getAddress
                    case address of
                        Nothing -> return Nothing
                        Just address' -> return $ Just $ UserInfo name' age' address'
```

- Phiên bản cải tiến hơn, có in ra lý do lỗi [./haskell/monad_transformer_improve_1](./haskell/monad_transformer_improve_1.hs) version, in ra tại sao validate failed (dùng Either data type)

- Phiên bản sử dụng monad transformer [./haskell/monad_transformer_improve_2](./haskell/monad_transformer_improve_2.hs#L51), chúng ta giam duoc rat nhieu boilerplate code
```
getUserInfo :: ExceptT Error IO UserInfo
getUserInfo = do
    name <- getName
    age <- getAge
    address <- getAddress
    return $ UserInfo name age address
```

### Cách chạy
```
cd path_to/monad-transformer-tut
ghci

# phien ban xoi thit
:l monad_transformer_naive_way.hs

# phien ban cai tien 1
:l monad_transformer_improve_1.hs

# phien ban cai tien 2
:l monad_transformer_improve_2.hs

```

### [EN] Monad transformer tutorial

- Come up with naive approach [./haskell/monad_transformer_naive_way](./haskell/monad_transformer_naive_way.hs)

- Then, [./haskell/monad_transformer_improve_1](./haskell/monad_transformer_improve_1.hs) version, print out why the validation failed

- Finally, [./haskell/monad_transformer_improve_2](./haskell/monad_transformer_improve_2.hs) `case ... of` pattern matching


#### Reference

- [Adam McCullough - Monad Transformers for the Easily Confused - λC 2018
](https://www.youtube.com/watch?v=SMj-n2f7wYY&t=1781s&ab_channel=LambdaConf)
- [Why monad can't compose](https://youtu.be/EWTQfRQugBY?t=5204)
