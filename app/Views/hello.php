<?php
/** @var string $name */ 
/*
$name 是一個 string 字串，而且這個變數是存在的。
讓下面的$name不要顯示紅色波浪底線
*/

?> 

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>Hello CI4</title>
</head>
<body>

    <h1>Hello <?= $name ?>！</h1>

</body>
</html>