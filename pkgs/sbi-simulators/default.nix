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
  version = "0.3.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Filippo-Galli";
    repo = "sbi-simulators";
    tag = "v${finalAttrs.version}";
    sha256 = "00fqxdw7kphkjhd5cqmwa3jz9hn4wy4r4hcycdf3mbrbcjs21bp2";
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
