#!/bin/sh
bundle exec puma -e production -d -b unix:///home/deployer/apphera-core/tmp/sockets/apphera-core.socket
