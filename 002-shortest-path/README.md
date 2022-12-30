Shortest paths in a graph designed for shortest paths
==

This a follow-up to [001-max-reachability](../001-max-reachability)
where we created a directed graph with the following properties:

* n nodes
* O(n log n) edges
* nodes are indistinguishable without being assigned an identifier,
  i.e. the structure of the space from the perspective of a node is
  the same for all the nodes.
* The worst-case shortest path from one node to another was claimed to
  be O(log n).

Let's check if the shortest path from one node to another is indeed
of length O(log n).

Implementation
--

I'm reusing an old implementation of the Floyd-Warshall algorithm to
compute all the shortest paths within a directed graph.

The graph of interest is what I implemented
[previously](../001-max-reachability).

The program can be built and run with:
```
$ make
```

For n = 1000 nodes, we get:

```
number of nodes: 1000
number of node pairs: 999000
number of edges: 10000
  0 ->   1   2   4   8  16  32  64 128 256 512
  1 ->   2   3   5   9  17  33  65 129 257 513
  2 ->   3   4   6  10  18  34  66 130 258 514
...
997 -> 998 999   1   5  13  29  61 125 253 509
998 -> 999   0   2   6  14  30  62 126 254 510
999 ->   0   1   3   7  15  31  63 127 255 511
number of nodes n: 1000
average distance between two distinct nodes: 4.93694
maximum distance between two distinct nodes: 9
```

For n = 2000 nodes, we get:

```
number of nodes: 2000
number of node pairs: 3998000
number of edges: 22000
  0 ->   1   2   4   8  16  32  64 128 256 512 1024
  1 ->   2   3   5   9  17  33  65 129 257 513 1025
  2 ->   3   4   6  10  18  34  66 130 258 514 1026
...
1997 -> 1998 1999   1   5  13  29  61 125 253 509 1021
1998 -> 1999   0   2   6  14  30  62 126 254 510 1022
1999 ->   0   1   3   7  15  31  63 127 255 511 1023
number of nodes n: 2000
average distance between two distinct nodes: 5.43472
maximum distance between two distinct nodes: 10
```

Note that the Floyd-Warshall algorithm runs in O(n^3) which takes a
while on large graphs. This is why I didn't have the patience to get
the data for really large graphs. Since every node of the graph is
identical, it would actually suffice to calculate the shortest paths
from one node to all the other nodes.

Conclusion
--

It looks indeed like the maximum distance from one node to another is
log n. This graph structure allows us to create only n log n edges,
with log n outgoing edges for each node. An important property is that
all nodes are identical and is traversed by the same traffic unlike a
hierarchical network like the internet.

Possible uses include "egalitarian diffusion algorithms" based on a
collection of agents that broadcast data to their neighbors. Upon
receiving data from a neighbor, an agent integrates it and
rebroadcasts it in a modified form, as is the case with [self-organizing
maps](https://en.wikipedia.org/wiki/Self-organizing_map).
