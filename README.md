# Bingo
Social bingo game for the Tools for reproducible research course

# Config
Edit `config.yml` and `meta/text.txt`

# How to run with Conda
```
conda env create -n bingo -f environment.yml
conda activate bingo
snakemake -s Snakefile --configfile config.yml bingo
```

# How to run with Docker
```
docker build -t bingo .
docker run --rm -v $(pwd):/bingo/ bingo
```

# How to run interactively in RStudio from Docker
```
docker run --rm -p 8787:8787 -e PASSWORD=123 -v $(pwd):/home/rstudio/bingo bingo /init
```
Go to http://localhost:8787/ in your browser, log in with rstudio and 123 and change
directory to `bingo/`.
