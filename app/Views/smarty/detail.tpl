 {* detail.tpl：案主詳細資料頁面 *}
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>案主詳細資訊</title>

    <link rel="stylesheet" href="{$baseUrl}/css/common.css">
    <link rel="stylesheet" href="{$baseUrl}/css/admin-layout.css">
    <link rel="stylesheet" href="{$baseUrl}/css/client-detail.css">
</head>
<body>

<div class="admin-layout">

    {* 左側側拉選單 *}
    <aside class="sidebar">
        <div class="sidebar-top">
            <button
                type="button"
                class="sidebar-toggle"
                id="sidebarToggle"
                aria-label="收合或展開側邊選單"
                aria-expanded="true"
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

    {* 右側主要區域 *}
    <div class="main-area">

        {* 置頂工具欄 *}
        <header class="topbar">
            <div class="topbar-heading">
                <h1>案主詳細資訊</h1>
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
                        {elseif $userRole == 'admin'}
                            管理員
                        {else}
                            一般人員
                        {/if}
                    </span>
                </div>

                <a href="{$baseUrl}/logout" class="logout-button">
                    登出
                </a>
            </div>
        </header>

        {* 頁面內容 *}
        <main class="page-content">
            <div class="client-detail-container">

                <div class="client-detail-header">
                    <h1>案主詳細資訊</h1>
                    <a href="{$baseUrl}/clients" class="btn back-btn">
                        返回列表
                    </a>
                </div>

                {* 案主基本資料 *}
                <section class="detail-section">
                    <h2>基本資料</h2>

                    <div class="detail-row">
                        <span class="detail-label">編號：</span>
                        <span>{$client.s_num|escape}</span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">姓名：</span>
                        <span>{$client.ct_name|escape}</span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">地址：</span>
                        <span>{$client.ct_addr|escape}</span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">路線：</span>
                        <span>{$client.route_no|escape}</span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">餐別：</span>
                        <span>
                            {if $client.meal_type == 1}
                                午餐
                            {else}
                                晚餐
                            {/if}
                        </span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">建立時間：</span>
                        <span>{$client.b_date|escape}</span>
                    </div>
                </section>

                {* 案主照片 *}
                <section class="detail-section">
                    <h2>案主照片</h2>

                    {if $client.photo}
                        <img
                            src="{$baseUrl}/clients/photo/{$client.s_num}"
                            alt="案主照片"
                            class="client-photo"
                        >
                    {else}
                        <p>尚未上傳照片</p>
                    {/if}
                </section>

                {* 相關文件 *}
                <section class="detail-section">
                    <h2>相關文件</h2>

                    {if $client.file}
                        <p>
                            已上傳文件：
                            {$client.file|escape}
                        </p>

                        <a
                            href="{$baseUrl}/clients/file/{$client.s_num}"
                            class="btn download-btn"
                        >
                            下載文件
                        </a>

                        {if $fileExtension == 'pdf'}
                            <h3>PDF 預覽</h3>

                            <iframe
                                src="{$baseUrl}/clients/file-preview/{$client.s_num}"
                                class="file-preview"
                                title="案主 PDF 文件預覽"
                            ></iframe>
                        {/if}
                    {else}
                        <p>尚未上傳文件。</p>
                    {/if}
                </section>

                {* 底部操作 *}
                <div class="detail-actions">
                    {if $userRole == 'admin' || $userRole == 'super_admin'}
                        <a
                            href="{$baseUrl}/clients/edit/{$client.s_num}"
                            class="btn edit-btn"
                        >
                            修改案主
                        </a>
                    {/if}

                    <a href="{$baseUrl}/clients" class="btn back-btn">
                        返回列表
                    </a>
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
