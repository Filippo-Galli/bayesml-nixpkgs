{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  numpy,
  pytestCheckHook,
  setuptools,
  torch,
}:

buildPythonPackage (finalAttrs: {
  pname = "torchtestcase";
  version = "2018.2";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "phohenecker";
    repo = "torch-test-case";
    tag = "v${finalAttrs.version}";
    hash = "sha256-En88CpFEWB+LdZpo1aITUledaUEWb04dsqceITfd3XQ=";
  };

  build-system = [ setuptools ];

  dependencies = [
    numpy
    torch
  ];

  pythonImportsCheck = [ "torchtestcase" ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = {
    description = "Extends unittest.TestCase such that assertions support PyTorch tensors and parameters.";
    homepage = "https://github.com/phohenecker/torch-test-case";
    changelog = "https://github.com/phohenecker/torch-test-case/releases/tag/v${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      Filippo-Galli
    ];
  };
})
