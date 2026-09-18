<?php
    
    namespace App\Controllers;

    use App\Models\ClientModel; /*
        因為Model在app/Models/ClientModel.php，
        而它的namespace是App\Models;
        所以Controller要先告訴PHP：我要使用ClientModel
    */

    class Client extends BaseController
    {
        //顯示案主列表
        public function index()
        {
            $clientModel = new ClientModel(); /*
                建立一個ClientModel物件。
                ClientModel->知道要操作clients資料表
                前面ClientModel.php中寫protected $table = 'clients';
                所以CI4知道ClientModel->clients
            */

            //取得網址中的route_no
            $routeNo = $this->request->getGet('route_no'); //對應$routeNo = $_GET['route_no'];

            //只查詢沒有被軟刪除的案主
            $clientModel->where('d_date', null);

            //如果有輸入路線，就加入路線條件
            if ($routeNo !== null && $routeNo !== '') {
                $clientModel->where('route_no', $routeNo);
            }

            //排序：先路線，再案主編號
            $clientModel
                ->where('d_date', null) //WHERE d_date IS NULL
                ->orderBy('route_no', 'ASC') //ORDER BY route_no ASC
                ->orderBy('s_num', 'ASC'); //如果上面的route_no相同再按照s_num排序

            //查詢資料
            $clients = $clientModel->findAll(); /*
                findAll()意思是：把這個Model對應資料表的資料全部找出來
                $clientModel -> findAll() -> SELECT... -> clients
                CI4會幫你進行資料庫查詢，不需要自己寫SELECT * FROM clients
            */

            //傳給View
            $data = [
                'clients' => $clients
            ];

            return view('client/list', $data);
        }

        //顯示新增頁面
        public function add()
        {
            return view('client/add');
        }

        //儲存新增資料
        public function store()
        {
            $clientModel = new ClientModel();

            //取得上傳的照片
            $photo = $this->request->getFile('photo'); //對應name="photo"

            //取得上傳的文件
            $file = $this->request->getFile('file'); //對應name="file"

            $data = [
                'ct_name' => $this->request->getPost('ct_name'),
                'ct_addr' => $this->request->getPost('ct_addr'),
                'route_no' => $this->request->getPost('route_no'),
                'meal_type' => $this->request->getPost('meal_type'),
                'b_date' => date('Y-m-d H:i:s'),
            ];

            //處理照片
            //(有無收到檔案>檔案是否有效>是否沒被移動)
            if ($photo && $photo->isValid() && !$photo->hasMoved()) { 
                
                $photoName = $photo->getRandomName(); // 產生隨機檔名>避免不同使用者上傳同名檔案

                $photo->move(
                    WRITEPATH . 'uploads/clients', //把照片移到uploads；WRITEPATH>C:\Users\User\xampp\htdocs\my-project\writable\
                    $photoName
                ); //放在writeable不是pubic，如果在後者，使用者可以直接透過網址存取檔案

                $data['photo'] = $photoName; //最後把檔名存進資料庫
            }

            //處理文件
            if ($file && $file->isValid() && !$file->hasMoved()) {

                $fileName = $file->getRandomName();

                $file->move(
                    WRITEPATH . 'uploads/clients',
                    $fileName
                );

                $data['file'] = $fileName;
            }

            $clientModel->insert($data);

            return redirect()->to('/clients');
        }

        //顯示修改頁面
        public function edit($id)
        {
            $clientModel = new ClientModel();

            $client = $clientModel->find($id);

            $data = [
                'client' => $client
            ];

            return view('client/edit', $data);
        }

        //儲存修改資料
        public function update($id)
        {
            $clientModel = new ClientModel();

            $data = [
                'ct_name' => $this->request->getPost('ct_name'),
                'ct_addr' => $this->request->getPost('ct_addr'),
                'route_no' => $this->request->getPost('route_no'),
                'meal_type' => $this->request->getPost('meal_type')
            ]; //取得使用者修改後的資料

            //真正執行UPDATE的地方
            $clientModel->update($id, $data);

            return redirect()->to('/clients');
        }

        //刪除資料
        public function delete($id)
        {
            $clientModel = new ClientModel();

            $data = [
                'd_date' => date('Y-m-d H:i:s')
            ]; //設定刪除時間

            //更新指定案主
            $clientModel->update($id, $data);

            return redirect()->to('/clients');
        }
    }

?>