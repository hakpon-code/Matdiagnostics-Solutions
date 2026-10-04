-- À coller dans Supabase > SQL Editor > Run
create table public.clients (
  id bigint generated always as identity primary key,
  nom text not null check (char_length(nom) between 2 and 150),
  telephone text not null check (char_length(telephone) between 6 and 30),
  adresse text not null check (char_length(adresse) between 3 and 250),
  service text not null check (char_length(service) <= 200),
  prix integer not null check (prix >= 0 and prix <= 1000000),
  created_at timestamptz not null default now()
);
alter table public.clients enable row level security;
-- Les visiteurs peuvent seulement ENVOYER une demande
create policy "visiteurs: envoyer" on public.clients for insert to anon with check (true);
-- Seul l'admin connecté peut LIRE et SUPPRIMER
create policy "admin: lire" on public.clients for select to authenticated using (true);
create policy "admin: supprimer" on public.clients for delete to authenticated using (true);
