// @ts-check
/** @typedef {import("./types").source_map} source_map */

const devSourceMap = require("./sourcemap-dev.json");
const prodSourceMap = require("./sourcemap-prod.json");
const { deployGvar } = require("./deploy-gvar");
const { deployAliases } = require("./deploy-alias");
const { readSyncEnv } = require("./read-file-sync-environment");

const env = process.env.ENV || "Development";

/** @type {source_map} */
// @ts-ignore
const source_map = env === "Production" ? prodSourceMap : devSourceMap;

const { workshop, aliases, gvars, snippets, environment } = source_map;

new Promise(async (success, reject) => {
  try {
    console.log(`--- Updating GVars ---`);
    for (var { gvar_id, name, file } of gvars.values()) {
      console.log(`Updating gvar "${name}"`);
      const code = readSyncEnv(file, environment);
      await deployGvar(gvar_id, name, code);
    }

    console.log(`\n--- Updating Aliases ---`);
    for (var alias of aliases) {
      console.log(`Updating alias category "${alias.group_name}"`);
      await deployAliases(workshop.id, alias, environment);
    }

    success(true);
  } catch (error) {
    // Propagate specific error without crashing
    reject(error);
  }
})
  .then((success) => {
    console.log("\nReached end without errors.");
  })
  .catch((failure) => {
    console.error("\n--- ERROR ---");
    console.error(failure);
  });
