// @ts-check
const { post, get, put } = require("axios");

/**
 * @typedef {import("axios").AxiosResponse} AxiosResponse
 */

const token = process.env.AVRAE_TOKEN || "";

if (!token) {
  throw new Error("AVRAE_TOKEN environment variable not set.");
}

const header = {
  Authorization: token,
  Accept: "application/json, text/plain, */*",
  "User-Agent":
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36",
  "Content-Type": "application/json",
  "Sec-Fetch-Site": "same-site",
  "Sec-Fetch-Mode": "cors",
  "Sec-Fetch-Dest": "empty",
};

/**
 * @param {String} gvarID
 * @returns {Promise<AxiosResponse>}
 */
async function getGVar(gvarID) {
  return get(`https://api.avrae.io/customizations/gvars/${gvarID}`, {
    headers: header,
  });
}

/**
 * @param {Object} content
 * @param {String} gvarID
 * @returns {Promise<AxiosResponse>}
 */
async function updateGVar(content, gvarID) {
  return post(`https://api.avrae.io/customizations/gvars/${gvarID}`, content, {
    headers: header,
  });
}

/**
 * @param {String} aliasID
 * @returns {Promise<Object>}
 */
async function getAlias(aliasID) {
  const { data } = await get(
    `https://api.avrae.io/workshop/alias/${aliasID}/code`,
    {
      headers: header,
    },
  );
  return data.data;
}

/**
 * @param {string} workshop
 * @param {string} group_name
 * @returns {Promise<Map<string, string>>}
 */
async function getAliasIDs(workshop, group_name) {
  const result = await get(
    `https://api.avrae.io/workshop/collection/${workshop}/full`,
    {
      headers: header,
    },
  );

  /** @type {Map<string, string>} */
  const ids = new Map();
  result.data.data.aliases.forEach((alias) => {
    if (alias.name != group_name) {
      return;
    }

    alias.subcommands.forEach((sub_alias) => {
      ids.set(sub_alias.name, sub_alias._id);
    });
  });
  return ids;
}

/**
 * @param {Object} content
 * @param {number} version
 * @param {String} aliasID
 * @returns {Promise<AxiosResponse>}
 */
async function updateAlias(content, version, aliasID) {
  await post(`https://api.avrae.io/workshop/alias/${aliasID}/code`, content, {
    headers: header,
  });
  return put(
    `https://api.avrae.io/workshop/alias/${aliasID}/active-code`,
    { version: version },
    {
      headers: header,
    },
  );
}

module.exports = { getGVar, updateGVar, getAlias, updateAlias, getAliasIDs };
