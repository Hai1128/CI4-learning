<?php

    namespace App\Libraries;

    use Smarty\Smarty;

    class SmartyRenderer
    {
        protected Smarty $smarty;

        public function __construct()
        {
            $this->smarty = new Smarty();

            // Smarty 模板所在的位置
            $this->smarty->setTemplateDir(
                APPPATH . 'Views/smarty/'
            );

            // Smarty 編譯後的檔案
            $this->smarty->setCompileDir(
                WRITEPATH . 'cache/smarty/compile/'
            );

            // Smarty 快取檔案
            $this->smarty->setCacheDir(
                WRITEPATH . 'cache/smarty/cache/'
            );

            // 練習階段先關閉 Smarty 頁面快取
            $this->smarty->setCaching(
                Smarty::CACHING_OFF
            );
        }

        public function render(
            string $template,
            array $data = []
        ): string {
            // 將 Controller 傳來的資料交給 Smarty
            $this->smarty->assign($data);

            // 產生最後的 HTML
            return $this->smarty->fetch($template);
        }
    }
?>
