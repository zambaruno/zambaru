-- Desktop QR sign-in storage foundation, not yet deployed.
-- Apply separately to each project's Supabase database.
-- All access must go through authenticated server endpoints using service credentials.
-- No anon/authenticated direct access or RLS policies are granted.
create extension if not exists pgcrypto;

create table if not exists public.desktop_login_challenges (
  id uuid primary key default gen_random_uuid(),
  challenge_hash text not null unique,
  browser_binding_hash text not null,
  created_at timestamptz not null default now(),
  expires_at timestamptz not null,
  approved_by uuid references auth.users(id) on delete cascade,
  approved_at timestamptz,
  consumed_at timestamptz,
  constraint challenge_expiry_short check (expires_at <= created_at + interval '2 minutes'),
  constraint challenge_expiry_after_creation check (expires_at > created_at),
  constraint challenge_approval_consistency check (approved_at is null or approved_by is not null)
);

create table if not exists public.desktop_browser_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  device_label text not null default 'Browser',
  refresh_token_hash text not null unique,
  token_family_id uuid not null default gen_random_uuid(),
  created_at timestamptz not null default now(),
  last_activity_at timestamptz not null default now(),
  idle_expires_at timestamptz not null default (now() + interval '30 days'),
  revoked_at timestamptz,
  constraint idle_expiry_after_activity check (idle_expires_at >= last_activity_at)
);
create index if not exists desktop_browser_sessions_user_idx on public.desktop_browser_sessions(user_id, revoked_at);
create index if not exists desktop_browser_sessions_expiry_idx on public.desktop_browser_sessions(idle_expires_at);
create index if not exists desktop_login_challenges_expiry_idx on public.desktop_login_challenges(expires_at);

alter table public.desktop_login_challenges enable row level security;
alter table public.desktop_browser_sessions enable row level security;
revoke all on public.desktop_login_challenges from public, anon, authenticated;
revoke all on public.desktop_browser_sessions from public, anon, authenticated;

comment on table public.desktop_login_challenges is 'Server-only one-time desktop QR login challenges; hash random challenge tokens before storage.';
comment on table public.desktop_browser_sessions is 'Server-only revocable sessions with 30-day sliding inactivity expiry; rotate and hash refresh tokens.';
-- NOTE: This migration does not implement login APIs, token rotation, rate limiting,
-- user approval, cookies, or mobile scanner. Do not deploy UI claiming QR login works.
