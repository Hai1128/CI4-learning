<?php

namespace App\Controllers;

use App\Libraries\SmartyRenderer;

class SmartyTest extends BaseController
{
    public function index()
    {
        $smarty = new SmartyRenderer();

        return $smarty->render('test.tpl', [
            'title' => 'Smarty 整合成功！',
            'message' => '這個頁面已經由 CI4 呼叫 Smarty 產生。'
        ]);
    }
}
?>