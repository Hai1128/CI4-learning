```smarty
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改案主</title>

    <link rel="stylesheet" href="{$baseUrl}/css/common.css">
    <link rel="stylesheet" href="{$baseUrl}/css/admin-layout.css">
    <link rel="stylesheet" href="{$baseUrl}/css/client-form.css">
</head>
<body>

<div class="admin-layout">

    <!-- 左側選單 -->
    <aside class="sidebar">

        <div class="sidebar-top">
            <button
                type="button"
                class="sidebar-toggle"
                id="sidebarToggle"
                aria-label="收合或展開側邊選單"
                aria-expanded="true"
                title="收合或展開選單"
            >
                <span></span>
                <span></span>
                <span></span>
            </button>

            <div class="sidebar-brand">
                <div class="brand-icon">C</div>
                <div class="brand-text">
                    <h2>案主管理系統</h2>
                    <p>Client Management</p>
                </div>
            </div>
        </div>

        <div class="sidebar-section-title">主要功能</div>

        <nav class="sidebar-nav">
            <a href="{$baseUrl}/clients" class="nav-link active">
                <span class="nav-icon">▦</span>
                <span>案主列表</span>
            </a>

            {if $userRole == 'admin' || $userRole == 'super_admin'}
                <a href="{$baseUrl}/clients/add" class="nav-link">
                    <span class="nav-icon">＋</span>
                    <span>新增案主</span>
                </a>
            {/if}

            {if $userRole == 'super_admin'}
                <a href="{$baseUrl}/admin-invites/create" class="nav-link">
                    <span class="nav-icon">✉</span>
                    <span>管理員邀請碼</span>
                </a>

                <a href="{$baseUrl}/users" class="nav-link">
                    <span class="nav-icon">♙</span>
                    <span>人員管理</span>
                </a>
            {/if}
        </nav>

        <div class="sidebar-footer">
            <span class="status-dot"></span>
            <span>系統正常運作</span>
        </div>

    </aside>

    <!-- 右側主要內容 -->
    <div class="main-area">

        <!-- 上方工具列 -->
        <header class="topbar">
            <div class="topbar-heading">
                <h1>修改案主</h1>
                <p>編輯案主基本資料及相關檔案</p>
            </div>

            <div class="topbar-user">
                <div class="user-avatar">
                    {if isset($username) && $username != ''}
                        {$username|escape|substr:0:1}
                    {else}
                        U
                    {/if}
                </div>

                <div class="user-info">
                    <span class="user-name">
                        {if isset($username) && $username != ''}
                            {$username|escape}
                        {else}
                            使用者
                        {/if}
                    </span>

                    <span class="user-role">
                        {if $userRole == 'super_admin'}
                            最高管理員
                        {else}
                            管理員
                        {/if}
                    </span>
                </div>

                <a href="{$baseUrl}/logout" class="logout-button">
                    登出
                </a>
            </div>
        </header>

        <!-- 頁面內容 -->
        <main class="content-area">

            <div class="page-intro">
                <div>
                    <h2>修改案主資料</h2>
                    <p>修改完成後，請按「儲存修改」保存資料。</p>
                </div>
            </div>

            <div class="client-form-container">

                <div class="client-form-header">
                    <h2 class="client-form-title">基本資料</h2>
                    <a href="{$baseUrl}/clients" class="btn cancel-btn">取消</a>
                </div>

                {if $errors}
                    <div class="error-message">
                        {foreach $errors as $error}
                            <p>{$error|escape}</p>
                        {/foreach}
                    </div>
                {/if}

                <form
                    method="post"
                    action="{$baseUrl}/clients/update/{$client.s_num}"
                    enctype="multipart/form-data"
                >
                    <div class="form-group">
                        <label for="ct_name">姓名：</label>
                        <input
                            type="text"
                            id="ct_name"
                            name="ct_name"
                            value="{$formData.ct_name|escape}"
                            required
                        >
                    </div>

                    <div class="form-group">
                        <label for="ct_addr">地址：</label>
                        <input
                            type="text"
                            id="ct_addr"
                            name="ct_addr"
                            value="{$formData.ct_addr|escape}"
                            required
                        >
                    </div>

                    <div class="form-group">
                        <label for="route_no">路線：</label>
                        <input
                            type="text"
                            id="route_no"
                            name="route_no"
                            value="{$formData.route_no|escape}"
                            required
                        >
                    </div>

                    <div class="form-group">
                        <label for="meal_type">餐別：</label>
                        <select name="meal_type" id="meal_type" required>
                            <option value="1"
                                {if $formData.meal_type == 1}selected{/if}>
                                午餐
                            </option>
                            <option value="2"
                                {if $formData.meal_type == 2}selected{/if}>
                                晚餐
                            </option>
                        </select>
                    </div>

                    <!-- 目前照片 -->
                    <div class="form-group">
                        <label>目前照片：</label>

                        {if $client.photo}
                            <img
                                src="{$baseUrl}/clients/photo/{$client.s_num}"
                                alt="目前案主照片"
                                class="edit-client-photo"
                            >
                        {else}
                            <p>尚未上傳照片</p>
                        {/if}
                    </div>

                    <!-- 重新上傳照片 -->
                    <div class="form-group">
                        <label for="photo">重新上傳照片：</label>
                        <input
                            type="file"
                            id="photo"
                            name="photo"
                            accept=".jpg,.jpeg,.png,.webp"
                        >
                        <small>不選擇新照片則保留原照片，最大 5 MB。</small>
                    </div>

                    <!-- 目前文件 -->
                    <div class="form-group">
                        <label>目前文件：</label>

                        {if $client.file}
                            <p>{$client.file|escape}</p>
                        {else}
                            <p>尚未上傳文件</p>
                        {/if}
                    </div>

                    <!-- 重新上傳文件 -->
                    <div class="form-group">
                        <label for="file">重新上傳文件：</label>
                        <input
                            type="file"
                            id="file"
                            name="file"
                            accept=".pdf,.doc,.docx"
                        >
                        <small>不選擇新文件則保留原文件，最大 10 MB。</small>
                    </div>

                    <button type="submit" class="btn submit-btn">
                        儲存修改
                    </button>

                    <a href="{$baseUrl}/clients" class="btn cancel-btn">
                        取消
                    </a>
                </form>

                <!-- 刪除既有照片或文件 -->
                <div class="delete-file-buttons">

                    {if $client.photo}
                        <form
                            method="post"
                            action="{$baseUrl}/clients/delete-photo/{$client.s_num}"
                            onsubmit="return confirm('確定要刪除目前照片嗎？');"
                        >
                            <button type="submit" class="btn delete-file-btn">
                                刪除目前照片
                            </button>
                        </form>
                    {/if}

                    {if $client.file}
                        <form
                            method="post"
                            action="{$baseUrl}/clients/delete-file/{$client.s_num}"
                            onsubmit="return confirm('確定要刪除目前文件嗎？');"
                        >
                            <button type="submit" class="btn delete-file-btn">
                                刪除目前文件
                            </button>
                        </form>
                    {/if}

                </div>

            </div>
        </main>
    </div>
</div>

{literal}
<script>
document.addEventListener('DOMContentLoaded', function () {
    const layout = document.querySelector('.admin-layout');
    const toggleButton = document.getElementById('sidebarToggle');

    if (!layout || !toggleButton) {
        return;
    }

    toggleButton.addEventListener('click', function () {
        layout.classList.toggle('sidebar-collapsed');

        const isExpanded =
            !layout.classList.contains('sidebar-collapsed');

        toggleButton.setAttribute(
            'aria-expanded',
            String(isExpanded)
        );
    });
});
</script>
{/literal}

</body>
</html>
```