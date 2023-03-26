import Mathlib
import Lib.Util

open List (nil cons head map foldl maximum? mergeSort take)
open Add (add)
open ToString (toString)

namespace Internal

def decode (input : String) : List Nat :=
  input.splitOn "\n\n"
  |> map (λs  => s.splitOn "\n")
  |> map (λss => ss.map (λs => s.toNat!))
  |> map (λns => ns.foldl (· + ·) 0)
  |> mergeSort (· > ·) 

-- break a string into a list of strings separated by 2 newline characters,
-- then for each string, break it into a list of strings separated by a newline character
-- then for each string, parse into a Nat, then sum each group of Nats and return the maximum
def part1 (input : String) : Nat :=
  decode input
  |> maximum? 
  |> Option.get!

-- same as part1, but instead sum the three largest sums of each group
def part2 (input : String) : Nat :=
  decode input
  |> take 3 
  |> foldl (· + ·) 0
  
end Internal

#eval do
  let s <- getPuz 22 1
  pure $ Internal.part1 s

#eval do
  let s <- getPuz 22 1
  pure $ Internal.part2 s