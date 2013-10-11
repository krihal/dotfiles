#
# Fabric deployment file
#

from fabric.api import *
from fabric.contrib.files import exists

#
# Install needed packages
#
def deploy_packages():
    sudo('apt-get update')
    sudo('apt-get install git')
    sudo('apt-get install emacs23-nox')
    sudo('apt-get install snmpd')

#
# Install configuration
#
def deploy_dotfiles():
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

#
# Start services
#
def services_start():
    services = {'snmpd'}

    for service in services:
        sudo("service %s restart" % service)

#
# Verify services
#
def services_verify():
    local("snmpget -v1 -c public %s iso.3.6.1.2.1.4.24.6.0" % env.host)

#
# Set system parameters
#
def parameters_set():
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
