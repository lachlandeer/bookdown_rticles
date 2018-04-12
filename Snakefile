# Bookdown + rtciles Example
#
# rticle-style: AEA
#
# contributor: @lachlandeer

import glob, os

# --- PROJECT NAME --- #

PROJ_NAME = "my_project_title"

# --- Dictionaries --- #
RMD_FILES  = glob.glob("*.Rmd")
YAML_FILES = glob.glob("*.yml")
CSS_FILES  = glob.glob("*.css")
BIB_FILES  = glob.glob("*.bib")
TEX_FILES  = glob.glob("*.tex")
CLS_FILES  = glob.glob("*.cls")

# --- Variable Declarations ---- #
runR = "Rscript --no-save --no-restore --verbose"
logAll = "2>&1"

# --- Build Rules --- #

rule all:
    input:
        pdf  = "_book/rtciles-demo.pdf",
        html = "_book/rtciles-demo.html"
    output:
        pdf  = PROJ_NAME + ".pdf",
    shell:
        "cp {input.pdf} {output.pdf}"

rule pdf:
    input:
        text_files = RMD_FILES,
        yaml_files = YAML_FILES,
        biblo      = BIB_FILES,
        tex_style  = TEX_FILES,
        #cls_file   = CLS_FILES,
        runner     = "build_pdfbook.R"
    output:
        "_book/rtciles-demo.pdf"
    log:
        "log/build_pdf.Rout"
    shell:
        "{runR} {input.runner} > {log} {logAll}"

rule html:
    input:
        text_files = RMD_FILES,
        yaml_files = YAML_FILES,
        biblo      = BIB_FILES,
        css_style  = CSS_FILES,
        runner     = "build_htmlbook.R"
    output:
        "_book/rtciles-demo.html"
    log:
        "log/build_pdf.Rout"
    shell:
        "{runR} {input.runner} > {log} {logAll}"

rule clean:
    shell:
        "rm -rf _book/* bookdown_files/* *.pdf *.html"
