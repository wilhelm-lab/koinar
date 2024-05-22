# KoinaR

## Installation

We are currently waiting for KoinaR to be accepted into bioconductor until then you can install the package directly from github.
To do that you will need to install devtools `install.packages('devtools')`.

Install KoinaR by running `devtools::install_github('wilhelm-lab/koinar')`

## Usage

```
input <- data.frame(
  peptide_sequences = c("LGGNEQVTR", "GAGSSEPVTGLDAK"),
  collision_energies = c(25, 25),
  precursor_charges = c(1, 2)
)

prosit2019 <- koinar::Koina$new(
  model_name = "Prosit_2019_intensity",
  server_url = "koina.wilhelmlab.org:443"
)

prediction_results <- prosit2019$predict(input)
```

## Contribute
### Setup dependencies
I recommend using the `rocker/rstudio` docker container for development.

```bash
docker run \
  -p 8888:8787 \
  -d \
  --name rstudio_server \
  -v $HOME:/workspace \
  -e PASSWORD=password \
  -e USERID=$(id -u) \
  -e GROUPID=$(id -g) \
  rocker/rstudio:latest
```

```R
install.packages(c("roxygen2", "BiocManager", "httr", "jsonlite", "rmarkdown", "testthat", "pdflatex", "protViz"))
BiocManager::install(c('BiocStyle', 'BiocCheck'))
```

Dependencies to build vignette with Knit
```bash
apt-get install texlive-latex-base texlive-fonts-extra
```


### Build documentation
Use roxygen2 to create documentation based on inline comments. 
`roxygen2::roxygenise()`.

### Run tests
We use testthat to run tests. In the `build` tab in Rstudio click on `Test`. 
Make sure you installed the package beforehand by clicking `Install` in the build tab.

### Verify code style
Verify code style according to bioconductor guidelines.
`BiocCheck::BiocCheck()`
