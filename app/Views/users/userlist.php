<?php
/** @var array $users */
?>

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <title>人員管理</title>
</head>

<body>

    <h1>人員管理</h1>

    <a href="<?= base_url('clients') ?>">
        返回案主列表
    </a>

    <table border="1">

        <thead>
            <tr>
                <th>ID</th>
                <th>帳號</th>
                <th>身分</th>
            </tr>
        </thead>

        <tbody>

            <?php foreach ($users as $user): ?>

                <tr>

                    <td>
                        <?= htmlspecialchars(
                            $user['id'],
                            ENT_QUOTES,
                            'UTF-8'
                        ) ?>
                    </td>

                    <td>
                        <?= htmlspecialchars(
                            $user['username'],
                            ENT_QUOTES,
                            'UTF-8'
                        ) ?>
                    </td>

                    <td>

                        <?php if ($user['role'] === 'super_admin'): ?>

                            最高管理員

                        <?php elseif ($user['role'] === 'admin'): ?>

                            管理員

                        <?php else: ?>

                            一般人員

                        <?php endif; ?>

                    </td>

                </tr>

            <?php endforeach; ?>

        </tbody>

    </table>

</body>

</html>