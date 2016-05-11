## Getting Started
```sh
# Download and install evaluation suite (Linux only)
wget -O- https://github.com/lh3/CHM-eval/releases/download/v0.1/CHM-evalkit-20160511.tar \
    | tar xf -
# Call CHM1-CHM13 variants in the GRCh37 coordinate (will take a while...)
wget -qO- ftp://ftp.sra.ebi.ac.uk/vol1/ERA596/ERA596361/bam/CHM1_CHM13_2.bam \
    | freebayes -f hs37.fa - > CHM1_CHM13_2.raw.vcf
# Filter (use your own filters if you like)
CHM-eval.kit/run-flt -o CHM1_CHM13_2.flt CHM1_CHM13_2.raw.vcf
# Evaluate
CHM-eval.kit/run-eval -g 37 CHM1_CHM13_2.flt.vcf.gz
more CHM1_CHM13_2.flt.summary
```
