import Y2022.Day01

def main : IO Unit := do
  let d01a <- ans1
  let d01b <- ans2
  IO.println s!"2022 Day 01:\nAns part 1 = {d01a}\nAns part 2 = {d01b}"

#eval main
