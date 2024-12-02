const token = process.env.AVRAE_TOKEN || "";

if (!token) {
  throw new Error("AVRAE_TOKEN environment variable not set.");
}

const headers = {
  Authorization: token,
  Accept: "application/json, text/plain, */*",
  "User-Agent":
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36",
  "Content-Type": "application/json",
  "Sec-Fetch-Site": "same-site",
  "Sec-Fetch-Mode": "cors",
  "Sec-Fetch-Dest": "empty",
};

module.exports = { headers };
