<?php

use CodeIgniter\Router\RouteCollection;

/** @var RouteCollection $routes */

/* =========================
   案主列表
========================= */
$routes->get('/clients', 'Client::index', 
    ['filter' => 'auth']);

/* =========================
   顯示新增頁面、新增案主
========================= */
$routes->get('/clients/add', 'Client::add', 
    ['filter' => ['auth','role:admin,super_admin']]);

$routes->post('clients/store', 'Client::store', 
    ['filter' => ['auth','role:admin,super_admin']]);

/* =========================
   顯示修改頁面、修改資料
========================= */
$routes->get('/clients/edit/(:num)', 'Client::edit/$1', 
    ['filter' => ['auth','role:admin,super_admin']]);

$routes->post('/clients/update/(:num)', 'Client::update/$1', 
    ['filter' => ['auth','role:admin,super_admin']]);

/* =========================
   刪除資料
========================= */
$routes->get('/clients/delete/(:num)', 'Client::delete/$1', 
    ['filter' => ['auth','role:admin,super_admin']]);

/* =========================
   登入、驗證、登出
========================= */
$routes->get('/', 'Auth::login');

$routes->get('/login', 'Auth::login');

$routes->post('/login/check', 'Auth::check');

$routes->get('/logout', 'Auth::logout');

/* =========================
   顯示註冊頁面、註冊使用者
========================= */
$routes->get('/register', 'Auth::register');

$routes->post('/register/staff', 'Auth::registerStaff');

$routes->get('/register/admin', 'Auth::registerAdminForm');

$routes->post('/register/admin', 'Auth::registerAdmin');

/* =========================
   詳細資料
========================= */
$routes->get('/clients/detail/(:num)', 'Client::detail/$1', 
    ['filter' => 'auth']);

/* =========================
   照片
========================= */
$routes->get('/clients/photo/(:num)', 'Client::photo/$1', 
    ['filter' => ['auth','role:staff,admin,super_admin']]);

/* =========================
   文件
========================= */
$routes->get('/clients/file/(:num)', 'Client::file/$1', 
    ['filter' => ['auth','role:staff,admin,super_admin']]);

/* =========================
   文件預覽
========================= */
$routes->get('/clients/file-preview/(:num)','Client::filePreview/$1', 
    ['filter' => ['auth','role:staff,admin,super_admin']]);

/* =========================
   刪除照片、文件
========================= */
$routes->post('/clients/delete-photo/(:num)', 'Client::deletePhoto/$1', 
    ['filter' => ['auth','role:admin,super_admin']]);

$routes->post('/clients/delete-file/(:num)', 'Client::deleteFile/$1', 
    ['filter' => ['auth','role:admin,super_admin']]);

/* =========================
   顯示頁面、產生邀請碼
========================= */
$routes->get('/admin-invites/create', 'AdminInvite::create', 
    ['filter' => ['auth', 'role:super_admin']]);

$routes->post('/admin-invites/generate', 'AdminInvite::generate', 
    ['filter' => ['auth', 'role:super_admin']]);

/* =========================
   使用者管理介面
========================= */
$routes->get('/users', 'User::index',
    ['filter' => ['auth', 'role:super_admin']]);