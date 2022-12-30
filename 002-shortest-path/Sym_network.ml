(*
   A symmetric graph of n nodes where each node i is connected to
   log n other nodes.
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
  let n = Array.length a in
  let num_pairs = n * (n - 1) in
  let num_edges =
    Array.fold_left (fun sum dests -> sum + List.length dests) 0 a
  in
  printf "\
number of nodes: %i
number of node pairs: %i
number of edges: %i
"
    n num_pairs num_edges;
  Array.iteri (fun i dests ->
    printf "%3i -> %s\n"
      i (List.map (sprintf "%3i") dests |> String.concat " ")
  ) a
