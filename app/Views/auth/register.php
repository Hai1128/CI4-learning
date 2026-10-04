<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>一般人員註冊</title>
</head>
<body>
    <h1>一般人員註冊</h1>

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

        <div>
            <label for="username">帳號</label>
            <input type="text" id="username" name="username" 
                <?= old('username') ?> required>
        </div>

        <div>
            <label for="password">密碼</label>
            <input type="password" id="password" name="password" required>
        </div>

        <button type="submit">註冊</button>
    </form>
</body>
</html>