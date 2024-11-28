// @ts-check
/** @typedef {import("./types").alias} alias */

const { getAlias, updateAlias, getAliasIDs } = require("./avrae-io");
const { readSyncEnv } = require("./read-file-sync-environment");

/**
 * Updates an alias in the workshop with the given contents
 * @param {String} workshop 
 * @param {alias} alias
 * @param {string} environment 
 */
async function deployAliases(workshop, alias, environment) {
    let allIDs;
    try {
        allIDs = await getAliasIDs(workshop, alias.group_name).then();
    } catch(error) {
        console.error(error);
        throw new Error(`Error when finding alias "${alias.group_name}" in workshop "${workshop}"`);
    }
    
    for(var sub_alias of alias.sub_aliases) {
        if(!allIDs.has(sub_alias.name)) {
            throw new Error(`Alias "${sub_alias.name}" not found.`);
        }
        const id = allIDs.get(sub_alias.name) || "";
        let versions;
        try{
            versions = await getAlias(id);
        } catch(error) {
            console.error(error);
            throw new Error(`Error when looking up sub-alias "${sub_alias.name}" of alias "${alias.group_name}"`);
        }

        let current = {};
        let maxVersion = 0;
        versions.forEach(version => {
            if(version.is_current) {
                current = {...version};
            }
            maxVersion = Math.max(maxVersion, version.version);
        })

        const newData = readSyncEnv(sub_alias.file, environment);

        if(current.content == newData) {
            console.log(`Skipped, "${sub_alias.alias_name}" was not changed.`);
            continue;
        }
        
        current.content = newData;
        current.version = maxVersion + 1;
        current.is_current = true;
        await updateAlias(current, current.version, id);

        console.log(`Updated "${sub_alias.alias_name}" successfully!`);
    } 
}

module.exports = { deployAliases };
