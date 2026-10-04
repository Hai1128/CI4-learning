<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理員註冊</title>
</head>
<body>
    
    <h1>管理員註冊</h1>

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

    <form action="<?= base_url('register/admin') ?>" method="post">
        <div>
            <label for="username">帳號</label>
            <input type="text" id="username" name="username"
                value="<?= old('username') ?>" required>
        </div>

        <div>
            <label for="password">密碼</label>
            <input type="password" id="password" name="password"
                required>
        </div>

        <div>
            <label for="invite_code">管理員邀請碼</label>
            <input type="text" id="invite_code" name="invite_code"
                value="<?= old('invite_code') ?>" required>
        </div>

        <button type="submit">註冊管理員</button>
    </form>

</body>
</html>