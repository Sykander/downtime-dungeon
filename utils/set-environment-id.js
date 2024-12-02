const environmentRegex =
  /using\(.*env\s*=\s*"(?<environment_id>[\w\-]+)".*\)/gi;

function setEnvironmentId(content, environmentId) {
  const regResult = environmentRegex.exec(content);

  if (regResult === null) {
    return content;
  }

  const environmentIdToReplace = regResult.groups.environment_id;

  return content.replace(environmentIdToReplace, environmentId);
}

module.exports = { setEnvironmentId };
