# KoinaR

## Introduction
Koina is a repository of machine learning models enabling the remote execution of models. Predictions are generated as a response to HTTP/S requests, the standard protocol used for nearly all web traffic. As such, HTTP/S requests can be easily generated in any programming language without requiring specialized hardware. This design enables users to easily access ML/DL models that would normally required specialized hardware from any device and in any programming language. It also means that the hardware is used more efficiently and it allows for easy horizontal scaling depending on the demand of the user base.

To minimize the barrier of entry and “democratize” access to ML models, we provide a public network of Koina instances at koina.wilhelmlab.org. The computational workload is automatically distributed to processing nodes hosted at different research institutions and spin-offs across Europe. Each processing node provides computational resources to the service network, always aiming at just-in-time results delivery.

In the spirit of open and collaborative science, we envision that this public Koina-Network can be scaled to meet the community’s needs by various research groups or institutions dedicating hardware. This can also vastly improve latency if servers are available geographically nearby. Alternatively, if data security is a concern, private instances within a local network can be easily deployed using the provided docker image.

Koina is a community driven project. It is fuly open-source. We welcome all contributions and feedback! Feel free to reach out to us or open an issue on our GitHub repository.

At the moment Koina mostly focuses on the Proteomics domain but the design can be easily extended to any machine learning model. Active development to expand it into Metabolomics is underway. If you are interested in using Koina to interface with a machine learning model not currently available feel free to [create a request](https://github.com/wilhelm-lab/koina/issues).

Here we take a look at KoinaR the R package to simplify getting predictions from Koina. 

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
install.packages(c("roxygen2", "BiocManager", "httr", "jsonlite", "rmarkdown", "testthat", "pdflatex", "protViz", "OrgMassSpecR"))
BiocManager::install(c('BiocStyle', 'BiocCheck', 'Spectra', 'msdata'))
```

Dependencies to build vignette with Knit
```bash
apt update
apt-get install texlive-latex-base texlive-fonts-extra mono-runtime zlib1g-dev libnetcdf19
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
