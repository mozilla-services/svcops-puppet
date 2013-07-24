# base packages, we install these everywhere
class base::packages {
    package {
        [
            'atop',
            'augeas',
            'bash-completion',
            'dstat',
            'htop',
            'nano',
            'nc',
            'strace',
            'sysstat',
            'telnet',
            'vim-enhanced',
            'zsh',
        ]:
            ensure => latest;

    }
}
