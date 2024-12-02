const { post, put } = require("axios");
const { headers } = require("./headers");

async function updateAlias(id, content) {
  await post(`https://api.avrae.io/workshop/alias/${id}/code`, content, {
    headers,
  });

  if (content.is_current) {
    await put(
      `https://api.avrae.io/workshop/alias/${id}/active-code`,
      { version: content.version },
      { headers },
    );
  }
}

module.exports = { updateAlias };
