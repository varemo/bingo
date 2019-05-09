rule bingo:
    input:
        rmd = "source/Bingo.Rmd",
        text = config["text"]
    output: "results/Bingo.pdf"
    params:
        pages = config["pages"]
    shadow: "minimal"
    shell:
        """
        Rscript -e "rmarkdown::render('{input.rmd}', \
                    output_dir='results', \
                    output_file='{output}', \
                    params = list(text='{input.text}', \
                    pages={params.pages}))"
        """
