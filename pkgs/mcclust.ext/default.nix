{
  buildRPackage,
  fetchFromGitHub,
  mcclust,
}:

buildRPackage {
  pname = "mcclust.ext";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "sarawade";
    repo = "mcclust.ext";
    rev = "4cd79fa68a5807f188285073bf61dd3ae7748c94";
    hash = "sha256-ealvFcGLeoYEsSPZql1AwD8gncbt6DPXbeCYaqdT2Wc=";
  };

  propagatedBuildInputs = [
    mcclust
  ];
  nativeBuildInputs = [
    mcclust
  ];

  meta = {
    homepage = "https://github.com/sarawade/mcclust.ext";
  };
}
