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
