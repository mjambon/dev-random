(*
   A symmetric graph of n nodes where each node i is connected to
   log n other nodes.

   Usage: ocaml sym_network.ml 200
*)

open Printf

(*
   node identifier = index
   Each cell of the array contains the list of nodes defining outgoing edges.
*)
type t = int list array

let create_offsets n =
  let rec aux offset =
    if offset < n then
      offset :: aux (2 * offset)
    else
      []
  in
  aux 1

let create_edge n offsets i =
  List.map (fun offset -> (i + offset) mod n) offsets

let create n =
  let offsets = create_offsets n in
  Array.init n (create_edge n offsets)

let print a =
  Array.iteri (fun i dests ->
    printf "%i -> %s\n"
      i (List.map string_of_int dests |> String.concat " ")
  ) a

let main () =
  let n =
    match Sys.argv with
    | [| _ |] -> 100
    | [| _; num |] -> int_of_string num
    | _ -> failwith "pass the number of nodes as argument"
  in
  let example = create n in
  print example

let () = main ()
