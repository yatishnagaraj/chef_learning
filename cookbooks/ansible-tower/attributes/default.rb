# Encoding: utf-8

default['ansible']['download_url'] = 'http://releases.ansible.com/ansible-tow'\
                                     'er/setup/ansible-tower-setup-latest.tar'\
                                     '.gz'
default['ansible']['server_name'] = node['fqdn']

default['ansible']['tower']['admin_password'] = 'AWsecret'
default['ansible']['postgres']['admin_password'] = 'password'
default['ansible']['rabbitmq']['admin_password'] = 'AWXbunnies'
