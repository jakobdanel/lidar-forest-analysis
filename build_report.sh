#!/bin/bash

Rscript build_report.R
quarto render results/report.qmd --to=html
