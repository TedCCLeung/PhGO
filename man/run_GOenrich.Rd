% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_GOenrich.R
\name{run_GOenrich}
\alias{run_GOenrich}
\title{Perform GO term enrichment}
\usage{
run_GOenrich(geneList, simplify_cutoff = 0.5, ont = "BP")
}
\arguments{
\item{geneList}{A list of gene identifiers in TAIR gene identifiers}

\item{simplify_cutoff}{Numeric. Similarity cutoff for simplifying GO terms}

\item{ont}{Character. Ontology.}
}
\value{
Named numeric vector
}
\description{
Perform GO term enrichment
}
