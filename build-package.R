# Build package

# Dependencies
update(devtools::package_deps())

# turn on/off development mode
devtools::dev_mode()

# Automatically build functions
fun.name <- c(".check_spsann_arguments",
              ".plotting_options", 
              ".prepare_jittering",
              ".prepare_points",
              ".plot_and_jitter",
              ".prepare_output", 
              ".prepare_acdc_covars", 
              ".check_suggests",
              ".prepare_clhs_covars",
              ".set_progress", 
              ".update_progress",
              ".check_first_chain")
read.file <- c("R-autofun/check-spsann-arguments.R", 
               "R-autofun/plotting-options.R",
               "R-autofun/prepare-jittering.R",
               "R-autofun/prepare-points.R",
               "R-autofun/plot-and-jitter.R",
               "R-autofun/prepare-output.R",
               "R-autofun/prepare-acdc-covars.R",
               "R-autofun/check-suggests.R",
               "R-autofun/prepare-clhs-covars.R",
               "R-autofun/set-progress.R",
               "R-autofun/update-progress.R",
               "R-autofun/check-first-chain.R")
write.file <- c("R/check-spsann-arguments.R",
                "R/plotting-options.R",
                "R/prepare-jittering.R",
                "R/prepare-points.R",
                "R/plot-and-jitter.R",
                "R/prepare-output.R",
                "R/prepare-acdc-covars.R", 
                "R/check-suggests.R",
                "R/prepare-clhs-covars.R",
                "R/set-progress.R",
                "R/update-progress.R",
                "R/check-first-chain.R")
lapply(1:length(fun.name), function (i) autofun::autofun(fun.name[i], read.file[i], write.file[i]))
rm(fun.name, read.file, write.file)

# check examples and documentation
devtools::check_man()
devtools::run_examples(run = FALSE)

# check the package for Linux and Windows
devtools::check(check_version = TRUE, force_suggests = TRUE, args = "--use-valgrind")
devtools::build_win()
devtools::build()

# upload to CRAN
devtools::release(check = FALSE)
