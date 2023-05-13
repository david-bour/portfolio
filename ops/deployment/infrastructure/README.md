# F.A.Q

1. I can't run `terraform plan` because I'm seeing firebase auth issues locally
    - **Solution:** export GOOGLE_APPLICATION_CREDENTIALS={{path}}

2. I'm getting `exit code 3` from the `terraform fmt -check`
    - **Solution:** Probably means I need to run the `terraform fmt` locally to fix the formatting

3. I'm getting errors adding service account roles
    - **Solution:** Turns out you need `Security Admin` role to modify roles. `Editor` is not enough.