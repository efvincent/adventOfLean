import Mathlib
import Lib.Util

open List (filter map maximum? length foldl nil range reverse tail!)
open Option (get!)
open Prod (snd)
/-
The raw input for the puzzle looks like this:
            [D]    
        [N] [C]    
        [Z] [M] [P]
        1   2   3 
        move 1 from 2 to 1
        move 3 from 1 to 3
        move 2 from 2 to 1
        move 1 from 1 to 2
The first section are the "stacks". In this sample, they're stacks
1, 2 and 3. Think of them being stacks of crates in a warehouse. 
The second section is a series of instructions to move some number
of crates from one stack to another. -/

def getEvery {α: Type} [Inhabited α] (xs: List α) (startAt: ℕ) (every : ℕ) (maxIdx : ℕ): List (ℕ × α) :=
  foldl (λ acc x => loop acc x) nil (range (maxIdx * every)) |> reverse
  where
    loop (acc: List (ℕ × α)) (i: ℕ) :=
      let idx := i * every + startAt
      if idx >= xs.length then acc
      else
        let x := xs[idx]!
        ((i + startAt, x)::acc)

def decodeStackLine (maxIdx:ℕ) (s:String) : List (ℕ × Char) :=
  getEvery s.data 1 4 maxIdx 
  |> filter ((· ≠ ' ') ∘ snd)

def addToStacks (stacks : Array (List Char)) (srow: List (ℕ × Char)) := 
  foldl (λ acc (idx,c) => acc.modify (idx-1) (λ s => c :: s)) stacks srow

def decode (s:String) :=
  match String.splitOn s "\n\n" with
  | (s₁ :: _) =>
    let ls := lines s₁
    -- calculate the max index, or max number of stacks 
    let maxIdx : ℕ := ls 
      |> map (length ∘ String.data) 
      |> maximum? 
      |> get! 
      |> (· / 4 + 1)

    let stacks : Array (List Char) := List.range' 1 maxIdx |> map (λ _ => List.nil) |> List.toArray
    let rawStacks := getRawStacks ls maxIdx
    let stacks' := foldl addToStacks stacks rawStacks
    
    -- rawStacks
    stacks'
    |> some
  | _ => none  
  where
    -- for each line in the first part of the data (the starting stacks),
    -- decode the stack line into a `List (ℕ × Char)` 
    getRawStacks ls mxIdx := 
      ls |> reverse |> tail! |> map (decodeStackLine mxIdx)

def rawIns := "move 1 from 2 to 1"

#eval match String.splitOn rawIns " " with
  | ("move" :: sn :: "from" :: sf :: "to" :: st :: []) => some <| map (strToNat ∘ String.) [sn,sf,st]
  | _ => none

#eval do
  let s <- getPuz 22 5
  IO.println s

#eval do
  let s <- getEx 22 5
  return decode s

#eval do
  let s <- getEx 22 5
  return Array.map length <| get! <| decode s