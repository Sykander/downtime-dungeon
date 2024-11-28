/**
 * @typedef {Object} source_map
 * @property {gvar[]} gvars
 * @property {alias[]} aliases
 * @property {[]} snippets
 * @property {workshop} workshop
 * @property {string} environment
 */

/**
 * @typedef {Object} alias
 * @property {string} group_name
 * @property {sub_alias[]} sub_aliases
 */

/**
 * @typedef {Object} sub_alias
 * @property {string} name
 * @property {string} alias_name
 * @property {string} file
 */

/**
 * @typedef {Object} gvar
 * @property {string} name
 * @property {string} file
 * @property {string} gvar_id
 */

/**
 * @typedef {Object} workshop
 * @property {string} url
 * @property {string} id
 */

module.exports = {alias, sub_alias}