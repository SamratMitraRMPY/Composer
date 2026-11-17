# Keeps the name of the environment already deployed from this repo.
# Changing environment_name replaces the Composer environment (20–30 min rebuild).
project_id       = "samrats-sandbox"
region           = "europe-west2"
environment_name = "dev"

worker_min_count = 1
worker_max_count = 3
