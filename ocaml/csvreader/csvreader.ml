(*
ocamlbuild -package csv csvreader.native 
time ./csvreader.native < /tmp/hello.csv 
*)

let _ =
  let ic = Csv.of_channel stdin in
  let sum = Csv.fold_left (fun acc fs -> acc + List.length fs) 0 ic in
  Printf.printf "%d\n" sum

