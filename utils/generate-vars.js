/**
 * Convert dev and prod sourcemap gvars into a local var file for avrae-ls tests.
 * Mirrors westmarch-generic/utils/generate-vars.js.
 */
const { writeFileSync } = require("fs");
const prodSourceMap = require("./sourcemap-prod.json");
const devSourceMap = require("./sourcemap-dev.json");

const varFile = ".varfile.json";
const sources = [
  ["Development", devSourceMap],
  ["Production", prodSourceMap],
];

console.log("Development + Production starting update of var file.");

const varDict = {};
const collisions = [];
let sourceEntryCount = 0;

for (const [environment, { gvars }] of sources) {
  for (const { file, id, name } of gvars) {
    sourceEntryCount++;
    const existing = varDict[id];

    if (existing && existing.filePath !== file) {
      collisions.push(
        `${id}: ${existing.environment} ${existing.name} -> ${existing.filePath}; ${environment} ${name} -> ${file}`,
      );
      continue;
    }

    varDict[id] = { filePath: file, environment, name };
  }
}

if (collisions.length) {
  console.error("Cannot generate .varfile.json: sourcemap ids point at multiple files.");
  for (const collision of collisions) {
    console.error(`- ${collision}`);
  }
  process.exit(1);
}

const gvars = Object.fromEntries(
  Object.entries(varDict).map(([id, { filePath }]) => [id, { filePath }]),
);

writeFileSync(varFile, JSON.stringify({ gvars }, null, 4) + "\n");

console.log(
  `Development + Production var file updated with ${Object.keys(gvars).length} ids from ${sourceEntryCount} sourcemap entries.`,
);
