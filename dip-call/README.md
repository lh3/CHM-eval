***The scripts here are deprecated. Please check out the standalone repo [dipcall][dipcall] instead.***

[dipcall]: https://github.com/lh3/dipcall

The `paftools.js` script from [minimap2][mm2] calls variants from
assembly-to-reference alignment. It only works with a haploid assembly. For
phased diploid assembly like syndip or via trio binning, we recommend the
following procedure. It assumes we have two gzip'd FASTA `hap1.fa.gz` and
`hap2.fa.gz` in the working directory, one for each haplotype. 

```sh
# generate alignment in PAF (-r2k for better long INDEL alignment)
ls hap*.fa.gz|sed s,.fa.gz,,|xargs -i echo minimap2 --paf-no-hit -cxasm5 --cs -r2k -t16 hs37d5-asm.mmi {}.fa.gz 2\> {}.paf.log \> {}.paf.gz | parallel
# generate alignment in SAM (changing -c to -a)
ls hap*.fa.gz|sed s,.fa.gz,,|xargs -i echo minimap2 --paf-no-hit -axasm5 --cs -r2k -t16 hs37d5-asm.mmi {}.fa.gz 2\> {}.paf.log \> {}.sam.gz | parallel

# sort SAM
ls hap*.sam.gz|sed s,.sam.gz,,|xargs -i echo ./sam-flt.js {}.sam.gz \| samtools sort -m4G -@4 -o {}.bam - | parallel
# "call" variants with naive mpileup
htsbox pileup -q5 -evcf hs37d5.fa hap*.bam | htsbox bgzip > pair.vcf.gz
# generate phased VCF (-f for a female sample)
./vcf-pair.js -f pair.vcf.gz | htsbox bgzip > final.vcf.gz

# PAF based calls
ls hap*.paf.gz|sed s,.paf.gz,,|xargs -i echo zcat {}.paf.gz \| sort -k6,6 -k8,8n \| paftools.js call - 2\> {}.vst \| gzip \> {}.var.gz | parallel
# orthogonal regions in BED
ls hap*.var.gz | sed s,.var.gz,, | xargs -i echo gzip -dc {}.var.gz \| grep ^R \| cut -f2- \> {}.bed | parallel
# generate confident regions; extra care needed for male samples
bedtools intersect -a hap1.bed -b hap2.bed > final.bed
```

This pipeline depends on [htsbox][htsbox]. Syndip adds one additional step to
exclude clustered variants from confident regions.

If you use this pipeline, please cite:

> Li H, Bloom JM, Farjoun Y, Fleharty M, Gauthier L, Neale B, MacArthur D
> (2018) A synthetic-diploid benchmark for accurate variant-calling
> evaluation. *Nat Methods*, **15**:595-597. [PMID:30013044]

[mm2]: https://github.com/lh3/minimap2
[htsbox]: https://github.com/lh3/htsbox
