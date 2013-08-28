# adds /etc/skel
class base::skel {
    file {
        '/etc/skel':
            ensure => directory;
        '/etc/skel/.bashrc':
            content => template('base/skel/bashrc');
        '/etc/skel/.bash_profile':
            content => template('base/skel/bash_profile');
        '/etc/skel/.zshrc':
            content => template('base/skel/zshrc');
        '/etc/skel/.bash_logout':
            content => template('base/skel/bash_logout');
    }
}
