outcomeCohorts <- readCohortSet(here("Cohorts"))

cdm <- generateCohortSet(
  cdm, 
  outcomeCohorts,
  name = tablePrefix ,
  overwrite = TRUE
)

counts <- cdm[[tablePrefix]] %>%
  group_by(cohort_definition_id) %>%
  summarise(counts = as.numeric(n()), .groups = "drop") %>%
  left_join(cohortSet(cdm[[tablePrefix]]), by = "cohort_definition_id") %>%
  mutate(cdm_name = cdmName(cdm)) %>%
  collect() %>%
  select("cohort_name", "cohort_definition_id", "counts", "cdm_name")

write_csv(
  counts, 
  here("Results", paste0("feasibility_counts_", cdmName(cdm), ".csv"))
)
