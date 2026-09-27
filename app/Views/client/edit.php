<?php
/** @var array $client */
?>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>修改案主</title>

    <link rel="stylesheet" href="<?= base_url('css/common.css') ?>">
    <link rel="stylesheet" href="<?= base_url('css/client-form.css') ?>">
</head>
<body>
    
    <div class="client-form-container">

        <h1 class="client-form-title">修改案主</h1>

        <?php if (session()->get('errors')): ?>
            <div class="error-message">
                <?php foreach (session()->get('error') as $error): ?>
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

        <form  method="post" 
            action="<?= base_url('clients/update/' . $client['s_num']) ?>"
            enctype="multipart/form-data">

            <div class="form-group">
                <label for="ct_name">姓名：</label>
                <input type="text" id="ct_name" 
                    name="ct_name" value="<?= esc($client['ct_name']) ?>" required>
            </div>

            <div class="form-group">
                <label for="ct_addr">地址：</label>
                <input type="text" id="ct_addr" 
                    name="ct_addr" value="<?= esc($client['ct_addr']) ?>" required>
            </div>

            <div class="form-group">
                <label for="route_no">路線：</label>
                <input type="text" id="route_no" 
                    name="route_no" value="<?= esc($client['route_no']) ?>" required>
            </div>

            <div class="form-group">
                <label for="meal_type">餐別：</label>
                <select name="meal_type" id="meal_type" required>
                    <option value="1" <?= $client['meal_type'] == 1 ? 'selected' : '' ?>>
                        午餐
                    </option>
                    <option value="2" <?= $client['meal_type'] == 2 ? 'selected' : '' ?>>
                        晚餐
                    </option>
                </select>
            </div>

            <div class="form-group">
                <label>目前照片：</label>
                <?php if (!empty($client['photo'])): ?>

                    <img src="<?= base_url('clients/photo/' . $client['s_num']) ?>" 
                        alt="目前案主照片" class="edit-client-photo">

                <?php else: ?>

                    <p>尚未上傳照片</p>

                <?php endif; ?>
            </div>

            <div class="form-group">
                <label for="photo">重新上傳照片：</label>
                <input type="file" id="photo" name="photo" accept=".jpg,.jpeg,.png,.webp">

                <small>不選擇新照片則保留原照片，最大 5 MB。</small>
            </div>

            <div class="form-group">
                <label>目前文件：</label>
                <?php if (!empty($client['file'])): ?>

                    <p>
                        <?= htmlspecialchars(
                            $client['file'],
                            ENT_QUOTES,
                            'UTF-8'
                        ) ?>
                    </p>

                <?php else: ?>

                    <p>尚未上傳文件</p>

                <?php endif; ?>
            </div>

            <div class="form-group">
                <label for="file">重新上傳文件：</label>
                <input type="file" id="file" name="file" accept=".pdf,.doc,.docx">

                <small>不選擇新文件則保留原文件，最大 10 MB。</small>
            </div>

            <button type="submit" class="btn submit-btn">儲存修改</button>

            <a href="<?= base_url('clients') ?>" class="btn cancel-btn">取消</a>

        </form>

        <div class="delete-file-buttons">

            <?php if (!empty($client['photo'])): ?>
                <form method="post" action="<?= base_url('clients/delete-photo/' . $client['s_num']) ?>"
                    onsubmit="return confirm('確定要刪除目前照片嗎？');">
                    <button type="submit" class="btn delete-file-btn">
                        刪除目前照片
                    </button>
                </form>
            <?php endif; ?>

            <?php if (!empty($client['file'])): ?>
                <form method="post" action="<?= base_url('clients/delete-file/' . $client['s_num']) ?>"
                    onsubmit="return confirm('確定要刪除目前文件嗎？')">
                    <button type="submit" class="btn delete-file-btn">
                        刪除目前文件
                    </button>
                </form>
            <?php endif; ?>
        </div>
        
    </div>

</body>
</html>