{
  fetchFromGitHub,
  buildPythonPackage,
  setuptools,
  matplotlib,
  joblib,
  numpy,
  pillow,
  scipy,
  scikit-learn,
  tensorboard,
  torch,
  skorch,
  tqdm,
  torchtestcase,
  nflows,
  zuko,
  lib,
  pytest-harvest,
  pytestCheckHook,
  pytest-mock,
  pyro-ppl,
  pytest-xdist,
  pymc,
}:
buildPythonPackage (finalAttrs: {
  pname = "sbi";
  version = "0.27.0";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "sbi-dev";
    repo = "sbi";
    tag = "v${finalAttrs.version}";
    hash = "sha256-a6T7xa7zXr7rhNV3wikE/yrXSNhJ4PDRa/EF0+/CudA=";
  };

  pyproject = true;
  build-system = [
    setuptools
  ];

  dependencies = [
    matplotlib
    joblib
    numpy
    pillow
    scipy
    scikit-learn
    tensorboard
    torch
    skorch
    tqdm
    nflows
    zuko
  ];

  pythonImportsCheck = [ "sbi" ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-harvest
    pytest-mock
    torchtestcase
    pyro-ppl
    pytest-xdist
    pymc
  ];

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  disabledTestPaths = [
    "tests/tutorials_test.py"
  ];

  disabledTestMarks = [
    "slow"
    "gpu"
  ];

  meta = {
    description = "Python package for simulation-based inference";
    homepage = "https://sbi.readthedocs.io/en/stable/";
    changelog = "https://github.com/sbi-dev/sbi/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      Filippo-Galli
    ];
  };

})
