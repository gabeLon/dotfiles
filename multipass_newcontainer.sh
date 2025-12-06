read -p 'insert number of CPU cores: ' core_number
read -p 'insert allocated disk space (ie 10G): ' disk_space
read -p 'insert allocated ram memory (ie 2G): ' ram_memory 
read -p 'insert multipass virtual instance name: ' instance_name
read -p 'insert ubuntu image (ie 22.04 - Alternatively you can type an image alias, like "jammy" for Ubuntu 22.04 - Find available image aliases typing "multipass find" command  - Leave it blank or type "lts" will install latest default version): ' ubuntu_image

#github_multipass_token=$( cat ~/.ssh/github_multipass_token.txt)
#bitbucket_multipass_token=$( cat ~/.ssh/bitbucket_multipass_token.txt)

multipass launch -v -c $core_number -d $disk_space -m $ram_memory -n $instance_name $ubuntu_image 

multipass exec $instance_name -- /bin/bash -c '
    sudo apt update
    read -p "insert email: " email
    read -p "insert multipass github token number: " github_multipass_token
    read -p "insert multipass bitbucket token number: " bitbucket_multipass_token
    ssh-keygen -q -t rsa -N "" -b 4096 -C "$email"
    curl -i -H "Authorization: token $github_multipass_token" --data "{\"title\":\"$instance_name`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
    cd
    curl -u gabelon:$bitbucket_multipass_token -X POST -H "Content-Type: application/json" -d  "{\"label\":\"$instance_name`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.bitbucket.org/2.0/users/gabelon/ssh-keys
    ssh-keyscan github.com >> ~/.ssh/known_hosts
    git clone git@github.com:gabeLon/dotfiles.git
    cd dotfiles/
    . install.sh ~ 
'

multipass shell $instance_name
