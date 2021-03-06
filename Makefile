all: tests notebook.ps notebook.pdf

clean: clean_tests clean_formatting

tests: test_algebra test_artbridge test_bellmanford test_vector test_plane_geometry test_polygon test_floydwarshall test_KMP test_SCC test_suffix_array test_float_compare test_mincostmaxflow test_pushrelabel test_segment_tree test_maxcard_bm test_mincost_bm test_kdtree test_bit test_fft test_rat test_uf test_kruskal test_edmondskarp test_dinic test_lca test_aho_corasick

test_algebra: Algebra.cc
	g++ -o test_algebra -DBUILD_TEST_ALGEBRA Algebra.cc -pedantic -Wall -O2 -std=c++11

test_linearalgebra: LinearAlgebra.cc
	g++ -o test_linearalgebra LinearAlgebra.cc -pedantic -Wall -O2 -std=c++11

test_artbridge: ArtBridge.cc
	g++ -o test_artbridge ArtBridge.cc -pedantic -Wall -O2 -std=c++11

test_bellmanford: BellmanFord.cc
	g++ -o test_bellmanford BellmanFord.cc -pedantic -Wall -O2

test_vector: Vector.cc
	g++ -o test_vector -DBUILD_TEST_VECTOR Vector.cc -pedantic -Wall -O2

test_plane_geometry: PlaneGeometry.cc
	g++ -o test_plane_geometry -DBUILD_TEST_PLANE_GEOMETRY PlaneGeometry.cc -pedantic -Wall -O2

test_polygon: Polygon.cc
	g++ -o test_polygon -DBUILD_TEST_POLYGON Polygon.cc -pedantic -Wall -O2

test_floydwarshall: FloydWarshall.cc
	g++ -o test_floydwarshall FloydWarshall.cc -pedantic -Wall -O2

test_KMP: KMP.cc
	g++ -o test_KMP KMP.cc -pedantic -Wall -O2

test_aho_corasick: AhoCorasick.cc
	g++ -o test_aho_corasick AhoCorasick.cc -pedantic -Wall -O2 -std=c++11

test_SCC: SCC.cc
	g++ -o test_SCC SCC.cc -pedantic -Wall -O2

test_suffix_array: SuffixArray.cc
	g++ -o test_suffix_array SuffixArray.cc -pedantic -Wall -O2

test_float_compare: FloatCompare.cc
	g++ -o test_float_compare -DTEST_FLOAT_COMPARE FloatCompare.cc -O2 -pedantic -Wall

test_mincostmaxflow: MinCostMaxFlow.cc
	g++ -o test_mincostmaxflow MinCostMaxFlow.cc -O2 -pedantic -Wall

test_pushrelabel: MaximumFlow-PushRelabel.cc
	g++ -o test_pushrelabel MaximumFlow-PushRelabel.cc -O2 -pedantic -Wall

test_segment_tree: SegmentTree.cc
	g++ -o test_segment_tree SegmentTree.cc -O2 -pedantic -Wall

test_maxcard_bm: MaxCardBipartiteMatching.cc
	g++ -o test_maxcard_bm MaxCardBipartiteMatching.cc -O2 -pedantic -Wall

test_mincost_bm: MinCostBipartiteMatching.cc
	g++ -o test_mincost_bm MinCostBipartiteMatching.cc -O2 -pedantic -Wall

test_kdtree: KDtree.cc
	g++ -o test_kdtree KDtree.cc -O2 -pedantic -Wall

test_bit: BIT.cc
	g++ -o test_bit BIT.cc -O2 -pedantic -Wall

test_fft: FFT.cc
	g++ -o test_fft FFT.cc -O2 -pedantic -Wall

test_rat: Rational.cc
	g++ -o test_rat -DBUILD_TEST_RATIONAL Rational.cc -O2 -pedantic -Wall

test_uf: UnionFind.cc
	g++ -o test_uf -DBUILD_TEST_UF UnionFind.cc -O2 -pedantic -Wall

test_kruskal: Kruskal.cc
	g++ -o test_kruskal -DBUILD_TEST_KRUSKAL Kruskal.cc -O2 -pedantic -Wall

test_edmondskarp: MaximumFlow-EdmondsKarp.cc
	g++ -o test_edmondskarp MaximumFlow-EdmondsKarp.cc -O2 -pedantic -Wall

test_dinic: MaximumFlow-Dinic.cc
	g++ -o test_dinic MaximumFlow-Dinic.cc -O2 -pedantic -Wall

test_lca: LCA.cc
	g++ -o test_lca LCA.cc -O2 -pedantic -Wall

clean_tests:
	rm -f test_*

SOURCES = \
	ArtBridge.cc BellmanFord.cc FloydWarshall.cc MaximumFlow-EdmondsKarp.cc MaximumFlow-Dinic.cc MaximumFlow-PushRelabel.cc MinCostMaxFlow.cc SCC.cc LCA.cc\
	Algebra.cc LinearAlgebra.cc Simplex.cc FFT.cc \
	FloatCompare.cc Vector.cc PlaneGeometry.cc Polygon.cc \
	KMP.cc AhoCorasick.cc SuffixArray.cc SegmentTree.cc MaxCardBipartiteMatching.cc MinCostBipartiteMatching.cc KDtree.cc BIT.cc Rational.cc UnionFind.cc Kruskal.cc

COMPILED = $(SOURCES:%.cc=%.cc.compiled)

LIBRARY = vimrc $(COMPILED)

%.cc.compiled: %.cc
	python process_file.py $< $@

clean_formatting:
	rm -f $(COMPILED)
	rm -f notebook.{aux,log,dvi,ps}
	rm -f notebook_small.{aux,log,dvi,ps}
	rm -rf _minted-notebook

notebook.ps: notebook.dvi
	dvips notebook

notebook.dvi: notebook.tex $(LIBRARY)
	latex -shell-escape notebook
	latex -shell-escape notebook

notebook.pdf: notebook.tex $(LIBRARY)
	pdflatex --shell-escape notebook
	pdflatex --shell-escape notebook

notebook_small.pdf: notebook_small.tex $(LIBRARY)
	pdflatex --shell-escape notebook_small
	pdflatex --shell-escape notebook_small
