final: prev: {
  lib = prev.lib.extend (
    lfinal: lprev: {
      maintainers = lprev.maintainers // {
        Filippo-Galli = {
          email = "filippo.galli.cr@gmail.com";
          github = "Filippo-Galli";
          githubId = 59925664;
          name = "Filippo Galli";
        };
      };
    }
  );
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyFinal: pyPrev: {
      umnn = pyFinal.callPackage ./pkgs/UMNN { };

      bayesflow = pyFinal.callPackage ./pkgs/bayesflow { };

      nflows = pyFinal.callPackage ./pkgs/nflows {
        UMNN = pyFinal.umnn;
      };

      sbi = pyFinal.callPackage ./pkgs/sbi { };

      torchtestcase = pyFinal.callPackage ./pkgs/torchtestcase { };

      zuko = pyFinal.callPackage ./pkgs/zuko { };
    })
  ];

  rPackages = prev.rPackages.override (old: {
    overrides = (old.overrides or { }) // {
      mcclustext = final.lib.callPackageWith (final // final.rPackages) ./pkgs/mcclust.ext { };
    };
  });
}
