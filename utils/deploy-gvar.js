// @ts-check
const { getGVar, updateGVar } = require("./avrae-io");
/**
 * Updates a gvar to have the given contents
 * @param {String} gvarId
 * @param {String} name
 * @param {String} gvarContents
 * @async
 * @returns {Promise}
 */
async function deployGvar(gvarId, name, gvarContents) {
  let oldData;
  try {
    oldData = await getGVar(gvarId).then();
  } catch (error) {
    console.error(error);
    throw new Error(`Error occured when retrieveing gvar with id "${gvarId}"!`);
  }

  if (oldData.data.value == gvarContents) {
    console.log(`Skipped, gvar "${name}" was not changed.`);
    return;
  }

  console.log(`Attempting to update "${name}"...`);
  oldData.data.value = gvarContents;

  try {
    await updateGVar(oldData.data, gvarId);
  } catch (error) {
    console.error(error);
    throw new Error(`Error occured when updating gvar with id "${gvarId}"!`);
  }
  console.log(`Updated "${name}" successfully!`);
}

module.exports = { deployGvar };
