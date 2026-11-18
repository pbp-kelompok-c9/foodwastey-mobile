# 🍽️ FoodWastey 🗑️

Proyek Akhir Semester PBP C — Kelompok C9.

## ℹ️ Deskripsi Aplikasi

FoodWastey Mobile adalah aplikasi versi mobile dari web [FoodWastey](https://github.com/pbp-kelompok-c9/foodwaste) yang dirancang untuk membantu mengurangi makanan terbuang pada acara melalui kerja sama dengan Event Organizer (EO). Aplikasi ini ditujukan untuk konser, acara keagamaan, kegiatan kampus, maupun acara berskala kecil. Makanan yang tidak termakan atau berlebih dapat dilaporkan oleh peserta agar penanganannya lebih teratur dan tidak langsung berakhir sebagai sampah.

Peserta yang sudah login dapat mengirim laporan ketersediaan makanan berisi foto, lokasi, jumlah porsi, tenggat waktu best before yang diketahui pelapor, dan opsi penjemputan. Admin dari pihak EO atau tim pengelola FoodWastey memeriksa laporan dan dapat menerima atau menolaknya apabila foto maupun informasi yang diberikan tidak sesuai ketentuan. Setelah laporan diterima dan kondisi makanan diperiksa, admin menentukan tindak lanjut berupa pengambilan, pengolahan, penjualan kembali, atau publikasi ulang untuk ditawarkan kepada peserta acara.

Nilai utama FoodWastey adalah menghubungkan laporan peserta dengan tindakan panitia dalam satu alur yang terpusat. Peserta mendapat cara praktis untuk melaporkan makanan, sementara EO dapat memantau ketersediaan dan proses penanganannya. Dengan demikian, aplikasi diharapkan membantu mengurangi makanan terbuang dan menjaga kebersihan lokasi setelah acara berakhir.

Alur aplikasi: peserta mengirim laporan → admin menerima atau menolak laporan → pemeriksaan dan penjemputan → admin menentukan penanganan atau menawarkan kembali makanan → selesai. Penerimaan laporan merupakan penerimaan untuk ditindaklanjuti, bukan sertifikasi kelayakan konsumsi. Kondisi makanan perlu diperiksa oleh petugas sebelum keputusan penanganan dibuat.

## ⚙️ Panduan Instalasi (Menjalankan Local)

Prasyarat: Flutter 3.50 atau lebih baru (Dart ^3.13.7).

```bash
flutter pub get

# Memakai situs web di PWS (default)
flutter run

# Memakai server Django lokal (jalankan `python manage.py runserver` di repo web)
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000          # emulator Android
flutter run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:8000  # Flutter Web
```

## 👥 Anggota kelompok

| Nama | NPM | Program Studi | GitHub |
| --- | --- | --- | --- |
| Khansa Khairunnisa Haikal | 2506536465 | Sistem Informasi | [khansakkh](https://github.com/khansakkh) |
| Stefani Gwen Rolanda Tumbelaka | 2506594263 | Sistem Informasi | [stefanigwen14](https://github.com/stefanigwen14) |
| Muhammad Fatahillah Widodo | 2506623925 | Ilmu Komputer | [wmfatah](https://github.com/wmfatah) |
| Adinata Alaudin Pranaja | 2506656356 | Sistem Informasi | [adinatapranaja](https://github.com/adinatapranaja) |
| Angga Restha Rustyanto | 2506656444 | Ilmu Komputer | [AnggaRestha](https://github.com/AnggaRestha) |

## 💻 Modul dan PIC

Pembagian tanggung jawab pengembangan modul kelompok C9 adalah sebagai berikut.

| Modul | Deskripsi | PIC |
| --- | --- | --- |
| User & Authentication | Registrasi, login (termasuk Masuk dengan Google), logout, pengelolaan profil, hapus akun, serta direktori pengguna dengan kontak yang hanya terlihat oleh pengguna yang sudah login. | Adinata Alaudin Pranaja |
| Event Management | Membuat, melihat, mengubah, dan menghapus acara (CRUD) oleh EO, menampilkan detail acara, serta pencarian lokasi acara menggunakan Nominatim. | Khansa Khairunnisa Haikal |
| Food Waste Reporting | Membuat dan melihat laporan serta detail makanan sisa, meliputi foto, jenis makanan, jumlah porsi, tenggat best before, lokasi, dan opsi penjemputan. | Stefani Gwen Rolanda Tumbelaka |
| Food Waste Management | Memverifikasi dan menerima atau menolak laporan, memperbarui status penanganan, serta menentukan tindak lanjut berupa penjualan, pembagian, atau pengolahan makanan. | Angga Restha Rustyanto |
| Discovery & Dashboard | Pencarian dan penyaringan makanan, pengajuan pengambilan makanan beserta unggah bukti pengambilan, dashboard, serta statistik laporan dan penanganan makanan. | Muhammad Fatahillah Widodo |

## 👤 Peran dan target pengguna

| Peran | Target pengguna | Hak akses |
| --- | --- | --- |
| EO | Penyelenggara acara dalam Group `EO`, tanpa memerlukan staff | Membuat acara, mengubah/menghapus acara miliknya, dan membuat laporan. Tidak otomatis mendapat akses Kelola laporan. |
| Admin Mode | Staff pengelola laporan | Memeriksa foto dan informasi laporan, menerima atau menolak laporan, mengoordinasikan pengambilan, serta menentukan tindak lanjut makanan. |
| User Mode | Peserta acara yang sudah login | Melihat postingan, mengirim laporan ketersediaan makanan, dan mengajukan pengambilan makanan yang ditawarkan. |
| Pengunjung / Non-Role | Pengunjung yang belum login | Hanya melihat postingan; tidak dapat memposting laporan atau mengajukan pengambilan makanan. |

## 📲 Perbandingan aplikasi serupa

Surplus Indonesia dan Olio memiliki tujuan yang berkaitan dengan pengurangan pemborosan, tetapi pendekatannya berbeda dengan konsep FoodWastey.

| Aplikasi | Fokus dan mekanisme | Pembeda konsep FoodWastey |
| --- | --- | --- |
| Surplus Indonesia | Marketplace untuk penjualan stok berlebih dari mitra usaha kepada pelanggan. Mitra mengunggah produk melalui Surplus Merchant, sementara pelanggan membeli produk yang ditawarkan. Sumber: [Surplus Mitra](https://surplus.id/mitra/). | FoodWaste berangkat dari laporan peserta dalam suatu acara. Peserta dapat melaporkan makanan, lalu EO memeriksa dan menentukan tindak lanjutnya, termasuk opsi selain penjualan. |
| Olio | Berbagi makanan dan barang dalam komunitas lokal. Olio juga memiliki program Food Waste Heroes untuk pengambilan dan redistribusi makanan surplus dari bisnis. Sumber: [Olio](https://olioapp.com/en/) dan [Food Waste Heroes](https://olioapp.com/business/food-waste-heroes-programme/). | FoodWaste dirancang dengan acara sebagai pusat koordinasi: laporan peserta diteruskan ke admin EO untuk diperiksa, dijemput, dan ditangani atau ditawarkan kembali kepada peserta. |

Pembeda yang diusulkan adalah alur **peserta melapor → EO memoderasi → EO mengoordinasikan penanganan** dalam konteks acara yang sama. Perbandingan ini menekankan fokus rancangan FoodWaste, bukan klaim bahwa kompetitor tidak dapat melayani skala besar atau kegiatan katering.

## 🌐 Alur Integrasi Data

Data aplikasi tetap tersimpan di situs web Django [FoodWastey](https://github.com/pbp-kelompok-c9/foodwaste) yang di-deploy di PWS. Aplikasi mobile tidak menyimpan data statis; semua data diambil dan dikirim lewat web service Django REST Framework (DRF).

1. **Endpoint DRF di proyek Django.** Setiap modul menambahkan serializer dan view DRF di app Django-nya, lalu didaftarkan di bawah prefix `/api/`. Serializer memakai ulang validasi form yang sama dengan situs web sehingga aturan data di web dan mobile selalu sama.
2. **Login dan token.** Aplikasi mengirim `POST /api/auth/login/`. Django memeriksa username dan password, lalu mengembalikan token DRF (`rest_framework.authtoken`) beserta data akun dan perannya. Token disimpan di perangkat (`shared_preferences`) sehingga pengguna tetap login saat aplikasi dibuka ulang (dipulihkan lewat `GET /api/auth/me/`).
3. **Request terautentikasi.** `ApiClient` (`lib/core/api_client.dart`) otomatis menambahkan header `Authorization: Token <token>` ke setiap request. Di Django, `TokenAuthentication` mengenali pengguna sehingga `request.user` dan permission (EO, Admin) sama seperti di situs web.
4. **Pengolahan JSON.** Respons JSON di-decode, lalu diubah menjadi model Dart (mis. `Account.fromJson`) dan ditampilkan dengan widget. Error validasi DRF (`{"field": ["pesan"]}`) ditampilkan di bawah input yang bersangkutan.
5. **Sinkron dengan web.** Karena web dan mobile memakai database yang sama, data yang diubah di aplikasi langsung terlihat di situs web, dan sebaliknya.

Untuk modul lain, gunakan klien yang sama: `context.read<AuthService>().api.get('/api/...')`.

### Daftar endpoint

**User & Authentication** (`authentication/api_views.py`)

| Method | Endpoint | Akses | Fungsi |
| --- | --- | --- | --- |
| POST | `/api/auth/register/` | Publik | Registrasi akun (`username`, `email`, `password1`, `password2`) |
| POST | `/api/auth/login/` | Publik | Login, mengembalikan `token` dan `user` (termasuk peran `is_eo`, `is_admin`) |
| POST | `/api/auth/logout/` | Login | Logout dan mencabut token |
| GET | `/api/auth/me/` | Login | Akun sendiri (memulihkan sesi saat aplikasi dibuka) |

<!-- Modul lain: tambahkan tabel endpoint masing-masing di bawah ini. -->

### Branch

Setiap modul dikerjakan di branch `feature/<modul>` lalu digabung ke `main`, mengikuti repositori web.

| Modul | Branch |
| --- | --- |
| User & Authentication | `feature/authentication` |
| Food Waste Reporting | `feature/food-waste-reporting` |

## 🎨 Desain Figma

[Desain FoodWastey di Figma](https://www.figma.com/design/wSGPDUl78i7Bzpfz7zeWil/Untitled?node-id=0-1&t=KkgO6a6FgNbzobOW-1)

## ⬇️ Tautan APK

Tautan APK menyusul.
