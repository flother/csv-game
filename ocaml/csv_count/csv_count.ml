(* 
ocamlbuild -package csv csv_count.native 
time ./csv_count.native 1 test.csv
*)
let _ =
  let [|_; i; fn|] = Sys.argv in 
  let i = int_of_string i - 1 in
  let ic = Csv.of_channel (open_in fn) in
  let sum = Csv.fold_left (fun acc fs -> acc + int_of_string (List.nth fs i)) 0 ic in
  Printf.printf "%d\n" sum
