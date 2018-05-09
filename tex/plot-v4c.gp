set t po eps enhance co so "Helvetica, 24"

set pointsize 2.5

set xran [0:*]
set yran [0:*]

set out "fig2-v4b.eps"
set size 4,3.1

set multiplot layout 4,4

#############
# panel (a) #
#############

reset
set style line 1 pt 4 lc rgb "#b80033" lw 2
set style line 3 pt 41 lc rgb "#009cfe" lw 2
set style line 2 pt 6 lc rgb "#00bf5b" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set tics nomirror
set boxwidth 0.7

# top left
set origin 0,2.5
set size 1,.45
set yran [0:16]; set ytics 5
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
set border 3
unset xtics
set label "a" at graph -0.17,1.05 font "Helvetica-bold,70"
set label "(mapped to GRCh37+decoy with BWA-MEM)" at graph .03,.95 font "Helvetica,24"
plot \
	"<awk '/flt\t/&&/37d5/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/flt/&&/full/&&/giab/&&/a$/' NA12878-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 2:xtic(8) not ls 3, \
	"<awk '/flt/&&/full/&&/pg/&&/a$/' NA12878-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 2:xtic(8) not ls 2
unset label

# top right
set origin 1,2.5
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:25]; set ytics 5
set ylab "INDEL FPPM" off +.5
set key top left horizontal at graph -0.01,1
unset xtics
plot \
	"<awk '/flt\t/&&/37d5/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Syndip' ls 1, \
	"<awk '/flt/&&/full/&&/giab/&&/a$/' NA12878-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 4:xtic(8) t 'GIAB' ls 3, \
	"<awk '/flt/&&/full/&&/pg/&&/a$/' NA12878-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 4:xtic(8) t 'PlatGen' ls 2

# bottom left
set origin 0,2.05
set size 1,.45
set ylab "SNP %FNR" off +0
set yran [4:0]; set ytics 1
set tmargin 0
set bmargin
set border 2
plot \
	"<awk '/flt\t/&&/37d5/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/flt/&&/full/&&/giab/&&/a$/' NA12878-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 1:xtic(8) not ls 3, \
	"<awk '/flt/&&/full/&&/pg/&&/a$/' NA12878-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 1:xtic(8) not ls 2

# bottom right
set origin 1,2.05
set size 1,.45
set ylab "INDEL %FNR" off +.5
set yran [35:0]; set ytics 10
set tmargin 0
set bmargin
plot \
	"<awk '/flt\t/&&/37d5/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/flt/&&/full/&&/giab/&&/a$/' NA12878-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 3:xtic(8) not ls 3, \
	"<awk '/flt/&&/full/&&/pg/&&/a$/' NA12878-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 3:xtic(8) not ls 2

#############
# panel (b) #
#############

reset
set tics nomirror
set style line 1 pt 4 lc rgb "#b80033" lw 2
set style line 2 pt 6 lc rgb "#00bf5b" lw 2
set style line 3 pt 41 lc rgb "#009cfe" lw 2
set style line 4 pt 22 lc rgb "#8f009e" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 0,1.6
set size 1,.45
set yran [0:16]; set ytics 5
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
set border 3
unset xtics
set label "b" at graph -0.17,1.05 font "Helvetica-bold,70"
set label "(mapped to GRCh37+decoy with BWA-MEM)" at graph .03,.95 font "Helvetica,24"
plot \
	"<awk '/flt\t/&&/37d5/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/flt-s/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) t '' ls 3, \
	"<awk '/flt-u/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 2, \
	"<awk '/flt/&&/a$/&&/37d5/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 2:xtic(8) not ls 4
unset label

# top right
set origin 1,1.6
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:25]; set ytics 5
set ylab "INDEL FPPM" off +.5
set key top left at graph -0.13,1
unset xtics
plot \
	"<awk '/flt\t/&&/37d5/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Whole genome (95%)' ls 1, \
	"<awk '/flt-s/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'No low-comp. reg. (94%)' ls 3, \
	"<awk '/flt-u/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'No hard-to-call reg. (87%)' ls 2, \
	"<awk '/flt/&&/a$/&&/37d5/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 4:xtic(8) t 'Coding+conserved (7.4%)' ls 4

# bottom left
set origin 0,1.15
set size 1,.45
set ylab "SNP %FNR" off +0
set yran [4:0]; set ytics 1
set tmargin 0
set bmargin
set border 2
plot \
	"<awk '/flt\t/&&/37d5/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/flt-s/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) t '' ls 3, \
	"<awk '/flt-u/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 2, \
	"<awk '/flt/&&/a$/&&/37d5/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 1:xtic(8) not ls 4

