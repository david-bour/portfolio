# F.A.Q

1. I can't run `terraform plan` because I'm seeing firebase auth issues locally
    - **Solution:** export GOOGLE_APPLICATION_CREDENTIALS={{path}}

2. I'm getting `exit code 3` from the `terraform fmt -check`
    - **Solution:** Probably means I need to run the `terraform fmt` locally to fix the formatting