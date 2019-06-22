ansible-tower Cookbook
======================
Cookbook to download, setup, and install Ansible Tower.


Requirements
------------
### Cookbooks:
- python

### Operating Systems:
- Ubuntu 12.04

Attributes
----------
#### ansible-tower::default
Key|Type|Description|Default
---|----|-----------|-------
['ansible']['download_url']|String|Location of Ansible Tower tarball to install|http://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz
['ansible']['server_name']|String|Name for Tower|`node['fqdn']`
['ansible']['tower']['admin_password']|String|Tower Admin Password|AWsecret
['ansible']['postgres']['admin_password']|String|Postgres Admin Password|password
['ansible']['rabbitmq']['admin_password']|String|Rabbit MQ Admin Password|AWXbunnies

Usage
-----
#### ansible-tower::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `ansible-tower` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ansible-tower]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Brint O'Hearn (<brint.ohearn@rackspace.com>)
