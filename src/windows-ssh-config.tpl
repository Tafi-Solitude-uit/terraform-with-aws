//command line các dòng dưới nếu muốn triển khai tự động quy trình với Github Actions
add-content -path C:/Users/Windows/.ssh/config -value @'
    Host ${hostname}
    hostname ${hostname}
    User ${user}
    IdentityFile ${identityfile}
'@