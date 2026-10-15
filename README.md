# HydroClean Prioritas Dashboard (Supabase + Vercel)

Data klien dan progres tim disimpan di Supabase; HTML ini tidak lagi berisi data klien. Login wajib.

## Setup (sekali)
1. **Supabase**: buat project baru. Di *SQL Editor* jalankan `supabase/schema.sql`, lalu `PRIVATE-seed-data.sql` (file seed ada di luar folder repo ini, jangan di-commit).
2. **Akun tim**: *Authentication > Sign In / Providers > Email*: matikan **Allow new users to sign up**. Lalu *Authentication > Users > Add user* untuk tiap anggota (centang Auto Confirm User).
3. **config.js**: isi `url` (Project URL) dan `anonKey` (anon public) dari *Project Settings > API*. Jangan pakai service_role.
4. **GitHub**: buat repo **Private**, push isi folder ini.
5. **Vercel**: Add New > Project > import repo. Framework Preset: **Other**, tanpa build command, output directory kosong. Deploy.

## Pindah dari file lama
Di file HTML lama klik **Simpan file data**. Di dashboard baru login, klik **Buka file data**, pilih file itu. Seluruh progres lama langsung masuk ke database bersama.

## Catatan
- Tim saling melihat perubahan dalam maksimal 15 detik (dan saat tab dibuka lagi).
- Jika dua orang mengedit klien yang sama dalam waktu berdekatan, simpanan terakhir yang menang untuk klien itu. Bagi tugas per klien.
- Cadangan: tombol **Simpan file data** (JSON) dan backup harian Supabase.
- `vendor/supabase.js` = supabase-js 2.45.4 yang di-host sendiri (tanpa CDN).
