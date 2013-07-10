# base packages, we install these everywhere
class base::packages {
    package {
        [
            'strace',
            'zsh',
            'telnet',
            'sysstat',
            'htop',
            'dstat',
            'vim-enhanced',
            'nc',
            'bash-completion',
            'nano',
        ]:
            ensure => latest;

    }
}
