# TSP Solver with Dynamic Programming

Program ini menyelesaikan **Travelling Salesman Problem (TSP)** menggunakan **Dynamic Programming** dalam bahasa Ruby. TSP adalah masalah pencarian rute minimum untuk mengunjungi semua kota sekali dan kembali ke kota awal.

## Struktur Folder

```
├── src/
│   └── tsp.rb
├── test/
│   ├── input
│   └── output
└── README.md
```

## Format Input

Input dibaca dari file teks dengan format berikut:

1. Baris pertama adalah jumlah kota `n`.
2. Diikuti oleh `n` baris berisi `n` angka yang mewakili matriks jarak antar kota.
3. Gunakan `-1` untuk menunjukkan **tidak ada jalur langsung antar dua kota** dan `0` untuk diagonal utama.


## Cara Menjalankan

1. Clone repository ini:

```bash
git clone https://github.com/JethroJNS/PR_STIMA_13523081_TSP.git
```

2. Navigasi ke direktori repositori dan jalankan command berikut:

```bash
ruby -d src/tsp.rb
```

## Pengembang

| **NIM**  | **Nama Anggota**               | **Github** |
| -------- | ------------------------------ | ---------- |
| 13523081 | Jethro Jens Norbert Simatupang | [JethroJNS](https://github.com/JethroJNS) |