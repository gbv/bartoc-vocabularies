#!/usr/bin/env -S deno run --allow-read --allow-run --allow-env --allow-sys --ext=ts

// Import zx for shell scripting
import { $, cd } from "npm:zx@7"

// Define base path
const basePath = "/bartoc-vocabularies"
console.log("##########", new Date(), "Updating bartoc-vocabularies...", "##########")

// Change to base path
await cd(basePath)

// Discover any changes from upstream
const updatedFiles = (await $`git fetch --quiet && git diff --name-only @ @{u}`.quiet())
  .stdout.split("\n")
  .filter(Boolean)

// If no changes, exit
if (updatedFiles.length === 0) {
  console.log("No changes from upstream. Nothing to do.")
  Deno.exit(0)
}

// List updated files
console.log("Resetting local repo to origin/main...")
// Reset local repo to match origin/main
await $`git fetch`
await $`git reset --hard origin/main`
console.log()

Deno.exit(0)

