# -*- coding: utf-8 -*-

node.override['pentester']['msf']['msfconsole.rc'] = [
  "workspace -a #{node.name}",
  "workspace #{node.name}",
  'setg LogLevel 1',
]
