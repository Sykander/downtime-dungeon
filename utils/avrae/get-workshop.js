const { get } = require("axios");
const { headers } = require("./headers");

async function getWorkshop(id) {
  const {
    data: { data },
  } = await get(`https://api.avrae.io/workshop/collection/${id}/full`, {
    headers,
  });

  return data;
}

module.exports = { getWorkshop };
