# Advent of Code in Lean 4

This repo is being used as a way to investigate and familiarize myself with the use of [Lean 4](https://leanprover.github.io/) as a functional programming language. Lean is known more as a proof assistant, but it is in reality a sophisticated functional programming language as well. I'm taking it up in order to gain experience not only with theorem prooving, but also use of a dependent type theory in functional programming. There are other options, [Coq](https://coq.inria.fr), [Agda](https://wiki.portal.chalmers.se/agda/pmwiki.php), [Idris 2](https://github.com/idris-lang/Idris2), and languages make use of dependent type theory as proof assistants and general purpose functional programming languages.

## Why Lean?

Lean, and specifically Lean 4, is a relatively new player in the field. Coq, for example, has the most mindshare, but is quite old and quirky to use as a general purpose programming language. Agda is probably my next choice, as it's a respected language with a good community. Agda also has [Phil Wadler's](https://en.wikipedia.org/wiki/Philip_Wadler) online and excellent [Programming Language Foundations in Agda](https://plfa.github.io) book. Agda is also closest in syntax to Haskell, my current favorite programming language. Idris is also very similar to Haskell.

In the end these factors influenced my direction:

* Lean 4 is the newest of the choices, it's got excellent IDE support using the language server approach, and works well with VSCode.
* Lean 4 and it's standard and advanced [Mathlib](https://github.com/leanprover-community/mathlib) libraries are still under development. I'd like to get in on something closer to the ground floor, and possibly find the time to contribute to the community in a meaningful way.
* While Lean 4 is more influenced by OCaml than Haskell, it also has some innovative language features
  * It takes the idea of a REPL one step further by allowing you to evaluate expressions and check data types within the code itself for the most immediate feedback.
  * It has a powerful [hygenic macro](https://en.wikipedia.org/wiki/Hygienic_macro) system; something that is more commonly found in lisps, and leveraging macros is a skillset I'd like to improve upon.
* All of this on top of having a well developed dependent type system, and a proven track record as a powerful proof assistant.

## Why Advent of Code (AoC)
I find that AoC is both challenging and fun! I've participated in 4 or 5 years, and completed one. I usually get up to day 20 or so before the holidays and the need to spend time with family and get away from technology start to overpower me. None the less, there's a diverse set of problems presented in an interesting and challenging way, so it's a great way to practice.