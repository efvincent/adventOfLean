open String (length)
open List (reverse tail! head!) 

/-- Split a list by a delimiter where the delimiter is a member of the list -/
def split {α : Type} [DecidableEq α] (cs: List α) (delim: α) : List (List α) :=
  loop [] [] cs
  where
    loop : List (List α) -> List α -> List α -> List (List α)
      | acc, cur, [] => acc ++ [cur]
      | acc, cur, (x::xs) => 
        if x = delim 
        then loop (acc ++ [cur]) [] xs
        else loop acc (cur ++ [x]) xs

/-- Splits a list by a sequence of elements of the list. 
    * `splitOn` [1,2,0,0,3,0,0,4,5,6] [0,0] = [[1,2],[3],[4,5,6]]
-/
def splitOn {α : Type} [BEq α] (lst : List α) (delim : List α) : List (List α) :=
  let rec splitAux : List α → List α → List α → List (List α)
      | [], [], acc => [acc.reverse]
      | [], _, acc => [acc.reverse]
      | (h::t), [], acc => splitAux t delim (h::acc)
      | (h::t), (dh::dt), acc =>
        if h == dh then
          let rest := splitAux t dt []
          (acc.reverse :: rest)
        else splitAux t delim (h::acc)
  (splitAux lst delim []).filter (λ l => ¬ l.isEmpty)

/-- splits a string into a list of lines where the delimiter is 
    the newline character -/
def lines : String -> List String
  | "" => []
  | s => 
    split s.data '\n'
    |> List.map String.mk 

/-- convert a list of chars to a natural. Does not check that the chars are
    digits, it simply performs the conversion without possibility of error. -/
def strToNat (cs : List Char) : Nat :=
  loop (List.reverse cs)
  where
    loop : List Char -> Nat
    | [] => 0
    | c::cs => ((Char.toNat c) - 48) + 10 * loop cs

/-- Gets the contents of an Advent of Code data file given the year and day,
    and whether or not the file being sought is the example file or the
    puzzle file. It does not check that the file exists; if it doesn't,
    you'll experience the wrath of `IO.FS.readFile`! -/
def getData (y: Nat) (d: Nat) (ex: Bool) : IO String :=
  let y₁  := if y < 2000 then 2000 + y else y
  let ds  := toString d
  let d₁  := if length ds < 2 then "0" ++ ds else ds
  let ex₁ := if ex then "ex" else ""
  s!"./data/y{y₁}/d{d₁}{ex₁}.txt"
  |> IO.FS.readFile

/-- Gets puzzle data from the data directory
* `getPuz 2022 1` puzzle from year 2022 day 1
* `getPuz 22 1`  puzzle from year 2022 day 1  
-/
def getPuz : Nat -> Nat -> IO String
  | y, d => getData y d False

def getEx : Nat -> Nat -> IO String 
  | y, d => getData y d True

/-- finds the intersection between multiple lists -/
def intersect {α : Type} [BEq α] (xs : List (List α)) : List α :=
  match xs with
  | [] => []
  | h :: t => loop h t
  where
    /-- find the intersection between two lists -/
    intr : List α -> List α -> List α     
      | [] => λ _ => List.nil
      | xs => List.filter (List.elem · xs)

    /-- Finds the intersection between multiple lists by
        recursively calling `intr` on the accumulated
        intersection and the next list -/
    loop : List α -> List (List α) -> List α  
      | acc, [] => acc
      | acc, h' :: t => loop (intr acc h') t

def List.sum := List.foldl (· + ·) 0