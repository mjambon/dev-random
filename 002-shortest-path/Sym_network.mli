(*
   A symmetric graph of n nodes where each node i is connected to
   log n other nodes.
*)

(*
   node identifier = index
   Each cell of the array contains the list of nodes defining outgoing edges.
*)
type t = int list array

val create : int -> t

val print : t -> unit
