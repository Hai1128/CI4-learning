<?php
namespace App\Controllers;

use App\Models\UserModel;

class User extends BaseController
{
    public function index()
    {
        $userModel = new UserModel();

        $users = $userModel
            ->select('id, username, role')
            ->findAll();

        return view('users/userlist', [
            'users' => $users
        ]);
    }
}