set t po eps enhance co so "Helvetica, 24"

set style line 1 pt 4 lc rgb "#FF0000" lw 2
set style line 2 pt 41 lc rgb "#00C000" lw 2
set style line 3 pt 6 lc rgb "#0080FF" lw 2
set style line 4 pt 22 lc rgb "#C000FF" lw 2
set style line 5 pt 12 lc rgb "#00EEEE" lw 2
set style line 6 pt 8 lc rgb "#C04000" lw 2

set pointsize 2.5

set xran [0:*]
set yran [0:*]

set out "fig1.eps"
set size 4,3.1

set multiplot layout 4,4

#############
# panel (a) #
#############

reset
set style line 1 pt 4 lc rgb "#FF0000" lw 2
set style line 2 pt 41 lc rgb "#00C000" lw 2
set style line 3 pt 6 lc rgb "#0080FF" lw 2
set style line 4 pt 22 lc rgb "#C000FF" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 0,2.55
set size 1,.45
set yran [0:7]; set ytics 2
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +0
unset xtics
set label "a" at graph -0.17,1.2 font "Helvetica-bold,70"
set label "(mapped to GRCh37+decoy with BWA-MEM)" at graph .03,.9 font "Helvetica,24"
plot \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/flt/&&/giab/' NA12878.txt | awk -f caller-flt.awk | sort -k8,8" u 2:xtic(8) not ls 3, \
	"<awk '/flt/&&/pg/' NA12878.txt | awk -f caller-flt.awk | sort -k8,8" u 2:xtic(8) not ls 2
unset label

# top right
set origin 1,2.55
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:6.2]; set ytics 2
set ylab "INDEL FPPM" off -.5
set key bot left at -1.0,3.70
unset xtics
plot \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Syndip' ls 1, \
	"<awk '/flt/&&/giab/' NA12878.txt | awk -f caller-flt.awk | sort -k8,8" u 4:xtic(8) t 'GIAB' ls 3, \
	"<awk '/flt/&&/pg/' NA12878.txt | awk -f caller-flt.awk | sort -k8,8" u 4:xtic(8) t 'PlatGen' ls 2

# bottom left
set origin 0,2
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "SNP %FNR" off +0
set yran [5:0]; set ytics 1
set tmargin 0
set bmargin
plot \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/flt/&&/giab/' NA12878.txt | awk -f caller-flt.awk | sort -k8,8" u 1:xtic(8) not ls 3, \
	"<awk '/flt/&&/pg/' NA12878.txt | awk -f caller-flt.awk | sort -k8,8" u 1:xtic(8) not ls 2

# bottom right
set origin 1,2
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "INDEL %FNR" off +.5
set yran [17:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/flt/&&/giab/' NA12878.txt | awk -f caller-flt.awk | sort -k8,8" u 3:xtic(8) not ls 3, \
	"<awk '/flt/&&/pg/' NA12878.txt | awk -f caller-flt.awk | sort -k8,8" u 3:xtic(8) not ls 2

#############
# panel (b) #
#############

reset
set style line 1 pt 4 lc rgb "#FF0000" lw 2
set style line 2 pt 41 lc rgb "#00C000" lw 2
set style line 3 pt 6 lc rgb "#0080FF" lw 2
set style line 4 pt 22 lc rgb "#C000FF" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 0,1.55
set size 1,.45
set yran [0:30]; set ytics 5
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
unset xtics
set label "b" at graph -0.17,1.2 font "Helvetica-bold,70"
set label "(mapped to GRCh37+decoy with BWA-MEM)" at graph .03,.9 font "Helvetica,24"
plot \
	"<awk '$NF==\"raw\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 3
unset label

# top right
set origin 1,1.55
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:6.2]; set ytics 2
set ylab "INDEL FPPM" off -.5
set key bot left at -1.8,4.35
unset xtics
plot \
	"<awk '$NF==\"raw\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Unfiltered calls' ls 1, \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Filtered calls' ls 3

# bottom left
set origin 0,1
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "SNP %FNR" off +0
set yran [5:0]; set ytics 1
set tmargin 0
set bmargin
plot \
	"<awk '$NF==\"raw\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 3

