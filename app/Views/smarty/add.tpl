<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增案主</title>

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
            <a href="{$baseUrl}/clients" class="nav-link">
                <span class="nav-icon">▦</span>
                <span>案主列表</span>
            </a>

            {if $userRole == 'admin' || $userRole == 'super_admin'}
                <a href="{$baseUrl}/clients/add" class="nav-link active">
                    <span class="nav-icon">＋</span>
                    <span>新增案主</span>
                </a>
            {/if}

            {if $userRole == 'super_admin'}
                <a href="{$baseUrl}/users" class="nav-link">
                    <span class="nav-icon">♙</span>
                    <span>人員管理</span>
                </a>

                <a href="{$baseUrl}/admin-invites/create" class="nav-link">
                    <span class="nav-icon">✉</span>
                    <span>管理員邀請碼</span>
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
                <h1>新增案主</h1>
                <p>建立新的案主資料</p>

                <nav class="breadcrumb" aria-label="麵包屑導覽">
                    {foreach $breadcrumbs as $item}
                        {if !$item@first}
                            <span class="breadcrumb-separator">/</span>
                        {/if}
                        
                        {if $item@last}
                            <span class="breadcrumb-current">
                                {$item.label|escape}
                            </span>
                        {else}
                            <a href="{$baseUrl}{$item.url|escape}"
                                class="breadcrumb-link">
                                {$item.label|escape}
                            </a>
                        {/if}
                    {/foreach}
                </nav>
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
                    action="{$baseUrl}/clients/store"
                    enctype="multipart/form-data"
                >
                    <div class="form-group">
                        <label for="ct_name">姓名：</label>
                        <input
                            type="text"
                            name="ct_name"
                            id="ct_name"
                            value="{$oldInput.ct_name|default:''|escape}"
                            required
                        >
                    </div>

                    <div class="form-group">
                        <label for="ct_addr">地址：</label>
                        <input
                            type="text"
                            name="ct_addr"
                            id="ct_addr"
                            value="{$oldInput.ct_addr|default:''|escape}"
                            required
                        >
                    </div>

                    <div class="form-group">
                        <label for="route_no">路線：</label>
                        <input
                            type="text"
                            name="route_no"
                            id="route_no"
                            value="{$oldInput.route_no|default:''|escape}"
                            required
                        >
                    </div>

                    <div class="form-group">
                        <label for="meal_type">餐別：</label>
                        <select name="meal_type" id="meal_type" required>
                            <option value="1"
                                {if ($oldInput.meal_type|default:'1') == '1'}selected{/if}>
                                午餐
                            </option>
                            <option value="2"
                                {if ($oldInput.meal_type|default:'1') == '2'}selected{/if}>
                                晚餐
                            </option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="photo">案主照片：</label>
                        <input
                            type="file"
                            id="photo"
                            name="photo"
                            accept=".jpeg,.jpg,.png,.webp"
                        >
                        <small>允許 JPG、JPEG、PNG、WEBP，最大 5 MB。</small>
                    </div>

                    <div class="form-group">
                        <label for="file">相關文件：</label>
                        <input
                            type="file"
                            id="file"
                            name="file"
                            accept=".pdf,.doc,.docx"
                        >
                        <small>允許 PDF、DOC、DOCX，最大 10 MB。</small>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn submit-btn">
                            新增案主
                        </button>

                        <a href="{$baseUrl}/clients" class="btn cancel-btn">
                            取消
                        </a>
                    </div>
                </form>

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
