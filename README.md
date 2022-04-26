## depth_doct.R

This is my script for parsing the `ANGSD` output from `-doDepth`

`-doDepth` has an issue because it does not calculate the number of positions with zero reads mapped. This may be important in some situations, for e.g. ancient DNA. You should first run `-doDepth` in `ANGSD`, e.g.:

```
angsd -b my_bamfile.bam -doCounts 1 -doDepth 1 -minQ 30 -minMapQ 30 -out my_output
```

The file you want is **my_output.depthSample**. This is a tab delimited file with the number of genome positions covered by 0, 1, 2, 3, 4, 5, x... reads. Note the number of positions with zero reads mapping is invariably "0", which is invariably wrong

You need to edit the **depth_doct.R** script to include the length of the reference genome used for mapping, after any filters are applied in `ANGSD` (e.g. `-rf`). This is critical. I hard coded it because I am lazy and I mostly work on bears. Then you run the script in the terminal:

```
Rscript depth_doct.R my_output.depthSample
```

The script comes with the correct genome size value for the polar bear reference genome with scaffolds < 1 Mb removed. There are some test datasets from cave bears (see Barlow et al. 2021. Current Biology) that you can try out. The script tells you the integer below the 95th percentile of depth, and makes some pictures. The former can be used for e.g. as a max depth filter in `Consensify` (see https://github.com/jlapaijmans/Consensify)

I hope you find my code useful,

Axel

