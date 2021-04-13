.DELETE_ON_ERROR:

TONLY=mesomics.tonly.purple.cnv.somatic.filtered.tsv
MATCHED=mesomics.matched.purple.cnv.somatic.tsv
AA_CODE=/home/programs/AmpliconArchitect-master/src
MOSEKLM_LICENSE_FILE=/data/scratch/digenovaa/mesomics/AMPARCHITECT/mosek/mosek.lic
AA_DATA_REPO=/home/digenovaa/scratch/mesomics/AMPARCHITECT/
export AA_DATA_REPO
export MOSEKLM_LICENSE_FILE

samples=$(shell cat samples.txt | xargs)


# prepare target amplicon files
split_in_bed.txt:
	cat ${TONLY} ${MATCHED} | awk '{if($$1 !="sample"){print $$2"\t"$$3"\t"$$4"\t"$$5 > $$1".cnv.bed"}}'
	touch $@


# we select the target amplicon regions for each sample
cnv_bed=$(addsuffix .cnv.bed,$(samples))
aa_files=$(patsubst %.cnv.bed,%.cnv.aa.bed,$(cnv_bed))
%.cnv.aa.bed:%.cnv.bed split_in_bed.txt
	python2 ${AA_CODE}/amplified_intervals.py --gain 4.5 --cnsize_min 50000 --ref GRCh38 --bed $<  --out $(subst .bed,,$@)
filter_cnv:$(aa_files)

# we run amplicon architect on samples with the appropiate number of seed (> 0 & <70 by default))
aa_run_files=$(patsubst %.cnv.aa.bed,%.aa.done,$(aa_files))
%.aa.done:%.cnv.aa.bed
	perl run-aa.pl $<  $(subst .cnv.aa.bed,,$<) > $(subst .cnv.aa.bed,,$<).aa.log 2> $(subst .cnv.aa.bed,,$<).aa.err
run_aa:$(aa_run_files)

# we run amplicon classifier
all_amplicons_amplicon_classification_profiles.tsv: $(aa_run_files)
	find ${PWD} -name "*_cycles.txt" | sed 's/_cycles.txt//' |awk '{split($$0,a,"/"); print a[9]" "$$0"_cycles.txt "$$0"_graph.txt"}' > all_amplicons.txt
	 python2 /home/programs/AmpliconClassifier/amplicon_classifier.py --ref GRCh38 --input all_amplicons.txt 

all : split_in_bed.txt filter_cnv run_aa all_amplicons_amplicon_classification_profiles.tsv
clean :
	rm -f split_in_bed.txt

