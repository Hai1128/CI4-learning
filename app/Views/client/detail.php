<?php
/** @var array $client */
?>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>案主詳細資訊</title>

    <link rel="stylesheet" href="<?= base_url('css/common.css') ?>">
    <link rel="stylesheet" href="<?= base_url('css/client-detail.css') ?>">
</head>
<body>

    <div class="client-detail-container">
        <div class="client-detail-header">
            <h1>案主詳細資訊</h1>

            <a href="<?= base_url('clients') ?>" class="btn back-btn">
                返回列表
            </a>
        </div>

        <!-- 案主基本資料 -->

        <section class="detail-section">
            <h2>基本資料</h2>

            <div class="detail-row">
                <span class="detail-label">編號：</span>

                <span>
                    <?= htmlspecialchars(
                        $client['s_num'],
                        ENT_QUOTES,
                        'UTF-8'
                    ) ?>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">姓名：</span>

                <span>
                    <?= htmlspecialchars(
                        $client['ct_name'],
                        ENT_QUOTES,
                        'UTF-8'
                    ) ?>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">地址：</span>

                <span>
                    <?= htmlspecialchars(
                        $client['ct_addr'],
                        ENT_QUOTES,
                        'UTF-8'
                    ) ?>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">路線：</span>

                <span>
                    <?= htmlspecialchars(
                        $client['route_no'],
                        ENT_QUOTES,
                        'UTF-8'
                    ) ?>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">餐別：</span>

                <span>
                    <?php if ($client['meal_type'] == 1): ?>
                        午餐
                    <?php else: ?>
                        晚餐
                    <?php endif; ?>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">建立時間：</span>

                <span>
                    <?= htmlspecialchars(
                        $client['b_date'],
                        ENT_QUOTES,
                        'UTF-8'
                    ) ?>
                </span>
            </div>
        </section>

        <!-- 照片 -->
        <section class="detail-section">
            <h2>案主照片</h2>

            <?php if (!empty($client['photo'])): ?>
                <img src="<?= base_url('clients/photo/' . $client['s_num']) ?>" 
                    alt="案主照片" class="client-photo">
            <?php else: ?>
                <p>尚未上傳照片</p>
            <?php endif; ?>
        </section>

        <!-- 文件 -->
        <section class="detail-section">
            <h2>相關文件</h2>

            <?php if (!empty($client['file'])): ?>
                <p>
                    已上傳文件：
                    <?= htmlspecialchars(
                        $client['file'],
                        ENT_QUOTES,
                        'UTF-8'
                    ) ?>
                </p>

                <a href="<?= base_url('clients/file/' . $client['s_num']) ?>"
                    class="btn download-btn">
                    下載文件
                </a>

                <?php 
                    $extension = strtolower(
                        pathinfo($client['file'], PATHINFO_EXTENSION)
                    );
                ?>

                <?php if ($extension === 'pdf'): ?>
                    <h3>PDF 預覽</h3>

                    <iframe src="<?= base_url('clients/file-preview/' . $client['s_num']) ?>"
                        class="file-preview">
                    </iframe>
                <?php endif; ?>
            <?php else: ?>
                <p>尚未上傳文件。</p>
            <?php endif; ?>
        </section>

        <!-- 底部操作 -->
        <div class="detail-actions">
            <a href="<?= base_url('clients/edit/' . $client['s_num']) ?>"
                class="btn edit-btn">
                修改案主
            </a>

            <a href="<?= base_url('clients') ?>" class="btn back-btn">
                返回列表
            </a>
        </div>
    </div>

</body>
</html>