# Password handler

Shell script to handle easily your password
### Version 1.0
## Configuration
- Make sure to have `xclip` package installed 
```bash 
$ sudo apt-get install xclip
``` 
- In your .bashrc or bash.profile write this 
```bash 
alias pass='~/.password
``` 
- Then copy this file into your home directory with name .password like this:
```bash 
$ cp password_handler ~/.password
```

## How to use it
- Once the configuration is done you can edit the file .password to add your passwords in a hashmap here:
```sh
# HASHMAP for password list
declare -A passwords=(
    ["id1"]=$'password1'
    ["id2"]=$'password2'
    ["id3"]=$'password3'
)
```sh

- to get a password in your clip board just type 
```bash 
$ pass <ID>
``` 
Where <ID> is one your id declared in the hashmap in my case I can type:
```bash 
$ pass id1
``` 
then I will get in my clipboard password1

### WIP 
1.1 Store password in file 
1.2 List all password with pass all