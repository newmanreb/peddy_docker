# peddy_v1.6

peddy compares familial-relationships and sexes as reported in a [PED/FAM file](https://www.cog-genomics.org/plink2/formats#fam)
with those inferred from a VCF.

It samples the VCF at about 25000 sites (plus chrX) to accurately estimate **relatedness**, **IBS0**, **heterozygosity**, **sex** and **ancestry**. It uses 2504 thousand genome samples as backgrounds to calibrate the relatedness calculation and to make ancestry predictions.

It does this very quickly by sampling, by using C for computationally intensive parts, and by parallelization.

Peddy Citation: [Pedersen and Quinlan, Who’s Who? Detecting and Resolving Sample Anomalies in Human DNA
Sequencing Studies with Peddy, The American Journal of Human Genetics (2017),
http://dx.doi.org/10.1016/j.ajhg.2017.01.017](http://www.cell.com/action/showFullTextImages?pii=S0002-9297(17)30017-4)

## Required inputs 
- merged, multi-sample vcf with sample headers renamed to match filenames in format *.vcf.gz
- tabix index of merged vcf in format *.vcf.gz.tbi 
- tab-delimited .fam file describing sample metadata (family ID, individual ID, sex code) in format ped.<project>.fam 

## Expected outputs 
#### Key outputs 
- ped.peddy.ped - an array of peddy output data 
- ped.het_check.csv - output data for heterozygosity calculations
- ped.ped_check.csv - output data for pedigree check calculations
- ped.sex_check.csv - output data for sex check calculations
- ped.sex_check.png - figure displaying observed vs. expected sex outcomes 

#### Other outputs 
- ped.background_pca.json
- ped.het_check.png
- ped.html
- ped.pca_check.png
- ped.ped_check.png
- ped.ped_check.rel-difference.csv
- ped.vs.html

## Docker image
Build the docker container which contains all scripts with `make`

The docker image can be run as follows:
```
docker run -v $PWD:/data <image_name> \
    peddy --plot -p 4 \
    --prefix /data/ped \
    /data/<<project>_merged.vcf.gz> \
    /data/<ped.<project>.fam>
```