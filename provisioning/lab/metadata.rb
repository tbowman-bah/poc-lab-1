# -*- coding: utf-8 -*-
name 'lab'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache 2.0'
description 'Lab cookbook for pentestlab organization provisioning'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'locales'
depends 'database'
depends 'backup'
depends 'cron'
depends 'docker'
depends 'openvpn'
