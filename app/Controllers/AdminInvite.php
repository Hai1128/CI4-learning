<?php

    namespace App\Controllers;

    use App\Models\AdminInviteModel;

    class AdminInvite extends BaseController
    {
        public function create()
        {
            $inviteModel = new AdminInviteModel();

            return view('admin_invites/create');
        }

        public function generate()
        {
            $inviteModel = new AdminInviteModel();

            //產生隨機邀請碼
            $inviteCode = strtoupper(
                bin2hex(random_bytes(6))
            );

            //設定邀請碼有效期限：1小時
            $expiresAt = date(
                'Y-m-d H:i:s',
                strtotime('+1 hour')
            );

            //寫入資料庫
            $inviteModel->insert([
                'invite_code' => $inviteCode,
                'is_used' => 0,
                'expires_at' => $expiresAt
            ]);

            //將邀請碼存在Session
            session()->setFlashdata('invite_code', $inviteCode);
            session()->setFlashdata('expires_at', $expiresAt);

            return redirect()->to('/admin-invites/create');
        }
    }

?>