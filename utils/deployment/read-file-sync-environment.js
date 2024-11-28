// @ts-check
const { readFileSync } = require("fs");

/**
 * Reads the file and replaces 'using(env="...")' with current environment id
 * @param {string} file
 * @param {string} environment 
 * @returns {string}
 */
function readSyncEnv(file, environment) {
  const fileContents = readFileSync(file).toString();
  return fileContents.replace(/using\(env=.*\)/g, `using(env="${environment}")`);
}
 
module.exports = {readSyncEnv};