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
  version = "0.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Filippo-Galli";
    repo = "sbi-simulators";
    tag = "v${finalAttrs.version}";
    sha256 = "sha256-9kkywK0FVPRLItKwsEcUmpldOqi7+306WWepjf/YmuQ=";
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
