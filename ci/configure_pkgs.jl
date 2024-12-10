#!/usr/bin/env julia
import Pkg

tempdir = mktempdir()
Pkg.activate(tempdir)
Pkg.add(url="https://github.com/LuchnikovI/SimpleTN")
Pkg.add(url="https://github.com/LuchnikovI/imbp")
Pkg.add(["YAML"])
