vagrant-checksums
=================

Create checksums for vagrant installable packages. These can be used in a
chef recipe like https://github.com/SavvisRnD/vagrant-cookbook.


Usage
=====
```
Generate Checksums for vagrant installable images
    -d, --cachedir DIR               Where to cache install files
    -q, --quiet                      Suppresses unneeded output
    -t, --tags TAGS                  Versions to checksum
        --url                        Base url default(http://downloads.vagrantup.com)
```

Getting a list of all the availble versions: 

```
ruby ./checksums.rb
v1.3.4 v1.3.3 v1.3.2 v1.3.1 v1.3.0 v1.2.7 v1.2.6 v1.2.5 v1.2.4 v1.2.3 v1.2.2 v1.2.1 v1.2.0 v1.1.5 v1.1.4 v1.1.3 v1.1.2 v1.1.1 v1.1.0 v1.0.7 v1.0.6 v1.0.5 v1.0.4 v1.0.3 v1.0.2 v1.0.1 v1.0.0

```

Getting the checksums for a version:

```
./checksums.rb -tv1.3.4
http://downloads.vagrantup.com/tags/
Vagrant-1.3.4.dmg already downloaded. Skipping...
Vagrant_1.3.4.msi already downloaded. Skipping...
vagrant_1.3.4_i686.deb already downloaded. Skipping...
vagrant_1.3.4_i686.rpm already downloaded. Skipping...
vagrant_1.3.4_x86_64.deb already downloaded. Skipping...
vagrant_1.3.4_x86_64.rpm already downloaded. Skipping...
default['vagrant']['url']['osx']  = "http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/Vagrant-1.3.4.dmg"
default['vagrant']['checksum']['osx']  = "faa4107d661f8ab77e8d8154b0b0b0873a42977e1381a497823297074c0ebaff"
default['vagrant']['url']['windows']  = "http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/Vagrant_1.3.4.msi"
default['vagrant']['checksum']['windows']  = "91426d30af751b22428fd8eb6a5f9ff24d637d379b5d081992386d5a3a731461"
default['vagrant']['url']['debian']  = "http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/vagrant_1.3.4_i686.deb"
default['vagrant']['checksum']['debian']  = "ad0fc9cdef9bd3edb20f44d778c34b22f15f6f28f467593d17d9f5233cf32d83"
default['vagrant']['url']['rhel']  = "http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/vagrant_1.3.4_i686.rpm"
default['vagrant']['checksum']['rhel']  = "b10a766116feba9d1c302b31cae2ebe8d767a6790594b85e3b2f8a810416fdb8"
default['vagrant']['url']['debian']  = "http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/vagrant_1.3.4_x86_64.deb"
default['vagrant']['checksum']['debian']  = "eb7ba5f3c9fbd8f07a4ec20ae1910d173c52b27a1417db04bac40cf97fabb2eb"
default['vagrant']['url']['rhel']  = "http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/vagrant_1.3.4_x86_64.rpm"
default['vagrant']['checksum']['rhel']  = "ab96ce14e0457deb9b6c2af84333bfa4a49819d89b1edbe1afa0b8f4e2ddb09d"

```

Requirements
===========
* Ruby 1.9.x
* nokogiri gem 

License
=======

Steven Borrelli (c) 2013
Released under the MIT license
