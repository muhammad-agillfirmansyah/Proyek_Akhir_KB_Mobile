# Proyek_Akhir_KB_Mobile

1.) Tentang Aplikasi:
  Aplikasi ini merupakan sistem deteksi penyakit pada daun singkong yang bekerja secara otomatis melalui analisis gambar. Pengguna cukup mengunggah foto daun singkong, lalu aplikasi akan memproses gambar tersebut dan menampilkan hasil diagnosis. Aplikasi mampu     mengidentifikasi apakah daun dalam kondisi sehat atau mengalami gangguan, dengan fokus pada dua jenis penyakit utama: Penyakit Mosaik Singkong dan Hawar Bakteri Singkong.

  Selain fitur deteksi, aplikasi ini juga menyediakan halaman khusus berisi informasi lengkap mengenai penyakit daun singkong. Pada halaman ini, pengguna dapat mempelajari gejala penyakit, penyebab, dampak, serta pencegahannya. Dengan kombinasi deteksi otomatis dan informasi edukatif, aplikasi ini dirancang untuk membantu pengguna memantau kesehatan tanaman singkong secara cepat, akurat, dan mudah.


2.) Cara Menggunakan Aplikasi:
  Saat aplikasi dibuka, pengguna akan disambut dengan tampilan awal beserta tombol “Mulai”. Setelah tombol tersebut ditekan, pengguna akan diarahkan ke halaman utama yang berisi dua pilihan menu, yaitu Informasi Penyakit Daun Singkong dan Cek Daun Singkong.
  
  1. Informasi Penyakit Daun Singkong:
  Jika pengguna memilih menu informasi, aplikasi akan menampilkan halaman lanjutan yang berisi pilihan jenis penyakit, yaitu:
  -Hawar Bakteri Daun Singkong
  -Penyakit Mosaik Daun Singkong
  Setelah memilih salah satu penyakit, pengguna akan masuk ke halaman detail informasi yang mencakup penyebab, gejala, dampak, dan cara pencegahannya. Bagian ini dirancang untuk memberikan penjelasan yang mudah dipahami agar pengguna dapat mengenali ciri-ciri penyakit secara mandiri.
  
  2. Cek Daun Singkong:
  Jika pengguna memilih menu cek daun, aplikasi menyediakan opsi untuk mengunggah atau mengambil foto langsung dari daun singkong. Setelah gambar dipilih, pengguna dapat menekan tombol “Hasil Analisis”. Aplikasi akan memproses gambar tersebut dan menampilkan hasil deteksi, apakah daun singkong dalam keadaan sehat atau mengalami salah satu dari dua penyakit yang didukung oleh sistem.


3.) Cara Menjalankan Server:
  langkah-langkah berikut untuk menjalankan server Django dan menghubungkannya dengan aplikasi mobile:
  
  1. Pastikan Kedua Device Terhubung ke Jaringan yang Sama:
  Gunakan jaringan WiFi yang sama untuk laptop (server Django) dan HP (aplikasi mobile).
  Hal ini diperlukan agar HP dapat mengakses server yang berjalan di laptop.
  
  2. Dapatkan IP Address Laptop:
  Cari alamat IP laptop Anda, lalu gunakan IP tersebut di dalam file controller.dart sebagai base URL API.
  
  3. Jalankan Server Django:
  Buka terminal di VS Code, kemudian jalankan perintah berikut:
  python manage.py runserver 0.0.0.0:8000
  Perintah ini membuat server dapat diakses dari device lain dalam satu jaringan.
  
  4. Jalankan Aplikasi Mobile:
  Setelah server aktif dan IP sudah diatur di controller.dart, jalankan aplikasi mobile pada HP Anda.
  Aplikasi kini dapat terhubung ke server Django melalui jaringan lokal.
