const { post } = require("axios");
const { headers } = require("./headers");

async function updateGvar(id, content) {
  return post(`https://api.avrae.io/customizations/gvars/${id}`, content, {
    headers,
  });
}

module.exports = { updateGvar };
