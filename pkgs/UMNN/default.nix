{
  lib,
  buildPythonPackage,

  fetchFromGitHub,

  pytestCheckHook,
  hatchling,
  matplotlib,
  numpy,
  torch,
}:
buildPythonPackage (finalAttrs: {
  pname = "UMNN";
  version = "unstable-2025-12-08";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "AWehenkel";
    repo = "UMNN";
    rev = "59118c14c57bd1ae066f3c84042ab01a90bcd17e";
    hash = "sha256-waGJZ7m3iqv634OhywW5WXwBXFSu/ZnV0DTF2Az8huc=";
  };

  pyproject = true;
  build-system = [
    hatchling
  ];

  dependencies = [
    numpy
    torch
  ];

  pythonImportsCheck = [ "UMNN" ];

  nativeCheckInputs = [
    pytestCheckHook
    matplotlib
  ];

  meta = {
    description = "Implementation of Unconstrained Monotonic Neural Network";
    homepage = "https://github.com/AWehenkel/UMNN";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [
      Filippo-Galli
    ];
  };
})
