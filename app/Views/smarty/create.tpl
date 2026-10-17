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
                <a href="{$baseUrl}/clients/add" class="nav-link">
                    <span class="nav-icon">＋</span>
                    <span>新增案主</span>
                </a>
            {/if}

            {if $userRole == 'super_admin'}
                <a href="{$baseUrl}/admin-invites/create" class="nav-link active">
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
                <h1>管理員邀請碼</h1>
                <p>產生管理員註冊邀請碼</p>
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
            
            {if $invite_code}
                <p>目前邀請碼：</p>

                <h2>{$invite_code|escape:'html':'UTF-8'}</h2>

                <p>有限期限：{$expires_at|escape:'html':'UTF-8'}</p>
            {/if}
                        
            <form action="{$baseUrl}/admin-invites/generate" method="post">
                <button type="submit">
                    產生邀請碼
                </button>
            </form>
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
