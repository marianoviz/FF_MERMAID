# Importing sites and projects

# Install mermaidr from "staging" branch - new features that are not yet released
remotes::install_github("data-mermaid/mermaidr", ref = "staging")

# Load libraries
library(mermaidr)
library(dplyr)
library(readr)

# Get project for import
project <- mermaid_search_my_projects("Sharla test", include_test_projects = TRUE)

# Sites ----
sites <- tribble(
  ~name, ~latitude, ~longitude, ~notes, ~country, ~reef_type, ~reef_zone, ~exposure,
  "Test site 1", 43.65107, -79.347015, NA, "Canada", "fringing", "crest", "semi-exposed",
  "Test site 2", 43.65507, -79.347015, NA, "Canada", "fringing", "crest", "semi-exposedd"
)

# Try to import
# Access docs via ?mermaid_import_project_sites
sites %>%
  mermaid_import_project_sites(project)

# Fix value (either in CSV or here then write back to CSV - whatever is source of truth)
sites <- sites %>%
  mutate(exposure = ifelse(exposure == "semi-exposedd", "semi-exposed", exposure))

# Try to import
sites %>%
  select(-notes) %>%
  mermaid_import_project_sites(project)
# Successful import

# Management regimes ----
management_regimes <- tribble(
  ~name, ~est_year, ~size, ~parties, ~compliance, ~access_restriction, ~periodic_closure,
  "Test management regime", 2020, 5, "NGO; private sector", "full", TRUE, TRUE
)

# Try to import
# Access docs via ?mermaid_import_project_managements
management_regimes %>%
  mermaid_import_project_managements(project)
