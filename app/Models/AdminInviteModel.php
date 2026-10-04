<?php

    namespace App\Models; //此PHP類別屬於App\Models

    use CodeIgniter\Model; //引入CI4 Model

    class AdminInviteModel extends Model
    {
        protected $table = 'admin_invites'; //指定資料表

        protected $primaryKey = 'id'; //指定主鍵

        protected $allowedFields = [
            'invite_code',
            'is_used',
            'expires_at',
            'created_at',
        ];
    }

?>