# bottom right
set origin 1,1
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "INDEL %FNR" off +.5
set yran [17:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '$NF==\"raw\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 3

#############
# panel (c) #
#############

reset
set style line 1 pt 4 lc rgb "#FF0000" lw 2
set style line 2 pt 41 lc rgb "#00C000" lw 2
set style line 3 pt 6 lc rgb "#0080FF" lw 2
set style line 4 pt 22 lc rgb "#C000FF" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 0,0.55
set size 1,.45
set yran [0:7]; set ytics 2
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +0
unset xtics
set label "c" at graph -0.17,1.2 font "Helvetica-bold,70"
set label "(mapped to GRCh37+decoy with BWA-MEM)" at graph .03,.9 font "Helvetica,24"
plot \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '$NF==\"flt-c\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 3, \
	"<awk '$NF==\"flt-u\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 2, \
	"<cat hs37d5-func.txt | awk -f caller-flt.awk | sort -k8,8" u 2:xtic(8) not ls 4
unset label

# top right
set origin 1,0.55
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:6.2]; set ytics 2
set ylab "INDEL FPPM" off -.5
set key bot left at -2.1,2.95
unset xtics
plot \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Whole genome (95%)' ls 1, \
	"<awk '$NF==\"flt-c\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'No low-comp. reg. (94%)' ls 3, \
	"<awk '$NF==\"flt-u\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'No hard-to-call reg. (87%)' ls 2, \
	"<cat hs37d5-func.txt | awk -f caller-flt.awk | sort -k8,8" u 4:xtic(8) t 'Coding+conserved (7.4%)' ls 4

# bottom left
set origin 0,0
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "SNP %FNR" off +0
set yran [5:0]; set ytics 1
set tmargin 0
set bmargin
plot \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '$NF==\"flt-c\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 3, \
	"<awk '$NF==\"flt-u\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 2, \
	"<cat hs37d5-func.txt | awk -f caller-flt.awk | sort -k8,8" u 1:xtic(8) not ls 4

# bottom right
set origin 1,0
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "INDEL %FNR" off +.5
set yran [17:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '$NF==\"flt\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '$NF==\"flt-c\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 3, \
	"<awk '$NF==\"flt-u\"' hs37d5-all.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 2, \
	"<cat hs37d5-func.txt | awk -f caller-flt.awk | sort -k8,8" u 3:xtic(8) not ls 4

#############
# panel (d) #
#############

reset
set style line 1 pt 4 lc rgb "#FF0000" lw 2
set style line 2 pt 41 lc rgb "#00C000" lw 2
set style line 3 pt 6 lc rgb "#0080FF" lw 2
set style line 4 pt 22 lc rgb "#C000FF" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 2,2.55
set size 1,.45
set yran [0:11]; set ytics 2
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
unset xtics
set label "d" at graph -0.17,1.2 font "Helvetica-bold,70"
set label "(mapped with BWA-MEM)" at graph .03,.9 font "Helvetica,24"
plot \
	"<awk '/msb2/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/bwamem/' hs38-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 3, \
	"<awk '/bwamem/' hs37d5-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 2
unset label

# top right
set origin 3,2.55
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:.8]; set ytics .2
set ylab "INDEL FPPM" off +1
set key bot left at -.85,0.47
unset xtics
plot \
	"<awk '/msb2/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'GRCh37' ls 1, \
	"<awk '/bwamem/' hs38-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'GRCh38' ls 3, \
	"<awk '/bwamem/' hs37d5-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'GRCh37+decoy' ls 2

# bottom left
set origin 2,2
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "SNP %FNR" off +0
set yran [4.1:0]; set ytics 1
set tmargin 0
set bmargin
plot \
	"<awk '/msb2/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/bwamem/' hs38-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 3, \
	"<awk '/bwamem/' hs37d5-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 2

