ls hs3*.fa|sed s,.fa,,|sed s,^hs,,|xargs -i echo ./minimap2 -cxasm5 -t8 --cs hs{}.fa oa.fa 2\> oa.n{}.paf.log \| gzip \> oa.n{}.paf.gz|sh
ls hs3*.fa|sed s,.fa,,|sed s,^hs,,|xargs -i echo ./minimap2 -cxasm5 -t8 --cs hs{}.fa ta.fa 2\> ta.n{}.paf.log \| gzip \> ta.n{}.paf.gz|sh

ls hs3*.fa|sed s,.fa,,|sed s,^hs,,|xargs -i echo ./minimap2 -axasm5 -t8 --cs hs{}.fa oa.fa 2\> oa.n{}.sam.log \| gzip \> oa.n{}.sam.gz|sh
ls hs3*.fa|sed s,.fa,,|sed s,^hs,,|xargs -i echo ./minimap2 -axasm5 -t8 --cs hs{}.fa ta.fa 2\> ta.n{}.sam.log \| gzip \> ta.n{}.sam.gz|sh

ls *.sam.gz|sed s,.sam.gz,,|xargs -i echo ./sam-flt.js {}.sam.gz \| samtools sort -m4G -@4 -o {}.bam - | sh
cat 01build.txt | xargs -i echo htsbox pileup -q5 -evcf ../31asm/hs{}.fa {o,t}a.n{}.bam \| bgzip \> ma.n{}.pair.vcf.gz | parallel
ls ma*.pair.vcf.gz | sed s,.pair.vcf.gz,, | xargs -i echo 02src/vcf-pair.js {}.pair.vcf.gz \| bgzip \> {}.final.vcf.gz | parallel
ls ma.n*.vcf.gz | xargs -i echo ~/bin/tabix -fpvcf {} | parallel

ls *.paf.gz|sed s,.gz,,|xargs -i echo zcat {}.gz \| sort -k6,6 -k8,8n \| paftools.js call - 2\> {}.vst \| gzip \> {}.var.gz | sh
ls *.var.gz | sed s,.var.gz,, | xargs -i echo zcat {}.var.gz \| grep ^R \| cut -f2-4 \> {}.bed | sh

ls {o,t}s.self.vcf.gz|sed s,.vcf.gz,,|xargs -i echo zcat {}.vcf.gz \| grep -v ^# \| cut -f1,2 \| 02src/clustreg.js -n3 \> {}.f1.bed | sh
ls {o,t}s.*.vcf.gz | sed s,.vcf.gz,, | xargs -i echo ./select-hom.js {}.vcf.gz \> {}.f2.bed | parallel
ls {o,t}s.*.vcf.gz | sed s,.vcf.gz,, | xargs -i echo ./select-het.js {}.vcf.gz \> {}.f3.bed | parallel
cat os.self.f{1,2,3}.bed os.htsbox.f2.bed | sort-alt -k1,1N -k2,2n | k8tk.js bedmerge | 02src/merge-close.js > os.self.fb.bed
cat ts.self.f{1,2,3}.bed ts.htsbox.f2.bed | sort-alt -k1,1N -k2,2n | k8tk.js bedmerge | 02src/merge-close.js > ts.self.fb.bed

ls oa.n{37d5,37m,38}.paf.gz|sed s,.paf.gz,,|xargs -i echo paftools.js liftover {}.paf.gz os.self.fb.bed \> {}.fb.bed | sh
ls ta.n{37d5,37m,38}.paf.gz|sed s,.paf.gz,,|xargs -i echo paftools.js liftover {}.paf.gz ts.self.fb.bed \> {}.fb.bed | sh
ls {o,t}a.n{37d5,37m,38}.paf.gz | sed s,.paf.gz,,|xargs -i echo gzip -dc {}.paf.var.gz \| cut -f2,3 \| sort-alt -k1,1N -k2,2n \| 02src/clustreg.js -0w50 -W250 -n10 \> {}.fd.bed | parallel
ls *.paf.bed|sed s,.paf.bed,,|xargs -i echo cat '{}.f{b,d}.bed'\|sort-alt -k1,1N -k2,2n\|k8tk.js bedmerge\|02src/merge-close.js\|bedtools subtract -a {}.paf.bed -b - \> {}.final.bed | parallel
cat 01build.txt | xargs -i echo bedtools intersect -a oa.n{}.final.bed -b ta.n{}.final.bed\|grep -v _random\|grep -v ^GL\|grep -v ^chrUn\|grep -v ^hs37d5\|sort-alt -k1,1N -k2,2n \> ma.n{}.final.bed | sh



(./minimap2 -axsr -t8 CHM1_FC_P6.fa <(zcat osw1.fq.gz osw2.fq.gz) | samtools sort -m2G -@4 - > osw.bam) > osw.bam.log 2>&1
(./minimap2 -axsr -t8 CHM13_FC.fa <(zcat tsw1.fq.gz tsw2.fq.gz) | samtools sort -m2G -@4 - > tsw.bam) > tsw.bam.log 2>&1
htsbox pileup -vcf CHM1_FC_P6.fa -s3 -Q20 -q20 osw.bam > osw.vcf
htsbox pileup -vcf CHM13_FC.fa -s3 -Q20 -q20 tsw.bam > tsw.vcf
