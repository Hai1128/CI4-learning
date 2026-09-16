<?php

    namespace App\Models; //告訴CI4「這個 PHP 類別位於 Models 這個區域」

    use CodeIgniter\Model;

    /*
        class ClientModel extends Model{}：
        代表ClientModel繼承CI4的Model，準備好很多資料庫操作功能
        例如：find()、findAll()、insert()、update()...
    */
    class ClientModel extends Model
    {
        protected $table = 'clients'; //這個Model對應到clients資料表
        protected $primaryKey = 's_num'; //告訴CI4，clients的主鍵不是預設的id，而是s_num

        protected $allowedFields = [  
            'ct_name',
            'ct_addr',
            'route_no',
            'meal_type',
            'b_date',
            'd_date'
        ];/*
            CI4重要的安全機制之一，告訴CI4哪些欄位允許透過Model寫入資料庫中
            而s_num是AUTO_INCREMENT主鍵，不需要自己新增
        */
    }

?>