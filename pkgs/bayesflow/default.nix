{
  fetchFromGitHub,
  buildPythonPackage,
  pytestCheckHook,
  pytest-cov,
  pythonRelaxDepsHook,
  setuptools,
  lib,
  keras,
  matplotlib,
  ipykernel,
  nbformat,
  nbconvert,
  networkx,
  numpy,
  pandas,
  scipy,
  seaborn,
  simpy,
  sympy,
  tqdm,
  pymc,
}:
buildPythonPackage (finalAttrs: {
  pname = "bayesflow";
  version = "2.1.0";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "bayesflow-org";
    repo = "bayesflow";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ubnr/e0ciJyV8R56hoPm/ztae6dj/jpI1KC5avRtPUU=";
  };

  pyproject = true;
  build-system = [
    setuptools
  ];

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "keras"
    "matplotlib"
    "numpy"
    "pandas"
    "scipy"
    "tqdm"
  ];

  dependencies = [
    keras
    matplotlib
    networkx
    numpy
    pandas
    scipy
    seaborn
    simpy
    sympy
    tqdm
    pymc
  ];

  pythonImportsCheck = [ "bayesflow" ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-cov
    nbformat
    nbconvert
    ipykernel
  ];

  pytestFlags = [
    "-vv"
    "--tb=long"

    "tests/test_examples/test_examples.py::test_linear_regression_starter"
    "tests/test_examples/test_examples.py::test_lotka_volterra_point_estimation_and_expert_stats"
    "tests/test_examples/test_examples.py::test_one_sample_ttest"
    "tests/test_examples/test_examples.py::test_sir_posterior_estimation"
    "tests/test_examples/test_examples.py::test_two_moons_starter"
    "tests/test_examples/test_examples.py::test_likelihood_estimation"
  ];

  meta = {
    description = "A Python library for simulation-based inference with deep learning";
    homepage = "https://bayesflow.org/v2.1.0/index.html/";
    changelog = "https://github.com/bayesflow-org/bayesflow/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      Filippo-Galli
    ];
  };

})
