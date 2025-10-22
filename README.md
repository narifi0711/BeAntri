# BeAntri

Aplikasi antrian berbasis AI

Setelah clone repository:

Pada terminal folder laravel:

1.  Buat database di localhost
2.  Copy paste file .env.example, kemudian rename file hasil copy paste tadi menjadi .env
3.  Sesuaikan data di file .env dengan database localhost pada baris yang berisi:
    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=laravel
    DB_USERNAME=root
    DB_PASSWORD=
4.  Jalankan: php artisan migrate
5.  Jalankan: php artisan db:seed
6.  Jalankan: npm install vite
7.  Jalankan: npm run dev
8.  Jalankan: npm run build
9.  Jalankan: php artisan serve
10. Jalankan: php artisan key:generate
11. Login super admin =>
    username: uperadmin@beantri.com
    passowrd: password
    Login admin unit =>
    username: admin@allora.com
    passowrd: password
    Login user unit =>
    username: user@allora.com
    passowrd: password
