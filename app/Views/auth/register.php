<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>一般人員註冊</title>

    <link rel="stylesheet" href="<?= base_url('css/common.css') ?>">
    <link rel="stylesheet" href="<?= base_url('css/register.css') ?>">
</head>
<body>
    <div class="register-container">
        <h1 class="register-title">一般人員註冊</h1>

        <?php if (session()->getFlashdata('error')): ?>
            <p class="error-message">
                <?= htmlspecialchars(
                    session()->getFlashdata('error'),
                    ENT_QUOTES,
                    'UTF-8'
                ) ?>
            </p>
        <?php endif; ?>

        <?php $errors = session()->getFlashdata('errors'); ?>

        <?php if ($errors): ?>

            <div class="error-message">
                <?php foreach ($errors as $error): ?>
                    <p>
                        <?= htmlspecialchars(
                            $error,
                            ENT_QUOTES,
                            'UTF-8'
                        ) ?>
                    </p>
                <?php endforeach; ?>
            </div>

        <?php endif; ?>

        <form action="<?= base_url('register/staff') ?>" method="post">

            <div class="form-group">
                <label for="username">帳號</label>
                <input type="text" id="username" name="username" 
                    <?= old('username') ?> required>
            </div>

            <div class="form-group">
                <label for="password">密碼</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-group">
                <button type="submit" class="btn register-btn">註冊</button>
            </div>

            <div class="form-group">
                <a href="<?= base_url('login') ?>" class="btn register-btn">
                    返回
                </a>
            </div>


        </form>
    </div>
    
</body>
</html>