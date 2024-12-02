const { get } = require("axios");
const { headers } = require("./headers");

async function getAlias(id) {
  const {
    data: { data },
  } = await get(`https://api.avrae.io/workshop/alias/${id}/code`, {
    headers,
  });

  return data;
}

module.exports = { getAlias };
