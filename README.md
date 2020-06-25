# Vanguard
Shell script to handle easily your password
### Version 1.0.2
## Configuration
- Clone the repository
```bash
$ git clone https://github.com/LucasNoga/Vanguard.git
```
- Make sure to have `xclip` package installed
```bash
$ sudo apt-get install xclip
```

## How to use it
- Once the configuration is done you can edit the file .vanguard to add your passwords in a hashmap here:
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
$ ./vanguard.sh <ID>
```
Where <ID> is one your id declared in the hashmap in my case I can type:
```bash
$ ./vanguard.sh id1
```
then you will get in your clipboard the password of id1 which is password1

### WIP
1.0: Init project
1.0.1: Fix bugs and add functions
1.0.2: Handle compatibility for windows (Windows Subsystem for Linux) and linux system
1.1: Store password in file
1.2: List all password with pass all
