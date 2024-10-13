add-content -path C:/Users/Windows/.ssh/config -value @'

Host ${hostname}
    hostname ${hostname}
    User ${user}
    IdentityFile ${identityfile}
'@