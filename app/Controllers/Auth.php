<?php

    namespace App\Controllers;

    use App\Models\UserModel;

    use App\Models\AdminInviteModel;

    class Auth extends BaseController
    {
        public function login()
        {
            return view('auth/login');
        }

        public function register()
        {
            return view('auth/register');
        }

        public function registerStaff()
        {
            // 表單驗證規則
            $rules = [
                'username' => [
                    'rules' => 'required|min_length[3]|max_length[20]|regex_match[/^[A-Za-z0-9_.@-]+$/]',
                    'errors' => [
                        'required' => '請輸入帳號',
                        'min_length' => '帳號至少需要3個字元',
                        'max_length' => '帳號最多只能20個字元',
                        'regex_match' => '帳號只能使用英文字母、數字、底線、句號、減號和 @'
                    ]
                ],

                'password' => [
                    'roles' => 'required|min_length[8]',
                    'errors' => [
                        'required' => '請輸入密碼',
                        'min_length' => '密碼至少需要8個字元'
                    ]
                ]
            ];

            // 執行驗證
            if (!$this->validate($rules)) {
                return redirect()
                    ->to('/register')
                    ->withInput() //保留使用者輸入的資料
                    ->with('errors', $this->validator->getErrors());
            }

            // 取得表單資料
            $username = $this->request->getPost('username');
            $password = $this->request->getPost('password');

            $userModel =new UserModel();

            // 檢查帳號是否已經存在經存在
            $existingUser = $userModel
                ->where('username', $username)
                ->first();

            if ($existingUser) {
                session()->setFlashdata('error', '此帳號已經存在');

                return redirect()->to('/register');
            }

            //將密碼雜湊
            $hashedPassword = password_hash(
                $password,
                PASSWORD_DEFAULT
            );

            //建立一般人員
            $userModel->insert([
                'username' => $username,
                'password' =>$hashedPassword,
                'role' => 'staff'
            ]);

            session()->setFlashdata('success', '註冊成功！');

            return redirect()->to('/login');
        }

        public function registerAdminForm()
        {
            return view('auth/register_admin');
        }

        public function registerAdmin()
        {
            //表單驗證規則
            $rules = [
                'username' => [
                    'rules' => 'required|min_length[3]|max_length[20]|regex_match[/^[A-Za-z0-9_.@-]+$/]',
                    'errors' => [
                        'required' => '請輸入帳號',
                        'min_length' => '帳號至少需要3個字元',
                        'max_length' => '帳號最多只能20個字元',
                        'regex_match' => '帳號只能使用英文字母、數字、底線、句號、減號和 @'
                    ]
                ],

                'password' => [
                    'rules' => 'required|min_length[8]',
                    'errors' => [
                        'required' => '請輸入密碼',
                        'min_length' => '密碼至少需要8個字元'
                    ]
                ],

                'invite_code' => [
                    'rules' => 'required',
                    'errors' => [
                        'required' => '請輸入管理員邀請碼'
                    ]
                ]
            ];

            //執行驗證
            if (!$this->validate($rules)) {
                return redirect()
                    ->to('/register/admin')
                    ->withInput()
                    ->with('errors', $this->validator->getErrors());
            }

            //取得表單資料
            $username = $this->request->getPost('username');
            $password = $this->request->getPost('password');
            $inviteCode = $this->request->getPost('invite_code');

            //建立Model
            $userModel = new UserModel();
            $inviteModel = new AdminInviteModel();

            //檢查帳號是否已經存在
            $existingUser = $userModel
                ->where('username', $username)
                ->first();

            if ($existingUser) {
                return redirect()
                    ->to('/register/admin')
                    ->withInput()
                    ->with('error', '此帳號已經存在');
            }

            //查詢邀請碼
            $invite = $inviteModel
                ->where('invite_code', $inviteCode)
                ->first();

            //邀請碼不存在
            if (!$invite) {
                return redirect()
                    ->to('/register/admin')
                    ->withInput()
                    ->with('error', '邀請碼不存在');
            }

            //邀請碼已經使用
            if ($invite['is_used'] == 1) {
                return redirect()
                    ->to('/register/admin')
                    ->withInput()
                    ->with('error', '此邀請碼已被使用');
            }

            //邀請碼已過期
            if (strtotime($invite['expires_at']) < time()) {
                return redirect()
                    ->to('/register/admin')
                    ->withInput()
                    ->with('error', '此邀請碼已過期');
            }

            //將密碼雜湊
            $hashedPassword = password_hash(
                $password,
                PASSWORD_DEFAULT
            );

            //建立管理員
            $userModel->insert([
                'username' => $username,
                'password' => $hashedPassword,
                'role' => 'admin'
            ]);

            //將邀請碼標記為已使用
            $inviteModel->update(
                $invite['id'],
                ['is_used' => 1]
            );

            //註冊成功
            session()->setFlashdata(
                'success',
                '管理員註冊成功！'
            );

            return redirect()->to('/login');
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
                    'role' => $user['role'],
                    'isLoggedIn' => true           //設定登入狀態
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