import Mathlib.Data.List.Sort
import Lib.Util

open List (nil cons head map foldl maximum?)
open Add (add)
open ToString (toString)

namespace Internal

private def decode (s:String) : List Nat :=
  map (foldl add 0 ∘ map strToNat)
  ∘ split (split s.data '\n') <| [] 

end Internal
open Internal

-- Answer to part 1
def ans1 := do
  let s <- getPuz 22 1
  decode s
  |> maximum?
  |> pure

def ans2 := do
  let s <- getPuz 22 1
  let s₁ := decode s
  let s₂ := List.mergeSort (λm n : Nat => n <= m) s₁
  pure <| List.take 3 s₂ |> List.sum
