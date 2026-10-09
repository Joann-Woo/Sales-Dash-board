# Outlet performance dashboard

A single-page dashboard (plain JavaScript, built with Vite) that reads weekly outlet
sales from the Supabase table `outlet_weekly`.

## Run locally

Needs Node 20.19+ or 22.12+.

```bash
npm install
npm run dev        # http://localhost:5173
```

The included `.env` already points at your Supabase project. `.env.example` shows the format.

## Deploy to Vercel

1. Put this folder in a GitHub repository. `.env`, `node_modules` and `dist` are git-ignored on purpose.
2. In Vercel, click **Add New > Project** and import that repository. Vercel detects Vite automatically:
   the build command is `npm run build` and the output directory is `dist`.
3. Before deploying, open **Environment Variables** and add:

   | Name | Value |
   |---|---|
   | `VITE_SUPABASE_URL` | `https://ceirgojpcfcyxtjbneju.supabase.co` |
   | `VITE_SUPABASE_ANON_KEY` | your publishable key (`sb_publishable_…`) from Supabase > Project Settings > API Keys |

4. Click **Deploy**.

These values are built into the page when Vercel builds it. If you change them later,
redeploy so the change takes effect. If they're missing, the page shows a red banner
saying so.

## Where things live

- `src/main.js` has all the data loading in `loadData()`, plus the rendering code.
- `src/style.css` holds the styles.
- `setup.sql` creates the `outlet_weekly` table with a read-only policy and the original seed rows.
  It's for reference only; the table already exists.
