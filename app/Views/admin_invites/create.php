<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理員邀請碼</title>
</head>
<body>
    
    <h1>管理員邀請碼</h1>

    <?php if (session()->getFlashdata('invite_code')): ?>

        <p>目前邀請碼：</p>

        <h2>
            <?= htmlspecialchars(
                session()->getFlashdata('invite_code'),
                ENT_QUOTES,
                'UTF-8'
            ) ?>
        </h2>

        <p>
            有效期限：
            <?= htmlspecialchars(
                session()->getFlashdata('expires_at'),
                ENT_QUOTES,
                'UTF-8'
            ) ?>
        </p>

    <?php endif; ?>

    <form action="<?= base_url('admin-invites/generate') ?>" method="post">
        <button type="submit">
            產生邀請碼
        </button>
    </form>

</body>
</html>