# bottom right
set origin 1,1.15
set size 1,.45
set ylab "INDEL %FNR" off +.5
set yran [35:0]; set ytics 10
set tmargin 0
set bmargin
plot \
	"<awk '/flt\t/&&/37d5/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/flt-s/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) t '' ls 3, \
	"<awk '/flt-u/&&/a$/' full-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 2, \
	"<awk '/flt/&&/a$/&&/37d5/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 3:xtic(8) not ls 4

#############
# panel (c) #
#############

reset
set tics nomirror
set style line 1 pt 4 lc rgb "#b80033" lw 2
set style line 2 pt 6 lc rgb "#00bf5b" lw 2
set style line 3 pt 41 lc rgb "#009cfe" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 0,0.7
set size 1,.45
set yran [0:30]; set ytics 10
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
set border 3
unset xtics
set label "c" at graph -0.17,1.05 font "Helvetica-bold,70"
set label "(in coding+conserved regions of GRCh37)" at graph .03,.95 font "Helvetica,24"
plot \
	"<awk '/flt-raw/&&/37m/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/flt\t/&&/broad/&&/37m/&&/a$/&&/msb2/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 3, \
	"<awk '/msb2/&&/pp\tpp/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 2:xtic(8) not ls 2
unset label

# top right
set origin 1,0.7
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:7]; set ytics 2
set ylab "INDEL FPPM" off -0.5
set key top left at graph -0.09,1
unset xtics
plot \
	"<awk '/flt-raw/&&/37m/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Unfiltered calls' ls 1, \
	"<awk '/flt\t/&&/broad/&&/37m/&&/a$/&&/msb2/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Filtered calls' ls 3, \
	"<awk '/msb2/&&/pp\tpp/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 4:xtic(8) t 'Platypus filter' ls 2

# bottom left
set origin 0,0.15
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "SNP %FNR" off +0
set yran [3:0]; set ytics 1
set tmargin 0
set bmargin
set border 2
plot \
	"<awk '/flt-raw/&&/37m/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/flt\t/&&/broad/&&/37m/&&/a$/&&/msb2/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 3, \
	"<awk '/msb2/&&/pp\tpp/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 1:xtic(8) not ls 2

# bottom right
set origin 1,0.15
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "INDEL %FNR" off +.5
set yran [22:0]; set ytics 10
set tmargin 0
set bmargin
plot \
	"<awk '/flt-raw/&&/37m/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/flt\t/&&/broad/&&/37m/&&/a$/&&/msb2/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 3, \
	"<awk '/msb2/&&/pp\tpp/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8" u 3:xtic(8) not ls 2

#######################
##### Left column #####
#######################

#############
# panel (d) #
#############

reset
set tics nomirror
set style line 1 pt 4 lc rgb "#b80033" lw 2
set style line 2 pt 6 lc rgb "#00bf5b" lw 2
set style line 3 pt 41 lc rgb "#009cfe" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 2,2.5
set size 1,.45
set yran [0:15]; set ytics 5
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
set border 3
unset xtics
set label "d" at graph -0.17,1.05 font "Helvetica-bold,70"
set label "(in coding+conserved regions; with BWA-MEM)" at graph .03,.95 font "Helvetica,24"
plot \
	"<awk '/a$/&&/37m/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/a$/&&/37d5/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 3, \
	"<awk '/a$/&&/38/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 2
unset label

# top right
set origin 3,2.5
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:7]; set ytics 2
set ylab "INDEL FPPM" off -.5
set key top left at graph 0.03,1
unset xtics
plot \
	"<awk '/a$/&&/37m/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'GRCh37' ls 1, \
	"<awk '/a$/&&/37d5/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'GRCh37+decoy' ls 3, \
	"<awk '/a$/&&/38/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'GRCh38' ls 2

# bottom left
set origin 2,2.05
set size 1,.45
set ylab "SNP %FNR" off +0
set yran [3:0]; set ytics 1
set tmargin 0
set bmargin
set border 2
plot \
	"<awk '/a$/&&/37m/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/a$/&&/37d5/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 3, \
	"<awk '/a$/&&/38/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 2

