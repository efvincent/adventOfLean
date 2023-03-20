import Std.Data.List.Basic
import Lib.Util

open List (toChunks splitAt head! map sum)

/-- calc the score as offsets of ascii values -/
def score (c:Char) : Nat := if c > 'Z' then c.toNat - 96 else c.toNat - 38

def partA : String -> Nat :=
  sum ∘ map (score ∘ head! ∘ intersect ∘ half) ∘ lines    
  where
    half (s:String) : List (List Char) :=
      let (l,r) := splitAt (s.length / 2) s.data; [l,r]

def partB : String -> Nat :=
  sum ∘ map (score ∘ head! ∘ intersect) ∘ toChunks 3 ∘ map String.data ∘ lines

def ans1 := do
  let s <- getPuz 22 3
  return partA s  

def ans2 := do
  let s <- getPuz 22 3
  return partB s  

#eval ans1

#eval ans2