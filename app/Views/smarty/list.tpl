
{* 案主列表：Smarty 模板 *}
<!DOCTYPE html>
<html lang="zh-Hant">
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
            <div class="nav-dropdown">
                <button type="button" class="nav-link nav-dropdown-toggle"
                        aria-expanded="false" onclick="toggleNavDropdown(this)">
                    <span class="nav-icon">📋</span>
                    <span>案主專區</span>
                    <span class="nav-arrow">⌄</span>
                </button>
                <div class="nav-dropdown-menu">
                    <a href="{$baseUrl}/clients" class="nav-link active">
                        <span class="nav-icon">📇</span>
                        <span>案主列表</span>
                    </a>

                    <a href="{$baseUrl}/clients/deletelist" class="nav-link">
                        <span class="nav-icon">🗑️</span>
                        <span>已刪除案主</span>
                    </a>

                    <a href="{$baseUrl}/clients/map" class="nav-link">
                        <span class="nav-icon">🗺️</span>
                        <span>案主地圖</span>
                    </a>

                    {* admin 和 super_admin 才能新增案主 *}
                    {if $userRole == 'admin' || $userRole == 'super_admin'}
                        <a href="{$baseUrl}/clients/add" class="nav-link">
                            <span class="nav-icon">➕</span>
                            <span>新增案主</span>
                        </a>
                    {/if}
                </div>
            </div>

            {* 只有 super_admin 能管理人員及邀請碼 *}
            {if $userRole == 'super_admin'}
                <div class="nav-dropdown">
                    <button type="button" class="nav-link nav-dropdown-toggle"
                            aria-expanded="false" onclick="toggleNavDropdown(this)">
                        <span class="nav-icon">📋</span>
                        <span>人員專區</span>
                        <span class="nav-arrow">⌄</span>
                    </button>
                    <div class="nav-dropdown-menu">
                        <a href="{$baseUrl}/users" class="nav-link">
                            <span class="nav-icon">🛡️</span>
                            <span>人員管理</span>
                        </a>

                        <a href="{$baseUrl}/admin-invites/create" class="nav-link">
                            <span class="nav-icon">🔑</span>
                            <span>管理員邀請碼</span>
                        </a>
                    </div>
                </div>
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
                <h1>案主列表</h1>
                <p>查看及管理案主基本資料</p>

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

        {* 頁面內容 *}
        <section class="content-area">

            {* 路線篩選 *}
            <section class="filter-card">
                <form action="{$baseUrl}/clients" method="get" class="filter-form">
                    <div class="filter-field">
                        <label for="route_no">依配送路線篩選</label>
                        <input
                            type="text"
                            id="route_no"
                            name="route_no"
                            value="{$routeNo|default:''|escape}"
                            placeholder="請輸入路線編號"
                        >
                    </div>

                    <button type="submit" class="filter-button">
                        搜尋
                    </button>

                    <a href="{$baseUrl}/clients" class="reset-button">
                        清除條件
                    </a>
                </form>
            </section>

            {* 案主資料表格 *}
            <section class="table-card">
                <div class="table-heading">
                    <div>
                        <h3>案主名單</h3>
                        <p>目前查詢結果共 {$clients|count} 筆</p>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="client-table">
                        <thead>
                            <tr>
                                <th>案主編號</th>
                                <th>案主姓名</th>
                                <th>地址</th>
                                <th>配送路線</th>
                                <th>餐別</th>
                                <th>操作</th>
                            </tr>
                        </thead>

                        <tbody>
                            {foreach $clients as $client}
                                <tr>
                                    <td>
                                        <span class="client-id">
                                            #{$client.s_num|escape}
                                        </span>
                                    </td>

                                    <td class="client-name">
                                        {$client.ct_name|escape}
                                    </td>

                                    <td class="client-address">
                                        {$client.ct_addr|escape}
                                    </td>

                                    <td>
                                        <span class="route-badge">
                                            {$client.route_no|escape}
                                        </span>
                                    </td>

                                    <td>
                                        {if $client.meal_type == 1}
                                            <span class="meal-badge lunch">午餐</span>
                                        {elseif $client.meal_type == 2}
                                            <span class="meal-badge dinner">晚餐</span>
                                        {else}
                                            <span class="meal-badge">未設定</span>
                                        {/if}
                                    </td>

                                    <td>
                                        <div class="action-buttons">
                                            <a
                                                href="{$baseUrl}/clients/detail/{$client.s_num|escape}"
                                                class="action-button detail-button"
                                            >
                                                詳細
                                            </a>

                                            {if $userRole == 'admin' || $userRole == 'super_admin'}
                                                <a
                                                    href="{$baseUrl}/clients/edit/{$client.s_num|escape}"
                                                    class="action-button edit-button"
                                                >
                                                    修改
                                                </a>
                                                <a
                                                    href="{$baseUrl}/clients/delete/{$client.s_num|escape}"
                                                    class="action-button delete-button"
                                                >
                                                    刪除
                                                </a>
                                            {/if}
                                        </div>
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
    
    const currentPath = window.location.pathname;

    // 在案主列表、新增案主、修改案主、詳細資料頁面時，
    // 自動展開「案主列表」下拉選單
    if (
        /\/clients(?:\/|$)/.test(currentPath)
    ) {
        const clientDropdown = document.querySelector(
            '.nav-dropdown:has(a[href*="/clients"])'
        );

        if (clientDropdown) {
            clientDropdown.classList.add('open');

            const button = clientDropdown.querySelector(
                '.nav-dropdown-toggle'
            );

            if (button) {
                button.setAttribute('aria-expanded', 'true');
            }
        }
    }

    // 在人員管理、管理員邀請碼頁面時，
    // 自動展開「人員列表」下拉選單
    if (
        /\/users(?:\/|$)/.test(currentPath) ||
        /\/admin-invites(?:\/|$)/.test(currentPath)
    ) {
        const dropdowns = document.querySelectorAll('.nav-dropdown');

        dropdowns.forEach(function (dropdown) {
            if (
                dropdown.querySelector('a[href*="/users"]') ||
                dropdown.querySelector('a[href*="/admin-invites"]')
            ) {
                dropdown.classList.add('open');

                const button = dropdown.querySelector(
                    '.nav-dropdown-toggle'
                );

                if (button) {
                    button.setAttribute('aria-expanded', 'true');
                }
            }
        });
    }
});

function toggleNavDropdown(button) {
    const dropdown = button.closest('.nav-dropdown');

    if (!dropdown) {
        return;
    }

    dropdown.classList.toggle('open');

    const isExpanded = dropdown.classList.contains('open');

    button.setAttribute('aria-expanded', String(isExpanded));
}

</script>
{/literal}
</body>
</html>
