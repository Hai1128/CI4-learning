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
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" crossorigin=""/>
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
            <div class="nav-dropdown">
                <button type="button" class="nav-link nav-dropdown-toggle"
                        aria-expanded="false" onclick="toggleNavDropdown(this)">
                    <span class="nav-icon">📋</span>
                    <span>案主專區</span>
                    <span class="nav-arrow">⌄</span>
                </button>
                <div class="nav-dropdown-menu">
                    <a href="{$baseUrl}/clients" class="nav-link">
                        <span class="nav-icon">📇</span>
                        <span>案主列表</span>
                    </a>

                    <a href="{$baseUrl}/clients/deletelist" class="nav-link">
                        <span class="nav-icon">🗑️</span>
                        <span>已刪除案主</span>
                    </a>

                    <a href="{$baseUrl}/clients/map" class="nav-link active">
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

    {* 右側主要區域 *}
    <div class="main-area">

        {* 置頂工具欄 *}
        <header class="topbar">
            <div class="topbar-heading">
                <h1>案主地圖</h1>
                <p>查看案主地址的地理位置</p>

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
        <main class="page-content">
            <section class="map-page">
                <div id="clientMapData" data-clients="{$clientsJson|escape:'html'}" hidden></div>
                <div class="client-map" id="clientMap"></div>

                <p id="mapMessage" class="map-message">
                    正在載入地圖......
                </p>
            </section>
        </main>
    </div>
</div>

{literal}
<script
    src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js">
</script>

<script>
document.addEventListener('DOMContentLoaded', function () {
    //側邊欄收合
    const layout = document.querySelector('.admin-layout');
    const toggleButton = document.getElementById('sidebarToggle');

    // 側邊欄收合按鈕
    // 即使目前頁面沒有這個按鈕，也不能中止後面的初始化
    if (layout && toggleButton) {
        toggleButton.addEventListener('click', function () {
            layout.classList.toggle('sidebar-collapsed');

            const isExpanded =
                !layout.classList.contains('sidebar-collapsed');

            toggleButton.setAttribute(
                'aria-expanded',
                String(isExpanded)
            );
        });
    }

    const currentPath = window.location.pathname;
    const dropdowns = document.querySelectorAll('.nav-dropdown');

    // 找出包含指定連結的下拉選單
    function findDropdown(linkSelector) {
        for (const dropdown of dropdowns) {
            if (dropdown.querySelector(linkSelector)) {
                return dropdown;
            }
        }
        return null;
    }

    // 自動展開下拉選單
    function openDropdown(dropdown) {
        if (!dropdown) {
            return;
        }

        dropdown.classList.add('open');

        const button = dropdown.querySelector(
            '.nav-dropdown-toggle'
        );

        if (button) {
            button.setAttribute('aria-expanded', 'true');
        }
    }

    // 案主列表、新增、修改、詳細資料、案主地圖
    if (/\/clients(?:\/|$)/.test(currentPath)) {
        openDropdown(findDropdown('a[href*="/clients"]'));
    }

    // 人員管理、管理員邀請碼
    if (
        /\/users(?:\/|$)/.test(currentPath) ||
        /\/admin-invites(?:\/|$)/.test(currentPath)
    ) {
        const usersDropdown =
            findDropdown('a[href*="/users"]') ||
            findDropdown('a[href*="/admin-invites"]');

        openDropdown(usersDropdown);
    }

    //初始化地圖
    const mapElement = document.getElementById('clientMap');
    const messageElement = document.getElementById('mapMessage');
    const dataElement = document.getElementById('clientMapData');

    if (!mapElement || typeof L === 'undefined') {
        if (messageElement) {
            messageElement.textContent =
                '地圖載入失敗，請檢查 Leaflet 與網路連線。';
        }
        return;
    }

    let clients = [];

    try {
        const rawData = dataElement.dataset.clients || '[]';

        console.log('Smarty 輸出的原始資料：', rawData);

        // 將 JSON 資料存入外層的 clients 變數
        clients = JSON.parse(rawData);

        console.log('解析後的案主資料：', clients);
        console.log('案主資料筆數：', clients.length);

        clients.forEach((client) => {
            const lat = Number(client.latitude);
            const lng = Number(client.longitude);

            console.log(
                '案主編號：', client.s_num,
                '緯度：', lat,
                '經度：', lng,
                '座標有效：',
                Number.isFinite(lat) &&
                Number.isFinite(lng) &&
                lat >= -90 && lat <= 90 &&
                lng >= -180 && lng <= 180
            );
        });
    } catch (error) {
        console.error('案主資料解析失敗：', error);
        messageElement.textContent = '案主資料讀取失敗，請查看 Console。';
        return;
    }

    // 初始化地圖
    const map = L.map('clientMap').setView([23.7, 121.0], 7);

    // 載入 OpenStreetMap 圖磚
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution:
            '&copy; <a href="https://www.openstreetmap.org/copyright">' +
            'OpenStreetMap</a> contributors'
    }).addTo(map);

    const bounds = [];

    clients.forEach(function (client) {
        const lat = Number(client.latitude);
        const lng = Number(client.longitude);

        // 排除沒有有效座標的案主
        if (
            client.latitude == null ||
            client.longitude == null ||
            client.latitude === '' ||
            client.longitude === '' ||
            !Number.isFinite(lat) ||
            !Number.isFinite(lng) ||
            lat < -90 || lat > 90 ||
            lng < -180 || lng > 180
        ) {
            return;
        }

        // 建立地圖標記
        const marker = L.marker([lat, lng]).addTo(map);

        // 建立標記的彈出視窗
        const popup = document.createElement('div');
        const name = document.createElement('strong');
        const address = document.createElement('div');

        name.textContent = client.ct_name || '未提供姓名';
        address.textContent = client.ct_addr || '未提供地址';

        popup.appendChild(name);
        popup.appendChild(address);

        marker.bindPopup(popup);

        // 記錄座標，供地圖自動調整範圍
        bounds.push([lat, lng]);
    });

    // 根據有效座標調整地圖範圍
    if (bounds.length > 0) {
        map.fitBounds(bounds, {
            padding: [30, 30],
            maxZoom: 15
        });

        messageElement.textContent =
            '地圖已載入，共顯示 ' + bounds.length + ' 位案主。';
    } else {
        messageElement.textContent =
            '地圖已載入，但目前沒有具有有效座標的案主。';
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
