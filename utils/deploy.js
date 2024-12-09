const { deploy } = require("publish-avrae");

const devSourceMap = require("./sourcemap-dev.json");
const prodSourceMap = require("./sourcemap-prod.json");

const env = process.env.ENV || "Development";
const sourceMaps = {
  Development: devSourceMap,
  Production: prodSourceMap,
};

const sourceMap = sourceMaps[env];

if (!sourceMap) {
  throw new Error(`No sourcemap found for env ${env}.`);
}

console.log("Starting Deployment");
deploy(sourceMap)
  .then(() => console.log("Deployment Sucessful"))
  .catch((e) => {
    console.error(e);
    console.log("Deployment Failed");
    process.exit(1);
  });
