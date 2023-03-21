import Lake
open Lake DSL

package «adventOfLean» {
  -- add any package configuration options here
  srcDir := "src"
}

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

lean_lib Y2022
lean_lib Lib

@[default_target]
lean_exe «Main» {
  -- add any library configuration options here
  root := "Main"
}

meta if get_config? doc = some "on" then
require «doc-gen4» from git "https://github.com/leanprover/doc-gen4" @ "main"

