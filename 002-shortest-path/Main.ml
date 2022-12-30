(*
   Command-line handling and entry point of the program.
*)

let convert_edges graph =
  graph
  |> Array.mapi (fun i js -> List.map (fun j -> (i, j, 1.)) js)
  |> Array.to_list
  |> List.flatten

let run n =
  let graph = Sym_network.create n in
  let mat =
    Floyd_warshall.get_distance_matrix ~directed:true n
      (convert_edges graph)
  in
  Sym_network.print graph;
  if n <= 20 then
    Floyd_warshall.print_matrix mat;
  Floyd_warshall.print_matrix_stats mat

let main () =
  let n =
    match Sys.argv with
    | [| _ |] -> 100
    | [| _; num |] -> int_of_string num
    | _ -> failwith "pass the number of nodes as argument"
  in
  run n

let () = main ()
