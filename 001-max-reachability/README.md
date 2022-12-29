Maximum reachability
==

Let's explore the idea of creating a navigable space in which every
point is a close as possible to any other point without requiring an
unreasonable number of "roads" or connections between points.

We'll consider only finite graphs where each node represents a point
in space and edges represent roads connecting points. We'll also
assume that all edges have the same length.

We shall however keep in mind and discuss the applicability of such model,
i.e. whether such spaces can be implemented in the physical world,
possibly as electronic circuits and/or computer networks.

In what follows, n designates the number of nodes in the graph
representing the whole space unless otherwise noted.

Initial assumptions
--

* the graph has n nodes and e edges. The graph is may be directed or
  undirected. We'll consider directed graphs to be a special cases of
  undirected graphs.
* the graph is meant to be used to transport some information along edges.
* each node has a unique identifier. The unique identifier of an edge
  is formed by the pair of nodes.
* each node is equipped with a realistic computer (bounded memory,
  bounded number of operations per time interval).
* the question of addressing is left open i.e. we want a way to send
  information from one node to another but we have to figure out a good
  way to do so while carrying information only along the edges of the
  graph. For example, it's not possible to make a function call to
  request the path to reach another node for free.
* the memory space allotted to a node is bounded while the size of the graph
  is unbounded. This prevents a node from storing a complete map of
  the space.
* the graph doesn't change over time.

Given these constraints, the space resembles the internet under
simplifying assumptions that the network is immutable and that the
travel time from one host to another is constant. We'll assume this is
a solved problem. Instead, we'll focus on the graph topology.

Motivations
--

* model cooperative systems such as:
  - individual members of a society with or without technology
  - natural or artificial neurons
  - a fleet of cooperative robots
* optimize acquisition and exchanges of knowledge

### Example 1: O(n) edges, O(n) average shortest path:

```
A -- B -- C -- D
```

### Example 2: O(n^2) edges, O(1) average shortest path:

Each node is connected directly to every other node:

```
A -- B
A -- C
A -- D
B -- C
B -- D
C -- D
```

### Example 3: O(n) edges, O(log n) average shortest path: balanced tree

Some nodes are closer to the root than others and therefore see more
traffic than the nodes that are closer to the root if all nodes are
equally likely to communicate directly with one another.

A hierarchical tree-like structure is suitable when most communication
is done locally, each subtree corresponding to a "region" or "locality".

### Example 4: O(n log n) edges, O(log n) average shortest path

Data structure:
* circular array
* each array element i is implicitly connected to elements i+1, i+2,
  i+4, i+8, i+16, etc.

Implementation: see OCaml code. Run `ocaml sym_network.ml 1000` to see
the structure of the graph:

```
$ ocaml sym_network.ml 1000
0 -> 1 2 4 8 16 32 64 128 256 512
1 -> 2 3 5 9 17 33 65 129 257 513
2 -> 3 4 6 10 18 34 66 130 258 514
3 -> 4 5 7 11 19 35 67 131 259 515
4 -> 5 6 8 12 20 36 68 132 260 516
5 -> 6 7 9 13 21 37 69 133 261 517
...
995 -> 996 997 999 3 11 27 59 123 251 507
996 -> 997 998 0 4 12 28 60 124 252 508
997 -> 998 999 1 5 13 29 61 125 253 509
998 -> 999 0 2 6 14 30 62 126 254 510
999 -> 0 1 3 7 15 31 63 127 255 511
```
