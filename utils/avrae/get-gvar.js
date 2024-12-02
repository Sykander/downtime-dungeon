const { get } = require("axios");
const { headers } = require("./headers");

async function getGvar(id) {
  const { data } = await get(
    `https://api.avrae.io/customizations/gvars/${id}`,
    {
      headers,
    },
  );

  return data;
}
module.exports = { getGvar };
