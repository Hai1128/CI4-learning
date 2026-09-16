<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>新增案主</title>

    <link rel="stylesheet" href="<?= base_url('css/common.css') ?>">
    <link rel="stylesheet" href="<?= base_url('css/client-form.css') ?>">
</head>
<body>
    <div class="client-form-container">

        <h1 class="client-form-title">新增案主</h1>

        <form  method="post" action="<?= base_url('clients/store') ?>">

            <div class="form-group">
                <label for="ct_name">姓名：</label>
                <input type="text" name="ct_name" id="ct_name" required>
            </div>

            <div class="form-group">
                <label for="ct_addr">地址：</label>
                <input type="text" name="ct_addr" id="ct_addr" required>
            </div>
            
            <div class="form-group">
                <label for="route_no">路線：</label>
                <input type="text" name="route_no" id="route_no" required>
            </div>

            <div class="form-group">
                <label for="meal_type">餐別：</label>
                <select name="meal_type" id="meal_type" required>
                    <option value="1">午餐</option>
                    <option value="2">晚餐</option>
                </select>
            </div>

            <button type="submit" class="btn submit-btn">新增</button>

            <a href="<?= base_url('clients') ?>" class="btn-cancel-btn">取消</a>
        </form>

    </div>

</body>
</html>