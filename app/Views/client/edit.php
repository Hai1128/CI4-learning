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

        <form  method="post" 
            action="<?= base_url('clients/update/' . $client['s_num']) ?>">

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

            <button type="submit" class="btn submit-btn">儲存修改</button>

            <a href="<?= base_url('clients') ?>" class="btn cancel-btn">取消</a>

        </form>

    </div>

</body>
</html>