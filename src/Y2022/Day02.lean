import Lib.Util

namespace Internal

  inductive P1Move | A | B | C deriving Repr

  inductive P2Move | X | Y | Z deriving Repr

  inductive Move | Rock | Paper | Scissors 
    deriving Repr, DecidableEq

  structure Round where
    p1 : P1Move
    p2 : P2Move 
    deriving Repr

  def Match := List Round 
    deriving Repr

  open P1Move P2Move Move

  def lineToRound (s: String) : Round :=
    let p1 := match s.data[0]! with | 'A' => A | 'B' => B | _ => C
    let p2 := match s.data[2]! with | 'X' => X | 'Y' => Y | _ => Z
    ⟨p1, p2⟩ 

  def decode := List.map lineToRound ∘ lines   

  def scoreOf (p1 p2 : Move) : Nat :=
    if p1 = p2 then 3 
    else match p1, p2 with
      | Rock, Paper 
      | Scissors, Rock
      | Paper, Scissors => 6 
      | _, _ => 0

  def moveScore : Move -> Nat
    | Rock => 1 | Paper => 2 | Scissors => 3

  def p1ToMove : P1Move -> Move
    | A => Rock | B => Paper | C => Scissors

  def p2ToMove (r:Round) : Move := 
    match r.p2 with | X => Rock | Y => Paper | Z => Scissors

  def p2ToMove₂ : Round -> Move
    | ⟨p1,Y⟩ => p1ToMove p1 
    | ⟨A, X⟩ => Scissors     -- lose
    | ⟨A, Z⟩ => Paper        -- win
    | ⟨B, X⟩ => Rock 
    | ⟨B, Z⟩ => Scissors
    | ⟨C, X⟩ => Paper
    | ⟨C, Z⟩ => Rock
  
  def matchResult : (Round -> Nat) -> Match -> Nat  
    | r, m => List.foldl (λacc g => acc + r g) 0 m

  def rule (p2Fn : Round -> Move) (r : Round) : Nat :=
    let p2₁     := p2Fn r
    let s₁      := scoreOf (p1ToMove r.p1) p2₁
    s₁ + moveScore p2₁

end Internal
open Internal

def ans₁ := do
  let s <- getPuz 22 2
  return decode s |> matchResult (rule p2ToMove)

def ans₂ := do
  let s <- getPuz 22 2 
  return decode s |> matchResult (rule p2ToMove₂)

#eval ans₂