# bottom right
set origin 3,2.05
set size 1,.45
set ylab "INDEL %FNR" off +.5
set yran [22:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '/a$/&&/37m/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/a$/&&/37d5/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 3, \
	"<awk '/a$/&&/38/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 2

#############
# panel (e) #
#############

reset
set tics nomirror
set style line 1 pt 4 lc rgb "#b80033" lw 2
set style line 2 pt 6 lc rgb "#00bf5b" lw 2
set style line 3 pt 41 lc rgb "#009cfe" lw 2
set style line 4 pt 22 lc rgb "#8f009e" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 2,1.6
set size 1,.45
set yran [0:15]; set ytics 5
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
set border 3
unset xtics
set label "e" at graph -0.17,1.05 font "Helvetica-bold,70"
set label "(in coding+conserved regions of GRCh37)" at graph .03,.95 font "Helvetica,24"
plot \
	"<awk '/a$/&&/37m/&&/msb2/&&/broad/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/a$/&&/37m/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 3, \
	"<awk '/a$/&&/37m/&&/msb2/&&/minimap/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 2, \
	"<awk '/a$/&&/37m/&&/msb2/&&/bowtie/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 4
unset label

# top right
set origin 3,1.6
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:7]; set ytics 2
set ylab "INDEL FPPM" off -.5
set key top left at graph 0.06,1
unset xtics
plot \
	"<awk '/a$/&&/37m/&&/msb2/&&/broad/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'BWA-MEM*' ls 1, \
	"<awk '/a$/&&/37m/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'BWA-MEM' ls 3, \
	"<awk '/a$/&&/37m/&&/msb2/&&/minimap/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'minimap2' ls 2, \
	"<awk '/a$/&&/37m/&&/msb2/&&/bowtie/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Bowtie2' ls 4

# bottom left
set origin 2,1.15
set size 1,.45
set ylab "SNP %FNR" off +0
set yran [3:0]; set ytics 1
set tmargin 0
set bmargin
set border 2
plot \
	"<awk '/a$/&&/37m/&&/msb2/&&/broad/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/a$/&&/37m/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 3, \
	"<awk '/a$/&&/37m/&&/msb2/&&/minimap/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 2, \
	"<awk '/a$/&&/37m/&&/msb2/&&/bowtie/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 4

# bottom right
set origin 3,1.15
set size 1,.45
set ylab "INDEL %FNR" off +.5
set yran [22:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '/a$/&&/37m/&&/msb2/&&/broad/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/a$/&&/37m/&&/msb2/&&/mem/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 3, \
	"<awk '/a$/&&/37m/&&/msb2/&&/minimap/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 2, \
	"<awk '/a$/&&/37m/&&/msb2/&&/bowtie/&&/flt\t/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 4

#############
# panel (f) #
#############

reset
set tics nomirror
set style line 1 pt 4 lc rgb "#b80033" lw 2
set style line 2 pt 6 lc rgb "#00bf5b" lw 2
set style line 3 pt 41 lc rgb "#009cfe" lw 2
set style line 4 pt 22 lc rgb "#8f009e" lw 2
set style line 5 pt 6 lc rgb "#ff663f" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 2,0.7
set size 1,.45
set yran [0:15]; set ytics 5
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
unset xtics
set label "f" at graph -0.17,1.05 font "Helvetica-bold,70"
set label "(in coding+conserved regions of GRCh37)" at graph .03,.95 font "Helvetica,24"
set border 3
plot \
	"<awk '/msb1/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/msb2/&&/37m/&&/broad/&&/flt\t/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 3, \
	"<awk '/msb3/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 2, \
	"<awk '/msb4/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 4, \
	"<awk '/csb12/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 2:xtic(8) not ls 5
unset label

# top right
set origin 3,0.7
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:7]; set ytics 2
set ylab "INDEL FPPM" off -.5
set key top left at graph -0.04,1
unset xtics
plot \
	"<awk '/msb1/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 1' ls 1, \
	"<awk '/msb2/&&/37m/&&/broad/&&/flt\t/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 2' ls 3, \
	"<awk '/msb3/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 3' ls 2, \
	"<awk '/msb4/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 4' ls 4, \
	"<awk '/csb12/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 5*' ls 5

# bottom left
set origin 2,0.15
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "SNP %FNR" off +0
set yran [3:0]; set ytics 1
set tmargin 0
set bmargin
set border 2
plot \
	"<awk '/msb1/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/msb2/&&/37m/&&/broad/&&/flt\t/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 3, \
	"<awk '/msb3/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 2, \
	"<awk '/msb4/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 4, \
	"<awk '/csb12/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 1:xtic(8) not ls 5

# bottom right
set origin 3,0.15
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "INDEL %FNR" off +.5
set yran [22:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '/msb1/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/msb2/&&/37m/&&/broad/&&/flt\t/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 3, \
	"<awk '/msb3/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 2, \
	"<awk '/msb4/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 4, \
	"<awk '/csb12/&&/37m/&&/broad/&&/flt/&&/a$/' func-v4.tsv | awk -f caller-flt-v4.awk | sort -k8,8"  u 3:xtic(8) not ls 5

