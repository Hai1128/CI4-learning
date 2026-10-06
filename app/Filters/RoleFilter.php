<?php

    namespace App\Filters;

    use CodeIgniter\HTTP\RequestInterface;
    use CodeIgniter\HTTP\ResponseInterface;
    use CodeIgniter\Filters\FilterInterface;

    class RoleFilter implements FilterInterface
    {
        public function before(
            RequestInterface $request,
            $arguments = null
        ) {
            $userRole = session()->get('role');

            if (!$arguments || !in_array($userRole, $arguments)) {
                return redirect()->to('/clients');
            }
        }

        public function after(
            RequestInterface $request,
            ResponseInterface $response,
            $arguments = null
        ) {

        }
    }

?>