(*
   Compute all shortest paths in a graph using the Floyd-Warshall algorithm.

   https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm
*)

(* Node identifiers range from 0 to n-1, where n is the number of nodes
   in the graph. *)
type node_id = int

val get_distance_matrix :
  ?directed:bool ->
  int ->
  (node_id * node_id * float) list -> float array array

val print_matrix : float array array -> unit

val print_matrix_stats : float array array -> unit
