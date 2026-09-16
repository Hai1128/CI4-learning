<?php
/** @var array $clients */
?>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>案主列表</title>

    <link rel="stylesheet" href="<?= base_url('css/common.css') ?>">
    <link rel="stylesheet" href="<?= base_url('css/client-list.css') ?>">
</head>
<body>
    
    <div class="client-list-container">
        
        <!-- 頁面標題與操作 -->
        <div class="client-header">

            <h1>案主列表</h1>

            <div>
                <a href="<?= base_url('clients/add') ?>" class="btn add-btn">新增案主</a>
                <a href="<?= base_url('logout') ?>" class="btn logout-btn">登出</a>
            </div>

        </div>
        
        <hr>

        <!-- 歡迎訊息 -->
        <p class="welcome-message">
            歡迎 <?= htmlspecialchars(session()->get('nickname'), ENT_QUOTES, 'UTF-8') ?>
        </p>

        <!-- 搜尋 -->
        <form method="get" action="<?= base_url('clients') ?>" class="search-box">

            <label for="route_no">路線：</label>

            <input type="text" id="route_no" 
                name="route_no" placeholder="請輸入路線"
                value="<?= htmlspecialchars($_GET['route_no'] ?? '', ENT_QUOTES, 'UTF-8') ?>">

            <button type="submit" class="btn search-btn">搜尋</button>

        </form>

        <!-- 案主列表 -->
        <table class="client-table">

            <thead>
                <tr>
                    <th>編號</th>
                    <th>姓名</th>
                    <th>地址</th>
                    <th>路線</th>
                    <th>餐別</th>
                    <th>操作</th>
                </tr>
            </thead>

            <tbody>
                <?php foreach ($clients as $client): ?>
                    <tr>
                        <td>
                            <?= htmlspecialchars(
                                $client['s_num'],
                                ENT_QUOTES,
                                'UTF-8'
                            ) ?>
                        </td>
                        <td>
                            <?= htmlspecialchars(
                                $client['ct_name'],
                                ENT_QUOTES,
                                'UTF-8'
                            ) ?>
                        </td>
                        <td>
                            <?= htmlspecialchars(
                                $client['ct_addr'],
                                ENT_QUOTES,
                                'UTF-8'
                            ) ?>
                        </td>
                        <td>
                            <?= htmlspecialchars(
                                $client['route_no'],
                                ENT_QUOTES,
                                'UTF-8'
                            ) ?>
                        </td>
                        <td>
                            <?php if ($client['meal_type'] == 1): ?>
                                午餐
                            <?php else: ?>
                                晚餐
                            <?php endif; ?>
                        </td>
                        <td class="client-actions">
                            <a href="<?= base_url('clients/edit/' . $client['s_num']) ?>" class="btn edit-btn">
                                修改
                            </a>
                            <a href="<?= base_url('clients/delete/' . $client['s_num']) ?>" class="btn delete-btn">
                                刪除
                            </a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
            
        </table>

    </div>
</body>
</html>