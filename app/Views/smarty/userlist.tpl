
{* 人員列表：Smarty模板 *}
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>案主管理系統</title>

    <link rel="stylesheet" href="{$baseUrl}/css/common.css">
    <link rel="stylesheet" href="{$baseUrl}/css/client-list.css">
    <link rel="stylesheet" href="{$baseUrl}/css/admin-layout.css">
</head>
<body>

<div class="admin-layout">
    {* 左側選單 *}
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

            {* admin 和 super_admin 才能新增案主 *}
            {if $userRole == 'admin' || $userRole == 'super_admin'}
                <a href="{$baseUrl}/clients/add" class="nav-link">
                    <span class="nav-icon">＋</span>
                    <span>新增案主</span>
                </a>
            {/if}

            {* 只有 super_admin 能管理人員及邀請碼 *}
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

    {* 右側主要內容 *}
    <main class="main-area">
        {* 上方工具列 *}
        <header class="topbar">
            <div class="topbar-heading">
                <h1>人員列表</h1>
                <p>查看及管理人員帳密</p>

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

        <section class="content-area">
            
            {* 身分篩選 *}
            <section class="filter-card">
                <form action="{$baseUrl}/users" method="get" class="filter-form">
                    <div class="filter-field">
                        <label for="roleNo">依身分篩選</label>
                        <select name="roleNo" id="roleNo">
                            <option value=""
                                {if $roleNo == ''}selected{/if}></option>
                            <option value="staff"
                                {if $roleNo == 'staff'}selected{/if}>
                                一般人員
                            </option>
                            <option value="admin"
                                {if $roleNo == 'admin'}selected{/if}>
                                管理員
                            </option>
                            <option value="super_admin"
                                {if $roleNo == 'super_admin'}selected{/if}>
                                最高管理員
                            </option>
                        </select>
                    </div>

                    <button type="submit" class="filter-button">
                        搜尋
                    </button>

                    <a href="{$baseUrl}/users" class="reset-button">
                        清除條件
                    </a>
                </form>
            </section>

            {* 人員資料表格 *}
            <section class="table-card">
                <div class="table-heading">
                    <div>
                        <h3>人員名單</h3>
                        <p>目前查詢結果共 {$users|count} 筆</p>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="client-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>帳號</th>
                                <th>身分</th>
                            </tr>
                        </thead>

                        <tbody>
                            {foreach $users as $user}
                                <tr>
                                    <td>
                                        <span class="client-id">
                                            #{$user.id|escape}
                                        </span>
                                    </td>
                                    <td class="client-name">
                                        {$user.username|escape}
                                    </td>
                                    <td>
                                        {if $user.role == 'staff'}
                                            <span class="">一般人員</span>
                                        {elseif $user.role == 'admin'}
                                            <span class="">管理員</span>
                                        {else}
                                            <span class="">最高管理員</span>
                                        {/if}
                                    </td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="6" class="empty-state">
                                        <div class="empty-icon">▤</div>
                                        <strong>目前沒有案主資料</strong>
                                        <p>請確認篩選條件，或稍後再試。</p>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </section>

            <footer class="page-footer">
                案主管理系統
            </footer>

        </section>
    </main>
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