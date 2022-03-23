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

- Làm theo kiểu xôi thịt [monad_transformer_naive_way](./monad_transformer_naive_way.hs)

- Phiên bản cải tiến hơn, có in ra lý do lỗi [monad_transformer_improve_1](./monad_transformer_improve_1.hs) version, print out why the validation failed

- Phiên bản sử dụng monad transformer [monad_transformer_improve_2](./monad_transformer_improve_2.hs), chúng ta giam duoc rat nhieu boilerplate code

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

### Monad transformer tutorial

- Come up with naive approach [monad_transformer_naive_way](./monad_transformer_naive_way.hs)

- Then, [monad_transformer_improve_1](./monad_transformer_improve_1.hs) version, print out why the validation failed

- Finally, [monad_transformer_improve_2](./monad_transformer_improve_2.hs) `case ... of` pattern matching
