# Chef cookbook for XL Release Server
[![Build Status](https://travis-ci.org/electric-it/xlrelease.svg?branch=develop)](https://travis-ci.org/electric-it/xlrelease)

* [xebialabs.com](https://xebialabs.com)
* Supported XL Release version: 4.0.x

# Server requirements

From [docs.xebialabs.com/xl-release/4.0.x/systemadminmanual.html](https://docs.xebialabs.com/xl-release/4.0.x/systemadminmanual.html):

To install the XL Release server, the following prerequisites must be met:

1. XL Release license: If you are an XL Release Community Edition user, you should have received your license during the sign-up process. Enterprise users can download their license from the [XebiaLabs licence server](https://tech.xebialabs.com/download/license) (requires credentials).
2. Operating system: Windows or Unix-family operating system running Java.
3. Java Runtime Environment: JDK 7 (Oracle, IBM or Apple)
4. RAM: At least 2GB of RAM available for XL Release.
5. Hard disk space: At least 2GB of hard disk space to store the XL Release repository (this depends on your usage of XL Release)

Depending on the environment, the following may also be required:

1. Database: XL Release's repository may be stored in a database; for more information, see Configuring the repository
2. LDAP: To enable group-based security, an LDAP x.509 compliant registry is required; for more information, see Configuring LDAP security

*Downloading the installation archive*

This cookbook uses `wget` to download the installation archive from XebiaLabs.
Set attribute ['xlrelease']['downloadurl'] to this installation archive.
Set attribute default['xlrelease']['username'] = 'supplied by xebialabs'
Set attribute default['xlrelease']['password'] = 'supplied by xebialabs'

*Using the default recipe the below steps are executed*

1. Creates xlrelease user and group.
2. Creates an installation directory `/opt/xl-release-4.0.x-server`. This can be changed via attributes.
3. `wget`s the XL Release installation archive from the ['xlrelease']['downloadurl'] attribute.
4. Extracts the archive into the installation directory.
5. Changes ownership of the installation directory to be owned by xlrelease user and group.
6. Configures the `xl-release-server.conf` file through the setup.config.txt.erb template. All values in this setup file can be overwritten by attributes.
7. Kicks off XL Release's installation program (`server.sh` included in installation archive).
8. Configures xlrelease as a service (using runit).

# Post-installation

Add the license file to your installation directory's `~/conf` subdirectory and restart the xlrelease service

```sv down xlrelease; sv up xlrelease```

# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License & Authors
- Authors: Robert Castelle & Bernie Durfee

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

```
