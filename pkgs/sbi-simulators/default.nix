{
  buildPythonPackage,
  fetchFromGitHub,
  jax,
  lib,
  numpy,
  pyro-ppl,
  pytestCheckHook,
  scipy,
  setuptools,
  torch,
  wheel,
}:
buildPythonPackage (finalAttrs: {
  pname = "sbi-simulator";
  version = "0.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Filippo-Galli";
    repo = "sbi-simulators";
    tag = "v${finalAttrs.version}";
    sha256 = "sha256-sUrFGAga8P7V3GoY9P/YUo3nZsOt0gSa6wPsLKzUPIM=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    numpy
    scipy
    torch
    pyro-ppl
    jax
  ];

  pythonImportsCheck = [
    "sbi_simulator"
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = {
    description = "Collection of simulation-based inference (SBI) benchmark simulators";
    homepage = "https://github.com/Filippo-Galli/sbi-simulators";
    maintainers = with lib.maintainers; [
      Filippo-Galli
    ];
    license = lib.licenses.gpl3Plus;
  };
})
