<?php

use CodeIgniter\Router\RouteCollection;

/** @var RouteCollection $routes */

$routes->get('/clients', 'Client::index', ['filter' => 'auth']);

$routes->get('/clients/add', 'Client::add', ['filter' => 'auth']);

$routes->post('clients/store', 'Client::store', ['filter' => 'auth']);

$routes->get('/clients/edit/(:num)', 'Client::edit/$1', ['filter' => 'auth']);

$routes->post('/clients/update/(:num)', 'Client::update/$1', ['filter' => 'auth']);

$routes->get('/clients/delete/(:num)', 'Client::delete/$1', ['filter' => 'auth']);

$routes->get('/login', 'Auth::login');

$routes->post('/login/check', 'Auth::check');

$routes->get('/logout', 'Auth::logout');

$routes->get('/', 'Auth::login');