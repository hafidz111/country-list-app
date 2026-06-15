# 🌍 Country List App

**Country List App** adalah aplikasi seluler yang dirancang untuk menampilkan daftar lengkap negara beserta informasi detailnya, seperti ibukota dan bendera. Aplikasi ini didukung oleh **REST Countries API** dan dirancang untuk memberikan performa yang cepat dan efisien melalui optimasi modern seperti *pagination*, *caching*, dan *lazy loading*.

Country List App hadir dengan antarmuka yang simpel namun responsif, mempermudah pengguna untuk menjelajah dan mencari data negara dengan cepat.

---

## 🖼️ Tampilan Aplikasi

Country List App 

<img width="962" height="1029" alt="Country List App" src="https://github.com/user-attachments/assets/0aab21db-a632-4c32-b6cf-804c0e225298" />

---

## ✨ Fitur Utama

### 🔐 Autentikasi Pengguna (Fake Login)
- Simulasi fitur Login menggunakan *username* dan *password*
- Penyimpanan status *login* secara lokal di memori perangkat
- Auto-login jika aplikasi dibuka kembali
- Fitur **Logout** untuk menghapus sesi

---

### 🔎 Pencarian & Daftar Negara
- Menampilkan nama negara, ibukota, dan bendera
- **Search Debouncing**: Fitur pencarian yang hanya memanggil API setelah jeda waktu ketikan
- Sinkronisasi langsung ke **REST Countries API v5**

---

### 🚀 Optimasi Performa
- **Pagination (Infinite Scrolling)**: Memuat data per halaman saat pengguna melakukan *scroll* ke bagian bawah layar
- **Skeleton Loading**: Animasi *loading* modern menggunakan `skeletonizer` yang otomatis menyesuaikan bentuk elemen UI saat data sedang dimuat
- **Image Caching**: Menggunakan memori internal perangkat untuk menyimpan gambar bendera, sehingga tidak perlu mengunduh ulang gambar yang sama

---

## 💻 Teknologi yang Digunakan

| Kategori | Teknologi | Keterangan |
|----------|------------|------------|
| Framework | Flutter | UI & Cross-platform |
| State Management | GetX | State, Dependency Injection, & Routing |
| Network | Dio | Integrasi REST API (HTTP Request) |
| Local Storage | SharedPreferences | Manajemen Sesi Login |
| Image Management| CachedNetworkImage | Penyimpanan Cache Gambar Bendera |
| UI Experience | Skeletonizer | Animasi Skeleton Loading |
| Environment | Flutter Dotenv | Konfigurasi API Key di `.env` |

---

## 📂 Struktur State Management & Controller

### AuthController (GetX)
- Menangani alur Login
- Mengecek status Login saat aplikasi dimulai
- Menangani Logout dan penghapusan sesi (`SharedPreferencesService`)

### HomeController (GetX)
- Menyimpan *list* data `CountryModel`
- Mengatur status *loading* dan *load more* (*Pagination*)
- Menangani fungsi debounce pada pencarian *(Search)*
- Menyambungkan UI dengan `ApiService`

### ApiService
- Menyediakan metode `getCountries` dengan limit dan offset
- Menyediakan metode `searchCountries` berdasarkan kata kunci
- Mengelola header `Authorization` menggunakan variabel dari `.env`

### SharedPreferencesService
- Mengelola operasi baca/tulis untuk sesi pengguna (`is_logged_in`, `username`, `password`)

---

## 🔄 Alur Kerja Aplikasi

1. **User membuka aplikasi**. Sistem memeriksa status *login* melalui `SharedPreferences`.
2. Jika belum *login*, user diarahkan ke **Halaman Login**. Jika sudah, langsung ke **Halaman Home**.
3. Saat user *login*, kredensial disimpan ke penyimpanan lokal.
4. Di **Halaman Home**, sistem mengambil data negara pertama (20 negara) dari REST Countries API. Saat menunggu, UI menampilkan efek **Skeleton**.
5. User dapat melakukan *scroll* ke bawah untuk memuat data negara berikutnya (*Infinite Scroll*).
6. User mengetikkan kata kunci di kotak pencarian. Setelah jeda 500ms, aplikasi akan mencari negara yang cocok via API.
7. User dapat menekan ikon *Logout* untuk kembali ke halaman Login dan membersihkan sesi.
