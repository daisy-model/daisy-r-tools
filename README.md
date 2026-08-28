<!-- badges: start -->
[![R-CMD-check](https://github.com/daisy-model/daisy-r-tools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/daisy-model/daisy-r-tools/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

# daisytools
A suite of visualization tools for Daisy log files written in R.

## Installation
`daisytools` is currently only available from github. You need Rtools to build the package. If not already installed, you can install it with your package manager or from https://cran.r-project.org. You can then use `devtools` to install `daisytools`. Depending on your platform, you might need to install `git`.

First install `devtools`

    install.packages('devtools')

The try to install `daisytools`

    devtools::install_git('https://github.com/daisy-model/daisy-r-tools')

If this fails try to install `git2r`

    install.packages('git2r')

and install `daisytools` again

    devtools::install_git('https://github.com/daisy-model/daisy-r-tools')

If this fails open an issue and describe the problem https://github.com/daisy-model/daisy-r-tools/issues


You can remove the package with

    remove.packages('daisytools')

The contents of the package can be listed with

    library(daisytools)
    ls("package:daisytools")

## Examples
### Reading dlf files

    library(daisytools)
    example(read_dlf)

### Plotting

    library(daisytools)
    example(plot_dlf)
    example(animate_dlf)
    example(plot_mass_balance)


The call to `eaxmple(plot_dlf)` should produce a plot similar to this

![Bar plots of four annually logged variables from four different Daisy log files](inst/extdata/annual/Annual-FN/plot_annual_example.png)

### Mass balance

    library(daisytools)
    example(mass_balance)
    example(mass_balance_summary)

### Utility functions

    library(daisytools)
    example(subset_dlf)
    example(daisy_time_to_timestamp)


## Documentation
Use the builtin help for documentation on each function. For a more tutorial like introduction go to https://daisy-model.github.io/daisy-r-tools/ and browse the available articles.

## Development
Follows https://r-pkgs.org/

Start `R` in base of repository. Then use devtools to load, check and install package

    library(devtools)
    load_all()
    lint()
    check(cran = TRUE)
    install()


## Release
```{R}
library(devtools)
load_all()
lint()
spell_check()
check(cran = TRUE)
release()
check_win_release()
check_win_oldrelease()

submit_cran()
```
