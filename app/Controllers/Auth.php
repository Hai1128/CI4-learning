<?php

    namespace App\Controllers;

    use App\Models\UserModel;

    class Auth extends BaseController
    {
        public function login()
        {
            return view('auth/login');
        }

        public function check()
        {
            $username = $this->request->getPost('username');
            $password = $this->request->getPost('password');

            $userModel = new UserModel();

            $user = $userModel
                ->where('username', $username)
                ->first(); //正常情況下，同一個username只有一個使用者

            //先判斷$user有無找到，再確認使用者輸入的密碼是否符合資料庫中的加密密碼
            //password_verify會確認輸入明文密碼->password_verify->資料庫的password hash->true/false
            if ($user && password_verify($password, $user['password'])) {
                session()->set([ //登入成功建立session
                    'user_id' => $user['id'],         //現在登入的使用者
                    'username' => $user['username'],  //使用者帳號
                    'nickname' => $user['nickname'],  //使用者暱稱
                    'isLoggedIn' => true              //設定登入狀態
                ]);

                return redirect()->to('/clients'); //登入後導向案主列表
            }

            //Flashdata：在Session裡暫時放一個訊息，下一次頁面請求時可以使用
            session()->setFlashdata('error', '帳號或密碼錯誤');
            return redirect()->to('/login'); //登入失敗回到login
        }

        public function logout()
        {
            session()->destroy();

            return redirect()->to('/login');
        }
    }

?>