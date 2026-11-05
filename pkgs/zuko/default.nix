{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  numpy,
  pytestCheckHook,
  setuptools,
  torch,
}:
buildPythonPackage (finalAttrs: {
  pname = "zuko";
  version = "1.6.0";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "probabilists";
    repo = "zuko";
    tag = "${finalAttrs.version}";
    hash = "sha256-2cVkuliLZRQNRpFEjQH/JbVjz+/wQjiReapI4x24yjE=";
  };

  pyproject = true;
  build-system = [
    setuptools
  ];

  dependencies = [
    numpy
    torch
  ];

  pythonImportsCheck = [ "zuko" ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = {
    description = "Normalizing flows in PyTorch";
    homepage = "https://github.com/probabilists/zuko";
    changelog = "https://github.com/probabilists/zuko/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      Filippo-Galli
    ];
  };
})
