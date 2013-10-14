#
# Fabric deployment file
#

from fabric.api import *
from fabric.colors import blue
from fabric.contrib.files import exists

def banner(fn):
    print(blue(fn.__doc__))
    return fn()

@banner
def deploy_packages():
    ''' Install needed packages '''
    sudo('apt-get update')
    sudo('apt-get install -y git')
    sudo('apt-get install -y emacs23-nox')
    sudo('apt-get install -y snmpd')

@banner
def deploy_dotfiles():
    ''' Install configuration '''
    git_url = 'http://github.com/krihal/dotfiles.git'

    with cd('~/'):
        if not exists('dotfiles'):
            run("git clone %s dotfiles" % git_url)
    with cd('~/dotfiles'):
        run('git pull')
        run('cp emacs ~/.emacs')
        run('cp fvwm2rc ~/.fvwm2rc')
        run('cp pinerc-gmail ~/.pinerc')

        if exists('/etc/snmp'):
            run('sudo cp snmpd.conf /etc/snmp/snmpd.conf')

@banner
def services_start():
    ''' Start services '''
    services = {'snmpd'}

    for service in services:
        sudo("service %s restart" % service)

@banner
def services_verify():
    ''' Verify services '''
    local("snmpget -v1 -c public %s iso.3.6.1.2.1.4.24.6.0" % env.host)

@banner
def parameters_set():
    ''' Set system parameters '''
    pass

#
# Run all 
#
def run_all():
    deploy_packages()
    deploy_dotfiles()
    services_start()
    services_verify()
    parameters_set()

if __name__ == '__main__':
    run_all()
