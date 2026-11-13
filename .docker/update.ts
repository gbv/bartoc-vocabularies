#!/usr/bin/env -S deno run --allow-read --allow-run --allow-env --allow-sys --ext=ts

// Import zx for shell scripting
import { $, cd } from "npm:zx@7"

// Define base path
const basePath = "/bartoc-vocabularies"
const branch = Deno.env.get("BARTOC_BRANCH") || "main"
console.log("##########", new Date(), `Updating bartoc-vocabularies from origin/${branch}...`, "##########")

// Change to base path
await cd(basePath)

// Discover any changes from upstream
await $`git fetch --quiet origin ${branch}`
const updatedFiles = (await $`git diff --name-only HEAD FETCH_HEAD`.quiet())
  .stdout.split("\n")
  .filter(Boolean)

// If no changes, exit
if (updatedFiles.length === 0) {
  console.log("No changes from upstream. Nothing to do.")
  Deno.exit(0)
}

console.log(`Resetting local repo to origin/${branch}...`)
// Reset local repo to match the configured remote branch
await $`git reset --hard FETCH_HEAD`
console.log()

