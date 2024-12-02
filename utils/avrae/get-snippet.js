const { get } = require("axios");
const { headers } = require("./headers");

async function getSnippet(id) {
  const {
    data: { data },
  } = await get(`https://api.avrae.io/workshop/snippet/${id}/code`, {
    headers,
  });

  return data;
}
module.exports = { getSnippet };
