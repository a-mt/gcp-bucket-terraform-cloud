Base: [gcp-bucket-terraform](https://github.com/a-mt/gcp-bucket-terraform)

Use terraform Cloud + github actions to setup an infra with Terraform

## Project Setup

### Google Cloud

* Create a project
* Create a service account
* Create a new JSON key  
  Retrieve the content of from your JSON key file without the newline characters. This is the value to paste into the environment variable

  ```
  cat key.json | tr -s '\n' ' '
  ```

### Terraform Cloud

* Create your account, organization and workspace on [Terraform Cloud](https://app.terraform.io/)

* Workspace > Variables > Add variable

  ```
  gcp_credentials = "..."
  gcp_project = "test-terraform-cloud"
  gcp_region = "europe-west"
  gcp_bucket_location = "EU"
  ```

## Launch locally

* Login to Terraform Cloud

  ```
  terraform login
  ```

* Update `terraform.tf`

  ```
  terraform {
    cloud {
      hostname     = "app.terraform.io"
      organization = "my-organization-name"

      workspaces {
        name = "my-workspace-name"
      }
    }
  }
  ```

* Apply terraform

  ``` bash
  $ cd src
  $ terraform init
  $ terraform plan
  $ terraform apply
  ```

  Clean up:

  ``` bash
  $ terraform destroy
  ```

## Github Actions Setup

### Terraform Cloud Token

* Create a new token on Terraform Cloud

* Set the token in your Github repository as a secret:  
  Settings > Secrets and variables: Actons > New repository secret

  ```
  TF_API_TOKEN=xxx
  ```

### Github token

* Allow Github actions to add comments in the pull requests (using the auto-populated variable `secrets.GITHUB_TOKEN`):  
  Settings > Actions > General > Workflow permissions: read and write permissions

### Github Runner

To launch a runner locally (machine running the Github actions):

* Go to settings > actions > runners > new self-hosted runner

  ![](https://i.imgur.com/aG51mlB.png)

* Update runner/docker-compose.yml with the right RUNNER_VERSION  
  Ex: "curl -o actions-runner-linux-x64-2.314.1.tar.gz" → 2.314.1

* Start a runner

  ```
  # Build an image that installs the runner
  cd runner
  docker-compose build

  # Start a container
  docker-compose up -d
  docker-compose exec runner bash

  # Configure
  ./config.sh --url https://github.com/a-mt/test-github-actions --token ...

  # Start  
  ./run.sh
  ```

  If your config.sh gives you "Http response code: NotFound from 'POST https://api.github.com/actions/runner-registration'":  
  the token has expired, refresh the "new self-hosted runner" page to get a new token

* Check that it is listed in the runners list and is "idle":  
  Settings > runners

## Provision via Github Actions

To provision the infra using Terraform:  

- Update files in the /infra directory
- Create a merge request (or push) in the "prod" branch — base: prod, compare: BRANCH_NAME
- Check the ouput of the Github Actions + comment added to the PR (might need a page refresh)
- Merge
- Go check the Github actions

Note: Github actions are configured in `.github/workflows/`

If actions don't launch: 1. Check [Github Status](https://www.githubstatus.com/), 2. Wait 60s before trying again
