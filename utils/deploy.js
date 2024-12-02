const fs = require("fs");

const devSourceMap = require("./sourcemap-dev.json");
const prodSourceMap = require("./sourcemap-prod.json");
const { getWorkshop } = require("./avrae/get-workshop");
const { getAlias } = require("./avrae/get-alias");
const { setEnvironmentId } = require("./set-environment-id");
const { updateAlias } = require("./avrae/update-alias");
const { getSnippet } = require("./avrae/get-snippet");
const { updateSnippet } = require("./avrae/update-snippet");
const { updateGvar } = require("./avrae/update-gvar");
const { getGvar } = require("./avrae/get-gvar");

const env = process.env.ENV || "Development";
const sourceMaps = {
  Development: devSourceMap,
  Production: prodSourceMap,
};

const sourceMap = sourceMaps[env];

if (!sourceMap) {
  throw new Error(`No sourcemap found for env ${env}.`);
}

function hydrateSourceMap(sourceMap, workshop) {
  sourceMap.aliases.forEach((sourceMapAlias) => {
    const workshopAlias = workshop.aliases.find(
      ({ name: workshopAliasName }) =>
        sourceMapAlias.name === workshopAliasName,
    );

    if (!workshopAlias) {
      throw new Error(
        `Alias ${sourceMapAlias.name} does not exist in the workshop.`,
      );
    }

    sourceMapAlias.id = workshopAlias._id;

    sourceMapAlias.sub_aliases.forEach((sourceMapSubAlias) => {
      const workshopSubCommand = workshopAlias.subcommands.find(
        ({ name: subCommandName }) => subCommandName === sourceMapSubAlias.name,
      );

      if (!workshopSubCommand) {
        throw new Error(
          `Alias ${sourceMapAlias.name} sub alias ${sourceMapSubAlias.name} does not exist in the workshop.`,
        );
      }

      sourceMapSubAlias.id = workshopSubCommand._id;
    });
  });
  sourceMap.snippets.forEach((sourceMapSnippet) => {
    const workshopSnippet = workshop.snippets.find(
      ({ name: workshopSnippetName }) =>
        sourceMapSnippet.name === workshopSnippetName,
    );

    if (!workshopSnippet) {
      throw new Error(
        `Snippet ${sourceMapSnippet.name} does not exist in the workshop.`,
      );
    }

    sourceMapSnippet.id = workshopSnippet._id;
  });

  return { ...sourceMap };
}

async function deploy(sourceMap) {
  const workshop = await getWorkshop(sourceMap.workshop.id);
  const hyrdratedSourceMap = hydrateSourceMap(sourceMap, workshop);

  const tasks = [
    ...[
      ...hyrdratedSourceMap.aliases,
      ...hyrdratedSourceMap.aliases.flatMap((alias) => alias.sub_aliases),
    ].map(async (sourceMapAlias) => {
      const aliasVersions = await getAlias(sourceMapAlias.id);
      const aliasCurrentVersion =
        aliasVersions.find(({ is_current }) => is_current) ||
        aliasVersions[0] ||
        {};
      const highestVersion = Math.max(
        ...aliasVersions.map(({ version }) => version),
      );

      const newContents = setEnvironmentId(
        fs.readFileSync(sourceMapAlias.file).toString(),
        sourceMap.workshop.environment,
      );

      if (aliasCurrentVersion.content === newContents) {
        return;
      }

      const newVersion = {
        ...aliasCurrentVersion,
        is_current: true,
        content: newContents,
        version: highestVersion + 1,
      };

      return updateAlias(sourceMapAlias.id, newVersion);
    }),
    ...hyrdratedSourceMap.snippets.map(async (sourceMapSnippet) => {
      const snippetVersions = await getSnippet(sourceMapSnippet.id);
      const snippetCurrentVersion =
        snippetVersions.find(({ is_current }) => is_current) ||
        snippetVersions[0] ||
        {};
      const highestVersion = Math.max(
        ...snippetVersions.map(({ version }) => version),
      );

      const newContents = setEnvironmentId(
        fs.readFileSync(sourceMapSnippet.file).toString(),
        sourceMap.workshop.environment,
      );
      if (snippetCurrentVersion.content === newContents) {
        return;
      }

      const newVersion = {
        ...snippetCurrentVersion,
        is_current: true,
        content: newContents,
        version: highestVersion + 1,
      };

      return updateSnippet(sourceMapSnippet.id, newVersion);
    }),
    ...hyrdratedSourceMap.gvars.map(async (sourceMapGvar) => {
      const currentGvar = await getGvar(sourceMapGvar.id);

      const newContents = setEnvironmentId(
        fs.readFileSync(sourceMapGvar.file).toString(),
        sourceMap.workshop.environment,
      );

      if (currentGvar.value === newContents) {
        return;
      }

      return updateGvar(sourceMapGvar.id, {
        ...currentGvar,
        value: newContents,
      });
    }),
  ];

  return Promise.all(tasks);
}

console.log("Starting Deployment");
deploy(sourceMap)
  .then(() => console.log("Deployment Sucessful"))
  .catch((e) => {
    console.error(e);
    console.log("Deployment Failed");
  });
