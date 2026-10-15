-- Jalankan sekali di Supabase > SQL Editor
create table if not exists public.app_data(
  kind text not null check (kind in ('base','client','meta')),
  key text not null,
  value jsonb not null,
  updated_at timestamptz not null default now(),
  updated_by text,
  primary key (kind,key)
);
create index if not exists app_data_updated_idx on public.app_data(updated_at);

create or replace function public.app_data_touch() returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  new.updated_by := coalesce(auth.jwt()->>'email', new.updated_by);
  return new;
end $$;
drop trigger if exists app_data_touch on public.app_data;
create trigger app_data_touch before insert or update on public.app_data
  for each row execute function public.app_data_touch();

alter table public.app_data enable row level security;
drop policy if exists "tim baca" on public.app_data;
drop policy if exists "tim tulis" on public.app_data;
drop policy if exists "tim ubah" on public.app_data;
create policy "tim baca" on public.app_data for select to authenticated using (true);
create policy "tim tulis" on public.app_data for insert to authenticated with check (kind in ('client','meta'));
create policy "tim ubah" on public.app_data for update to authenticated
  using (kind in ('client','meta')) with check (kind in ('client','meta'));
-- tidak ada akses untuk anon; data 'base' (daftar klien) hanya bisa dibaca tim, tidak bisa diubah dari dashboard.
