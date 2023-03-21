import Lib.Util
import Mathlib
import Lean

/-- definition of the selector predicate, it selects parsed puzzle lines
    that should be counted to get the solution -/
def Selector := ℕ -> ℕ -> ℕ -> Bool

/-- decode the puzzle data into the parsed format, which is `Option [ℕ, ℕ, ℕ]` -/
def decode (pred:Selector) (s:String) := 
  List.filterMap (decodeLine pred) (lines s)
  where
    /-- decodes a range, which is a string in the form "2-4" for example -/
    decodeRange (s:String) :=
      match String.splitOn s "-" with
      | (p1::p2::[]) =>
        let m := strToNat p1.data
        let n := strToNat p2.data
        some (List.range' m (n-m+1))
      | _ => none

    /-- decodes one line of the puzzle data in to an optional triplet of ℕ -/
    decodeLine (pred:Selector) (s:String) : Option (List ℕ × List ℕ × List ℕ) :=
      match String.splitOn s "," with
      | (p1::p2::[]) => do
        let m <- decodeRange p1
        let n <- decodeRange p2
        let int := m.inter n
        if pred m.length n.length int.length
        then pure (m, n, m.inter n)
        else none
      | _ => none

/-- calculate the answer, which part depends on the predicate. The first part
    requires the intersection be equal to one of the two ranges, the second part
    is looking for any intersection at all -/
def ans (pred:Selector) := do
  let s <- getPuz 22 4
  let ls := decode pred s
  pure ls.length

#eval ans (λ m n int => int >= m || int >= n)
#eval ans (λ _ _ int => int > 0)