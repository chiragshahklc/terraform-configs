# terraform-configs
## Initial configuration
- Create ssh key pair using following command
    ```bash
    $ ssh-keygen -t ed25519 -C "terraform_key" -f ssh_key
    ```
- This will create `ssh_key` and `ssh_key.pub` files. These files are already ignored by `.gitignore`. If you use different name then please specify them in `.gitignore` to not push it to git accidentally.
- Now we need to create `secret.tfvars` file. We can create using following command for ease of use.
    ```bash
    $ cp example.tfvars secret.tfvars
    ```
- This will copy `example.tfvars` file into `secret.tfvars`. Replace values in `secret.tfvars` with respective actual values. We have ignored `secret.tfvars` file into `.gitignore` already.

## Create instance using terraform
- To see what actions terraform will actually perform we need to run `terraform plan`. But we need to pass our secrets with it as well.
    ```bash
    $ terraform plan -var-file="secret.tfvars"
    ```
- To provision this into actual production, run following command
    ```bash 
    $ terraform apply -var-file="secret.tfvars"
    ```
- It will prompt you to type **yes**. After that it will proceed to run it.
- It will give you **public_ip** as output once done.
    ```bash
    public_ip = "127.0.0.1"
    ```
## SSH into created instance
- First we need to replace **HostName** value from `config` file
- Replace it with **public_ip** we get when instance created.
- Following command will ssh into instance with minimal efforts.
    ```bash
    # $ ssh -F <config-file-path> <"Host" value>
    $ ssh -F config terraform
    ```
## Destroy provisioned instance
- Following command will destroy terraform created infrastructure
    ```bash
    $ terraform destroy -var-file="secret.tfvars"
    ```