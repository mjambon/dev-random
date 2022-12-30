(*
   Compute all shortest paths in a graph using the Floyd-Warshall algorithm.

   https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm
*)

open Printf

type node_id = int

let add_directed_edge dist i j w =
  if not (Float.is_finite w) then
    invalid_arg "Floyd_warshall.add_directed_edge: not a finite edge weight";
  dist.(i).(j) <- w

let add_undirected_edge dist i j w =
  add_directed_edge dist i j w;
  add_directed_edge dist j i w

(*
   Load a graph and compute the distance matrix.
   Vertices are identified by consecutive ints starting from zero.
*)
let get_distance_matrix ?(directed = false) n edge_weights =
  let dist = Array.make_matrix n n infinity in
  for i = 0 to n - 1 do
    dist.(i).(i) <- 0.
  done;
  let add_edge =
    if directed then
      add_directed_edge
    else
      add_undirected_edge
  in
  List.iter (fun (i, j, w) -> add_edge dist i j w) edge_weights;
  for k = 0 to n - 1 do
    for i = 0 to n - 1 do
      for j = 0 to n - 1 do
        let dist_via_k = dist.(i).(k) +. dist.(k).(j) in
        if dist_via_k < dist.(i).(j) then
          dist.(i).(j) <- dist_via_k
      done
    done
  done;
  dist

let print_matrix m =
  let n = Array.length m in
  for i = 0 to n - 1 do
    printf "[%3i]" i;
    let mi = m.(i) in
    assert (Array.length mi = n);
    for j = 0 to n - 1 do
      printf " %3g" mi.(j)
    done;
    printf "\n"
  done

let print_matrix_stats m =
  let n = Array.length m in
  let avg_dist =
    (* We only care about distances between distinct nodes,
       giving us n * (n-1) pairs *)
    Array.fold_left (fun sum row ->
      assert (Array.length row = n);
      Array.fold_left (+.) sum row
    ) 0. m /. float (n * (n - 1))
  in
  let max_dist =
    Array.fold_left (fun acc row ->
      Array.fold_left max acc row
    ) 0. m
  in
  printf "\
number of nodes n: %i
average distance between two distinct nodes: %g
maximum distance between two distinct nodes: %g
"
    n avg_dist max_dist

let test_distance_matrix () =
  assert (
    let dist =
      get_distance_matrix 2 [
        0, 1, 10.;
      ]
    in
    dist = [| [| 0.; 10.; |];
              [| 10.; 0.; |] |]
  );
  assert (
    let dist =
      get_distance_matrix 3 [
        0, 1, 10.;
        1, 2, 20.;
      ]
    in
    dist = [| [| 0.; 10.; 30.; |];
              [| 10.; 0.; 20.; |];
              [| 30.; 20.; 0.; |] |]
  );
  assert (
    let dist =
      get_distance_matrix 4 [
        0, 1, 10.;
        2, 3, 20.;
      ]
    in
    let inf = infinity in
    dist = [| [| 0.; 10.; inf; inf; |];
              [| 10.; 0.; inf; inf; |];
              [| inf; inf; 0.; 20.; |];
              [| inf; inf; 20.; 0.; |]; |]
  );
  assert (
    let dist =
      get_distance_matrix 3 [
        0, 1, 10.;
        0, 2, 50.;
        1, 2, 20.;
      ]
    in
    dist = [| [| 0.; 10.; 30.; |];
              [| 10.; 0.; 20.; |];
              [| 30.; 20.; 0.; |] |]
  )

let _tests = [
  "distance matrix", test_distance_matrix;
]
