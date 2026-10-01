# PHP-CI4 練習專案

這份 README 紀錄本專案從原本的 PHP 專案搬進 **CodeIgniter 4（CI4）** 後，到完成「案主資料 CRUD、照片/文件上傳、修改、刪除」這一階段的主要概念、檔案結構與程式重點。

> 本文件暫時**不整理身分驗證、Session、角色、邀請碼、AuthFilter 等功能**。
> 這些屬於另一個「身分驗證系統」階段，會另外整理。

---

## 目錄

1. [專案環境](#1-專案環境)
2. [CI4 專案位置](#2-ci4-專案位置)
3. [CI4 基本運作觀念](#3-ci4-基本運作觀念)
4. [從原本 PHP 搬進 CI4 的核心變化](#4-從原本-php-搬進-ci4-的核心變化)
5. [專案資料夾結構](#5-專案資料夾結構)
6. [Route](#6-route)
7. [Controller](#7-controller)
8. [View](#8-view)
9. [Model 與資料庫](#9-model-與資料庫)
10. [案主 CRUD](#10-案主-crud)
11. [案主照片與文件上傳](#11-案主照片與文件上傳)
12. [修改案主時重新上傳照片/文件](#12-修改案主時重新上傳照片文件)
13. [刪除目前照片/文件](#13-刪除目前照片文件)
14. [檔案上傳的重要觀念](#14-檔案上傳的重要觀念)
15. [詳細資料頁](#15-詳細資料頁)
16. [PDF 預覽與 Word 下載](#16-pdf-預覽與-word-下載)
17. [CSS 架構](#17-css-架構)
18. [常見問題與除錯方式](#18-常見問題與除錯方式)
19. [這一階段完成的功能](#19-這一階段完成的功能)
20. [後續開發方向](#20-後續開發方向)

---

# 1. 專案環境

目前使用的環境：

- Windows
- XAMPP
- Apache
- MySQL
- PHP 8.2.12
- Visual Studio Code
- CodeIgniter 4
- Git / GitHub

XAMPP 路徑：

```text
C:\Users\User\xampp
```

PHP 執行檔位於：

```text
C:\Users\User\xampp\php
```

CI4 專案：

```text
C:\Users\User\xampp\htdocs\my-project
```

---

# 2. CI4 專案位置

CI4 專案放在：

```text
C:\Users\User\xampp\htdocs\my-project
```

進入專案：

```bash
cd C:\Users\User\xampp\htdocs\my-project
```

啟動 CI4：

```bash
php spark serve
```

成功後可以使用：

```text
http://localhost:8080
```

---

# 3. CI4 基本運作觀念

CI4 最重要的基本概念：

```text
Browser
   ↓
Route
   ↓
Controller
   ↓
Model
   ↓
Database
   ↓
Controller
   ↓
View
   ↓
Browser
```

例如使用者進入：

```text
/clients
```

Route 會決定：

```text
/clients
   ↓
ClientController::index()
```

Controller 再呼叫 Model：

```php
$clientModel = new ClientModel();

$data['clients'] = $clientModel->findAll();
```

最後把資料交給 View：

```php
return view('clients/index', $data);
```

View 負責產生 HTML。

---

# 4. 從原本 PHP 搬進 CI4 的核心變化

原本單純 PHP 專案可能會把：

```text
HTML
PHP
SQL
表單處理
檔案處理
```

全部寫在同一個檔案。

搬進 CI4 後，開始分工：

```text
Route
    ↓
Controller
    ↓
Model
    ↓
Database

Controller
    ↓
View
```

主要目的不是讓程式變多，而是讓每個部分的責任更清楚。

## Route

負責：

> 「這個網址要交給誰處理？」

## Controller

負責：

> 「收到請求後，要做什麼？」

例如：

- 接收表單
- 呼叫 Model
- 處理檔案
- 決定 redirect
- 把資料交給 View

## Model

負責：

> 「怎麼跟資料庫互動？」

例如：

- 查詢
- 新增
- 修改
- 刪除

## View

負責：

> 「畫面要長什麼樣子？」

---

# 5. 專案資料夾結構

這一階段主要使用：

```text
my-project/
│
├─ app/
│  ├─ Controllers/
│  │  └─ Clients.php
│  │
│  ├─ Models/
│  │  └─ ClientModel.php
│  │
│  ├─ Views/
│  │  └─ clients/
│  │     ├─ index.php
│  │     ├─ create.php
│  │     ├─ edit.php
│  │     └─ detail.php
│  │
│  └─ Config/
│     └─ Routes.php
│
├─ public/
│  ├─ css/
│  │  ├─ common.css
│  │  ├─ client-list.css
│  │  ├─ client-form.css
│  │  └─ client-detail.css
│  │
│  └─ uploads/
│     ├─ photos/
│     └─ files/
│
├─ writable/
│
├─ .env
└─ spark
```

實際專案中 Controller / View 名稱可以依自己的命名方式調整。

---

# 6. Route

Route 位於：

```text
app/Config/Routes.php
```

Route 的工作就是把 URL 對應到 Controller 方法。

例如：

```php
$routes->get('/clients', 'Clients::index');

$routes->get('/clients/create', 'Clients::create');

$routes->post('/clients/store', 'Clients::store');

$routes->get('/clients/edit/(:num)', 'Clients::edit/$1');

$routes->post('/clients/update/(:num)', 'Clients::update/$1');

$routes->get('/clients/delete/(:num)', 'Clients::delete/$1');

$routes->get('/clients/detail/(:num)', 'Clients::detail/$1');
```

概念：

```text
GET /clients
    ↓
Clients::index()

GET /clients/create
    ↓
Clients::create()

POST /clients/store
    ↓
Clients::store()

GET /clients/edit/5
    ↓
Clients::edit(5)

POST /clients/update/5
    ↓
Clients::update(5)

GET /clients/delete/5
    ↓
Clients::delete(5)

GET /clients/detail/5
    ↓
Clients::detail(5)
```

---

# 7. Controller

Controller 主要位置：

```text
app/Controllers/
```

案主相關 Controller：

```text
app/Controllers/Clients.php
```

Controller 主要負責：

1. 接收 HTTP Request
2. 取得表單資料
3. 呼叫 Model
4. 處理上傳檔案
5. Redirect
6. 傳資料給 View

例如：

```php
public function index()
{
    $clientModel = new ClientModel();

    $data['clients'] = $clientModel->findAll();

    return view('clients/index', $data);
}
```

這裡的流程：

```text
ClientModel
    ↓
findAll()
    ↓
取得資料
    ↓
$data['clients']
    ↓
View
```

---

# 8. View

View 主要位置：

```text
app/Views/
```

案主頁面：

```text
app/Views/clients/
```

例如：

```text
index.php
create.php
edit.php
detail.php
```

View 主要負責 HTML。

例如：

```php
<?php foreach ($clients as $client): ?>

    <p>
        <?= htmlspecialchars($client['ct_name']) ?>
    </p>

<?php endforeach; ?>
```

顯示使用者輸入或資料庫內容時，使用：

```php
htmlspecialchars()
```

可以避免 HTML / XSS 類型的問題。

---

# 9. Model 與資料庫

Model 主要位置：

```text
app/Models/
```

案主 Model：

```text
app/Models/ClientModel.php
```

基本形式：

```php
<?php

namespace App\Models;

use CodeIgniter\Model;

class ClientModel extends Model
{
    protected $table = 'clients';

    protected $primaryKey = 's_num';

    protected $allowedFields = [
        'ct_name',
        'ct_addr',
        'route_no',
        'meal_type',
        'b_date',
        'd_date',
        'photo',
        'file'
    ];
}
```

## `$table`

```php
protected $table = 'clients';
```

代表這個 Model 對應資料表：

```text
clients
```

## `$primaryKey`

```php
protected $primaryKey = 's_num';
```

代表主鍵不是預設的 `id`，而是：

```text
s_num
```

## `$allowedFields`

```php
protected $allowedFields = [
    ...
];
```

代表哪些欄位允許透過 Model 進行寫入。

如果新增資料時：

```php
$clientModel->insert([
    'ct_name' => $name
]);
```

`ct_name` 必須在 `$allowedFields` 中。

---

# 10. 案主 CRUD

CRUD：

```text
C = Create    新增
R = Read      查詢
U = Update    修改
D = Delete    刪除
```

---

## 10.1 Create：新增

Controller：

```php
public function store()
{
    $clientModel = new ClientModel();

    $clientModel->insert([
        'ct_name' => $this->request->getPost('ct_name'),
        'ct_addr' => $this->request->getPost('ct_addr'),
        'route_no' => $this->request->getPost('route_no'),
        'meal_type' => $this->request->getPost('meal_type'),
        'b_date' => $this->request->getPost('b_date'),
        'd_date' => $this->request->getPost('d_date')
    ]);

    return redirect()->to('/clients');
}
```

取得表單：

```php
$this->request->getPost('欄位名稱');
```

---

## 10.2 Read：查詢

全部資料：

```php
$clients = $clientModel->findAll();
```

單筆資料：

```php
$client = $clientModel->find($id);
```

條件查詢：

```php
$client = $clientModel
    ->where('s_num', $id)
    ->first();
```

---

## 10.3 Update：修改

Controller 會先取得指定的案主：

```php
$client = $clientModel->find($id);
```

然後更新：

```php
$clientModel->update($id, [
    'ct_name' => $this->request->getPost('ct_name'),
    'ct_addr' => $this->request->getPost('ct_addr'),
    'route_no' => $this->request->getPost('route_no'),
    'meal_type' => $this->request->getPost('meal_type')
]);
```

---

## 10.4 Delete：刪除

刪除資料：

```php
$clientModel->delete($id);
```

如果使用 Soft Delete，則刪除後資料不一定真的從資料庫消失，而是透過 `d_date` 等欄位表示已刪除。

---

# 11. 案主照片與文件上傳

本專案的案主資料除了文字欄位之外，還有：

```text
photo
file
```

分別代表：

```text
photo → 案主照片
file  → 案主相關文件
```

實際檔案放在：

```text
public/uploads/photos/
public/uploads/files/
```

資料庫只需要保存檔案名稱，例如：

```text
photo:
abc123.jpg

file:
document123.pdf
```

而不是把整個檔案直接存進 MySQL。

---

# 12. 修改案主時重新上傳照片/文件

修改資料時，要注意一個重要問題：

> 如果使用者重新上傳照片，舊照片不能只從資料庫欄位消失，還要處理實體檔案。

例如原本：

```text
資料庫：
photo = old.jpg

實體檔案：
public/uploads/photos/old.jpg
```

重新上傳：

```text
new.jpg
```

正確的思考流程：

```text
取得原本資料
    ↓
確認使用者有沒有重新上傳
    ↓
如果有
    ↓
刪除舊檔案
    ↓
儲存新檔案
    ↓
更新資料庫的檔案名稱
```

概念程式：

```php
$client = $clientModel->find($id);

$photo = $this->request->getFile('photo');

if ($photo && $photo->isValid() && !$photo->hasMoved()) {

    // 舊照片
    if (!empty($client['photo'])) {

        $oldPhoto = FCPATH . 'uploads/photos/' . $client['photo'];

        if (is_file($oldPhoto)) {
            unlink($oldPhoto);
        }
    }

    // 產生新的檔案名稱
    $newName = $photo->getRandomName();

    // 移動到 uploads/photos
    $photo->move(
        FCPATH . 'uploads/photos',
        $newName
    );

    // 更新資料庫
    $data['photo'] = $newName;
}
```

文件也是同樣概念：

```text
舊文件
    ↓
刪除
    ↓
新文件
    ↓
移動
    ↓
更新 DB
```

---

# 13. 刪除目前照片/文件

這個功能和「刪除整個案主」不同。

使用者可能只是想：

> 保留案主資料，但是把目前的照片刪掉。

因此流程是：

```text
案主資料保留
        │
        ├── ct_name 保留
        ├── ct_addr 保留
        ├── route_no 保留
        ├── meal_type 保留
        │
        └── photo → 刪除
```

---

## 13.1 刪除照片

概念流程：

```text
取得案主
    ↓
確認 photo 是否存在
    ↓
找到實體檔案
    ↓
unlink()
    ↓
資料庫 photo 設為空
```

例如：

```php
$client = $clientModel->find($id);

if (!empty($client['photo'])) {

    $photoPath = FCPATH
        . 'uploads/photos/'
        . $client['photo'];

    if (is_file($photoPath)) {
        unlink($photoPath);
    }

    $clientModel->update($id, [
        'photo' => null
    ]);
}
```

---

## 13.2 刪除文件

文件也是同樣概念：

```php
$client = $clientModel->find($id);

if (!empty($client['file'])) {

    $filePath = FCPATH
        . 'uploads/files/'
        . $client['file'];

    if (is_file($filePath)) {
        unlink($filePath);
    }

    $clientModel->update($id, [
        'file' => null
    ]);
}
```

---

## 13.3 為什麼一定要同時處理「實體檔案」和「資料庫」？

假設只做：

```php
$clientModel->update($id, [
    'photo' => null
]);
```

資料庫雖然沒有照片名稱了，但是：

```text
public/uploads/photos/old.jpg
```

還存在。

這會產生垃圾檔案。

反過來，如果只：

```php
unlink($photoPath);
```

但是資料庫還保存：

```text
photo = old.jpg
```

網站之後還會嘗試尋找：

```text
old.jpg
```

結果檔案已經不存在。

所以兩邊都要處理：

```text
實體檔案
    ↓
unlink()

資料庫
    ↓
photo = NULL
```

---

# 14. 檔案上傳的重要觀念

## 14.1 不要直接相信使用者提供的檔名

不要自己組合：

```php
$filename = $_POST['filename'];
```

CI4 提供：

```php
$file->getRandomName();
```

可以產生隨機檔名。

例如：

```php
$newName = $photo->getRandomName();
```

這樣可以降低檔名衝突問題。

---

## 14.2 先確認檔案有效

基本檢查：

```php
if ($photo->isValid() && !$photo->hasMoved()) {
    // 處理檔案
}
```

---

## 14.3 重要：限制檔案類型

照片通常可以限制：

```text
jpg
jpeg
png
webp
```

文件可以依需求限制：

```text
pdf
doc
docx
```

不要只依靠副檔名判斷。

CI4 validation 可以進一步搭配：

```text
uploaded
max_size
is_image
mime_in
ext_in
```

例如照片：

```text
uploaded[photo]
is_image[photo]
mime_in[photo,image/jpg,image/jpeg,image/png,image/webp]
max_size[photo,2048]
```

---

# 15. 詳細資料頁

案主列表與詳細資料頁分開。

列表頁主要顯示：

```text
案主姓名
地址
餐別
操作
```

詳細頁則顯示完整資訊，例如：

```text
姓名
地址
路線
餐別
日期
照片
文件
```

Route：

```php
$routes->get(
    '/clients/detail/(:num)',
    'Clients::detail/$1'
);
```

Controller：

```php
public function detail($id)
{
    $clientModel = new ClientModel();

    $client = $clientModel->find($id);

    if (!$client) {
        throw \CodeIgniter\Exceptions\PageNotFoundException::forPageNotFound();
    }

    return view('clients/detail', [
        'client' => $client
    ]);
}
```

---

# 16. PDF 預覽與 Word 下載

如果案主文件是 PDF，可以讓瀏覽器直接預覽。

例如：

```html
<iframe
    src="<?= base_url('uploads/files/' . $client['file']) ?>"
    width="100%"
    height="600">
</iframe>
```

Word 文件通常不適合直接使用瀏覽器預覽，因此可以提供下載：

```html
<a
    href="<?= base_url('uploads/files/' . $client['file']) ?>"
    download
>
    下載文件
</a>
```

核心概念：

```text
PDF
→ 預覽

Word
→ 下載
```

---

# 17. CSS 架構

CSS 放在：

```text
public/css/
```

目前依照頁面功能拆分：

```text
common.css
login.css
client-list.css
client-form.css
client-detail.css
```

## common.css

共用樣式，例如：

```css
* {
    box-sizing: border-box;
}

body {
    margin: 0;
}

a {
    text-decoration: none;
}

button,
input,
select {
    font: inherit;
}

.container {
    width: 90%;
    max-width: 1200px;
    margin: 0 auto;
}
```

共用 CSS 的目的：

> 不要每一個頁面都重複寫相同的 CSS。

---

# 18. 常見問題與除錯方式

## 18.1 `php spark serve` 無法執行

先確認目前所在位置：

```bash
cd C:\Users\User\xampp\htdocs\my-project
```

再：

```bash
php spark serve
```

---

## 18.2 PHP 找不到

確認 PATH 有加入：

```text
C:\Users\User\xampp\php
```

然後重新開啟終端機。

確認：

```bash
php -v
```

---

## 18.3 View 找不到

確認：

```text
app/Views/
```

中的檔案名稱與：

```php
return view('clients/index');
```

是否一致。

例如：

```text
app/Views/clients/index.php
```

對應：

```php
view('clients/index')
```

---

## 18.4 Controller 找不到

確認：

```php
namespace App\Controllers;
```

以及 class 名稱：

```php
class Clients extends BaseController
```

Route：

```php
'Clients::index'
```

三者要一致。

---

## 18.5 Model 寫不進資料庫

首先檢查：

```php
protected $allowedFields = [
    ...
];
```

表單送出的欄位如果不在 `$allowedFields`，CI4 不會讓它直接寫入。

---

## 18.6 上傳成功但網站找不到照片

檢查：

```text
public/uploads/photos/
```

是否真的有檔案。

再檢查資料庫保存的檔名：

```text
photo
```

是否和實際檔案名稱一致。

---

## 18.7 刪除資料庫紀錄但檔案還在

這是檔案管理常見問題。

刪除照片/文件時，要同時：

```text
1. unlink() 實體檔案
2. 更新資料庫欄位
```

---

# 19. 這一階段完成的功能

目前這個階段已經建立：

- CI4 專案
- Route
- Controller
- View
- Model
- MySQL 資料庫連線
- 案主列表
- 案主新增
- 案主修改
- 案主刪除
- 案主詳細資料
- 案主照片上傳
- 案主文件上傳
- 修改時重新上傳照片
- 修改時重新上傳文件
- 刪除目前照片
- 刪除目前文件
- PDF 預覽
- Word 文件下載
- CSS 分離與整理
- Git / GitHub 專案版本管理

---

# 20. 後續開發方向

本 README 刻意把「身分驗證」獨立出去。

後續功能可以分成：

```text
目前已完成
│
├─ CI4 基礎
├─ CRUD
├─ 檔案上傳
├─ 檔案修改
├─ 檔案刪除
└─ 詳細資料
        │
        ▼
身分驗證系統
│
├─ Login
├─ Session
├─ Logout
├─ Staff
├─ Admin
├─ Super Admin
├─ Admin Invite
└─ AuthFilter
```

這樣可以讓專案的兩個主要部分分開理解：

```text
資料管理系統
        +
身分與權限管理系統
```

---

## CI4 開發時最重要的思考方式

遇到一個新功能時，可以先問自己：

```text
1. URL 是什麼？
       ↓
2. Route 要指向哪個 Controller？
       ↓
3. Controller 要做什麼？
       ↓
4. 是否需要 Model？
       ↓
5. 資料庫需要什麼資料？
       ↓
6. View 要顯示什麼？
       ↓
7. 是否需要驗證？
       ↓
8. 是否涉及檔案？
       ↓
9. 成功後 redirect 到哪裡？
       ↓
10. 失敗時怎麼處理？
```

這套思考方式比單純記住 CI4 語法更重要。

---

# 附錄：本專案目前的資料流

## 一般案主新增

```text
Browser
   ↓
GET /clients/create
   ↓
Clients::create()
   ↓
create.php
   ↓
使用者填寫表單
   ↓
POST /clients/store
   ↓
Clients::store()
   ↓
ClientModel
   ↓
MySQL
   ↓
redirect /clients
```

## 案主照片上傳

```text
使用者選擇照片
      ↓
POST
      ↓
Controller
      ↓
getFile()
      ↓
isValid()
      ↓
getRandomName()
      ↓
move()
      ↓
public/uploads/photos/
      ↓
檔名寫入 MySQL
```

## 案主照片刪除

```text
使用者按「刪除照片」
        ↓
Controller
        ↓
取得案主資料
        ↓
取得 photo 檔名
        ↓
找到實體檔案
        ↓
unlink()
        ↓
photo = NULL
        ↓
更新 MySQL
```

---

# 最後整理

這一階段最重要的不是背誦每一行程式，而是理解：

```text
Route
  ↓
Controller
  ↓
Model
  ↓
Database
```

以及：

```text
Controller
  ↓
View
```

檔案功能則多了一條：

```text
Controller
  ↓
UploadedFile
  ↓
public/uploads/
  +
Database 儲存檔名
```

因此「刪除檔案」也必須同時處理：

```text
實體檔案
+
資料庫欄位
```

這就是目前從傳統 PHP 專案逐步搬進 CI4 後，這一階段最重要的架構觀念。
