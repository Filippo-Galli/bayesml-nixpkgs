{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,
  matplotlib,
  numpy,
  tensorboard,
  torch,
  tqdm,
  torchtestcase,
  UMNN,
  pytestCheckHook,
}:

buildPythonPackage (finalAttrs: {
  pname = "nflows";
  version = "0.14";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "bayesiains";
    repo = "nflows";
    tag = "v${finalAttrs.version}";
    hash = "sha256-E6vFDEMObfamWqtQNIsgRYTKTh7HcYb5DmwFhV6ADYs=";
  };

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    matplotlib
    numpy
    tensorboard
    torch
    tqdm
    UMNN
  ];

  pythonImportsCheck = [ "nflows" ];

  nativeCheckInputs = [
    pytestCheckHook
    torchtestcase
  ];

  disabledTestPaths = [
    # Removed since RuntimeError: function deprecation
    "tests/transforms/linear_test.py::NaiveLinearTest::test_forward_inverse_are_consistent"
    "tests/transforms/linear_test.py::NaiveLinearTest::test_inverse_no_cache"

    # Removed since the spline inverses lose precision and intermittently exceed it with recent PyTorch
    "tests/transforms/coupling_test.py::PiecewiseCouplingTransformTest::test_forward_inverse_are_consistent_unconstrained"
    "tests/transforms/nonlinearities_test.py::TestPiecewiseCDF::test_forward_inverse_are_consistent"
    "tests/transforms/nonlinearities_test.py::TestUnconstrainedPiecewiseCDF::test_forward_inverse_are_consistent"
  ];

  meta = {
    description = "Normalizing flows in PyTorch";
    homepage = "https://github.com/bayesiains/nflows";
    changelog = "https://github.com/bayesiains/nflows/releases/tag/v${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      Filippo-Galli
    ];
  };

})
