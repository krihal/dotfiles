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
def start_services():
    services = {'snmpd'}

    for service in services:
        sudo("service %s restart" % service)