# bottom right
set origin 3,2
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "INDEL %FNR" off +0
set yran [19:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '/msb2/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/bwamem/' hs38-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 3, \
	"<awk '/bwamem/' hs37d5-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 2

#############
# panel (e) #
#############

reset
set style line 1 pt 4 lc rgb "#FF0000" lw 2
set style line 2 pt 41 lc rgb "#00C000" lw 2
set style line 3 pt 6 lc rgb "#0080FF" lw 2
set style line 4 pt 22 lc rgb "#C000FF" lw 2
set style line 5 pt 6 lc rgb "#ff7f00" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 2,1.55
set size 1,.45
set yran [0:11]; set ytics 2
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
unset xtics
set label "e" at graph -0.17,1.2 font "Helvetica-bold,70"
set label "(mapped to GRCh37)" at graph .03,.9 font "Helvetica,24"
plot \
	"<awk '/broad/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/bwamem/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 3, \
	"<awk '/bowtie2/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 2, \
	"<awk '/minimap2/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 4, \
	"<awk '/snap/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 5
unset label

# top right
set origin 3,1.55
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:.8]; set ytics .2
set ylab "INDEL FPPM" off +1
set key bot left at -0.65,0.28
unset xtics
plot \
	"<awk '/broad/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'BWA-MEM+BQSR+ReAln' ls 1, \
	"<awk '/bwamem/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'BWA-MEM' ls 3, \
	"<awk '/bowtie2/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Bowtie2' ls 2, \
	"<awk '/minimap2/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'minimap2' ls 4, \
	"<awk '/snap/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'SNAP' ls 5

# bottom left
set origin 2,1
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "SNP %FNR" off +0
set yran [4.1:0]; set ytics 1
set tmargin 0
set bmargin
plot \
	"<awk '/broad/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/bwamem/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 3, \
	"<awk '/bowtie2/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 2, \
	"<awk '/minimap2/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 4, \
	"<awk '/snap/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 5

# bottom right
set origin 3,1
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "INDEL %FNR" off +0
set yran [19:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '/broad/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/bwamem/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 3, \
	"<awk '/bowtie2/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 2, \
	"<awk '/minimap2/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 4, \
	"<awk '/snap/&&/msb2/' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 5

#############
# panel (f) #
#############

reset
set style line 1 pt 4 lc rgb "#FF0000" lw 2
set style line 2 pt 41 lc rgb "#00C000" lw 2
set style line 3 pt 6 lc rgb "#0080FF" lw 2
set style line 4 pt 22 lc rgb "#C000FF" lw 2
set style line 5 pt 6 lc rgb "#ff7f00" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.7

# top left
set origin 2,0.55
set size 1,.45
set yran [0:11]; set ytics 2
set lmargin 8
set bmargin 0
set ylab "SNP FPPM" off +1
unset xtics
set label "f" at graph -0.17,1.2 font "Helvetica-bold,70"
set label "(mapped to GRCh37)" at graph .03,.9 font "Helvetica,24"
plot \
	"<awk '/msb1/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 1, \
	"<awk '/msb2/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 3, \
	"<awk '/msb3/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 2, \
	"<awk '/msb4/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 4, \
	"<awk '/csb12/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 2:xtic(8) not ls 5
unset label

# top right
set origin 3,0.55
set size 1,.45
set lmargin 8
set bmargin 0
set yran [0:.8]; set ytics .2
set ylab "INDEL FPPM" off +1
set key bot left at -1.4,0.29
unset xtics
plot \
	"<awk '/msb1/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 1' ls 1, \
	"<awk '/msb2/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 2' ls 3, \
	"<awk '/msb3/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 3' ls 2, \
	"<awk '/msb4/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 4' ls 4, \
	"<awk '/csb12/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 4:xtic(8) t 'Replicate 5*' ls 5

# bottom left
set origin 2,0
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "SNP %FNR" off +0
set yran [4.1:0]; set ytics 1
set tmargin 0
set bmargin
plot \
	"<awk '/msb1/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 1, \
	"<awk '/msb2/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 3, \
	"<awk '/msb3/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 2, \
	"<awk '/msb4/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 4, \
	"<awk '/csb12/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 1:xtic(8) not ls 5

# bottom right
set origin 3,0
set size 1,.55
set xtic rotate by -30 scale 0
set ylab "INDEL %FNR" off +0
set yran [19:0]; set ytics 5
set tmargin 0
set bmargin
plot \
	"<awk '/msb1/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 1, \
	"<awk '/msb2/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 3, \
	"<awk '/msb3/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 2, \
	"<awk '/msb4/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 4, \
	"<awk '/csb12/&&((/broad/&&!/FermiKit/)||(/bwamem/&&/FermiKit/))' hs37m-func.txt | awk -f caller-flt.awk | sort -k8,8"  u 3:xtic(8) not ls 5

