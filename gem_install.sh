#!/bin/bash -v
set -o verbose
gem install rubygems-update -v 1.4.2
update_rubygems
gem update --system 1.4.2
gem install rdoc -v 4.1.1 --no-ri
gem install i18n -v 0.6.11 --no-ri
gem install rails -v 2.3.10 --no-ri
gem install ancestry -v 1.2.0 --no-ri
gem install declarative_authorization -v 0.5.1 --no-ri
gem install spreadsheet -v 0.9.7 --no-ri
gem install to_xls -v 0.1.2 --no-ri
gem install will_paginate -v 2.3.16 --no-ri
gem install pg -v 0.17.1 --no-ri --no-rdoc
gem install thin -v 1.6.3 --no-ri --no-rdoc
