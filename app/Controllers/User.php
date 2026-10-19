<?php
namespace App\Controllers;

use App\Models\UserModel;
use App\Libraries\SmartyRenderer;

class User extends BaseController
{
    public function index()
    {
        $userModel = new UserModel();

        $roleNo = $this->request->getGet('roleNo') ?? '';

        if ($roleNo !== null && $roleNo !== '') {
            $userModel->where('role', $roleNo);
        }

        $users = $userModel
            ->select('id, username, role')
            ->orderBy('id', 'ASC')
            ->findAll();

        $data = [
            'users' => $users,
            'roleNo' => $roleNo,
            'userRole' => session()->get('role'),
            'username' => session()->get('username'),
            'baseUrl' => rtrim(base_url(). '/'),

            'breadcrumbs' => [
                [
                    'label' => '人員列表',
                    'url' => '/users',
                ],
            ],
        ];

        $smarty = new SmartyRenderer;

        return $smarty->render('userlist.tpl', $data);
    }
}