# 🍽️ FoodWastey 🗑️

Proyek Akhir Semester PBP C — Kelompok C9.

## ℹ️ Deskripsi Aplikasi

FoodWastey Mobile adalah aplikasi versi mobile dari web [FoodWastey](https://github.com/pbp-kelompok-c9/foodwaste) yang dirancang untuk membantu mengurangi makanan terbuang pada acara melalui kerja sama dengan Event Organizer (EO). Aplikasi ini ditujukan untuk konser, acara keagamaan, kegiatan kampus, maupun acara berskala kecil. Makanan yang tidak termakan atau berlebih dapat dilaporkan oleh peserta agar penanganannya lebih teratur dan tidak langsung berakhir sebagai sampah.

Peserta yang sudah login dapat mengirim laporan ketersediaan makanan berisi foto, lokasi, jumlah porsi, tenggat waktu best before yang diketahui pelapor, dan opsi penjemputan. Admin dari pihak EO atau tim pengelola FoodWastey memeriksa laporan dan dapat menerima atau menolaknya apabila foto maupun informasi yang diberikan tidak sesuai ketentuan. Setelah laporan diterima dan kondisi makanan diperiksa, admin menentukan tindak lanjut berupa pengambilan, pengolahan, penjualan kembali, atau publikasi ulang untuk ditawarkan kepada peserta acara.

Nilai utama FoodWastey adalah menghubungkan laporan peserta dengan tindakan panitia dalam satu alur yang terpusat. Peserta mendapat cara praktis untuk melaporkan makanan, sementara EO dapat memantau ketersediaan dan proses penanganannya. Dengan demikian, aplikasi diharapkan membantu mengurangi makanan terbuang dan menjaga kebersihan lokasi setelah acara berakhir.

Alur aplikasi: peserta mengirim laporan → admin menerima atau menolak laporan → pemeriksaan dan penjemputan → admin menentukan penanganan atau menawarkan kembali makanan → selesai. Penerimaan laporan merupakan penerimaan untuk ditindaklanjuti, bukan sertifikasi kelayakan konsumsi. Kondisi makanan perlu diperiksa oleh petugas sebelum keputusan penanganan dibuat.

## ⚙️ Panduan Instalasi (Menjalankan Local)

Panduan instalasi menyusul.

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

Alur integrasi menyusul.
## 🎨 Desain Figma

[Desain FoodWastey di Figma](https://www.figma.com/design/wSGPDUl78i7Bzpfz7zeWil/Untitled?node-id=0-1&t=KkgO6a6FgNbzobOW-1)

## ⬇️ Tautan APK

Tautan APK menyusul.
