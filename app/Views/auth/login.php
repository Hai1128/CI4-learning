<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>登入</title>

    <link rel="stylesheet" href="<?= base_url('css/common.css') ?>">
    <link rel="stylesheet" href="<?= base_url('css/login.css') ?>">
</head>
<body>

    <div class="login-container">

        <h1 class="login-title">登入</h1>

        <?php if (session()->getFlashdata('error')): ?>
            <p class="error-message">
                <?= esc(session()->getFlashdata('error')) ?>
            </p>
        <?php endif; ?>
        
        <form  method="post" action="<?= base_url('login/check') ?>">

            <div class="form-group">
                <label for="username">帳號：</label>
                <input type="text" id="username" name="username">
            </div>

            <div class="form-group">
                <label for="password">密碼：</label>
                <input type="password" id="password" name="password">
            </div>

            <button type="submit" class="btn login-btn">登入</button>
        </form>

    </div>

</body>
</html>