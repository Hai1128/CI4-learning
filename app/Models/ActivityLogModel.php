<?php

namespace App\Models;

use CodeIgniter\Model;

class ActivityLogModel extends Model
{
    protected $table = 'activity_logs';

    protected $primaryKey = 'id';

    protected $returnType = 'array';

    protected $useAutoIncrement = true;

    protected $allowedFields = [
        'user_id',
        'username',
        'user_role',
        'action',
        'client_id',
        'client_name',
        'created_at',
    ];

    protected $useTimestamps = false;
}

?>