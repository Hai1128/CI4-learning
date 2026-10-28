<?php

namespace App\Libraries;

use App\Models\ActivityLogModel;

class ActivityLogger
{
    public function log(
        string $action,
        int $clientId,
        ?string $clientName = null
    ): bool {
        $logModel = new \App\Models\ActivityLogModel();

        $result = $logModel->insert([
            'user_id' => session()->get('user_id'),
            'username' => session()->get('username') ?? 'unknown',
            'user_role' => session()->get('role'),
            'action' => $action,
            'client_id' => $clientId,
            'client_name' => $clientName,
        ]);

        return $result !== false;
    }
}

?>