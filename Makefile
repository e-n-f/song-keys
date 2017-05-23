all: foo.png

foo.png: foo.pdf
	gs -sDEVICE=png16m -sOutputFile=foo.png -dBATCH -dNOPAUSE -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -r150x150 foo.pdf

foo.pdf: foo.ps
	ps2pdf foo.ps

foo.ps: plot-song-keys avg
	gnuplot plot-song-keys > foo.ps

avg: song-keys
	cat song-keys | awk '/^[0-9][0-9][0-9][0-9] / { sum[$$1] += $$2; count[$$1]++; sum[$$1 - 1] += $$2; count[$$1 - 1]++; sum[$$1 + 1] += $$2; count[$$1 + 1]++} END { for (i in sum) { print i, sum[i] / count[i]}}' | sort -n > avg	
