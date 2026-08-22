import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// Deployed to GitHub Pages as a project site, so everything is served from
// /MisandryMaxxing/ rather than the domain root. Anything referencing an asset
// by absolute path must go through import.meta.env.BASE_URL.
// https://vite.dev/config/
export default defineConfig({
  base: '/MisandryMaxxing/',
  plugins: [react()],
})
