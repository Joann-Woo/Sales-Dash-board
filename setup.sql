-- Outlet performance: table + seed data for the dashboard.
-- Run once in Supabase: Dashboard > SQL Editor > New query > paste > Run.
-- Safe to re-run: the table is created only if missing and rows upsert on (outlet, week).

create table if not exists public.outlet_weekly (
  outlet   text    not null,
  week     date    not null,
  sales    numeric not null,
  target   numeric not null,
  orders   integer not null,
  returns  integer not null,
  primary key (outlet, week)
);

-- The dashboard reads with the public anon key, so allow read-only access.
-- Inserts and updates still need the service role or the SQL editor.
alter table public.outlet_weekly enable row level security;

drop policy if exists "Public read outlet_weekly" on public.outlet_weekly;
create policy "Public read outlet_weekly"
  on public.outlet_weekly for select
  to anon, authenticated
  using (true);

insert into public.outlet_weekly (outlet, week, sales, target, orders, returns) values
  ('Tampines', '2026-09-07', 18400, 18000, 612,  9),
  ('Tampines', '2026-09-14', 16100, 18000, 540, 14),
  ('Tampines', '2026-09-21', 19200, 18000, 640,  8),
  ('Jurong',   '2026-09-07', 14200, 15000, 488, 11),
  ('Jurong',   '2026-09-14', 12600, 15000, 430, 19),
  ('Jurong',   '2026-09-21', 15300, 15000, 512, 10),
  ('Orchard',  '2026-09-07', 22500, 24000, 690, 12),
  ('Orchard',  '2026-09-14', 20100, 24000, 612, 21),
  ('Orchard',  '2026-09-21', 24800, 24000, 742,  9)
on conflict (outlet, week) do update set
  sales = excluded.sales,
  target = excluded.target,
  orders = excluded.orders,
  returns = excluded.returns;

-- Check: should return 9 rows.
select * from public.outlet_weekly order by outlet, week;
