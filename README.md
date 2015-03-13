
# XL Release Server 4.0.x
	

## XebiaLabs home page and Admin manual
[xebialabs.com](https://xebialabs.com)
 
[docs.xebialabs.com/xl-release/4.0.x/systemadminmanual.html](https://docs.xebialabs.com/xl-release/4.0.x/systemadminmanual.html)

## Description

XL Release is an end-to-end pipeline orchestration tool for Continuous Delivery and DevOps teams. It handles dependencies, release trains, and integration with change and release management.

## Server requirements
To install the XL Release server, the following prerequisites must be met:

1. XL Release license: You can download your license from https://tech.xebialabs.com/download/license.
2. Operating system: Windows or Unix-family operating system running Java.
3. Java Runtime Environment: JDK 7 (Oracle, IBM or Apple)
4. RAM: At least 2GB of RAM available for XL Release.
5. Hard disk space: At least 2GB of hard disk space to store the XL Release repository (this depends on your usage of XL Release)
	
Depending on the environment, the following may also be required:

1. Database: XL Release's repository may be stored in a database; for more information, see Configuring the repository
2. LDAP: To enable group-based security, an LDAP x.509 compliant registry is required; for more information, see Configuring LDAP security

## Download Installation Archive
The cookbook is using wget to download the installation archive from xebialabs. 
Set attribute ['xlrelease']['downloadurl'] to this installation archive.
Set attribute default['xlrelease']['username'] = 'supplied by xebialabs' 
Set attribute default['xlrelease']['password'] = 'supplied by xebialabs'

## Using the default recipe the below steps are executed.
1. Creates xlrelease user and group.
2. Creates an installation directory /opt/xl-release-4.0.x-server. This can be changed via attributes.
3. wgets the XL Release installation archive from the ['xlrelease']['downloadurl'] attribute.
4. Extracts the archive into the installation directory.
5. Change ownership of the installation directory to be owned by xlrelease user and group.
6. Configure the deployit.conf through the setup.config.txt.erb template. All values in this setup file can be overwritten by attributes.
7. Kick off xlrelease installation program (server.sh included in installation archive).
8. Configure xlrelease as a service (runit).

##Post Installation
Add the license file to your installation directory ~/conf directory and restart xlrelease service

```sv down xlrelease; sv up xlrelease```

## Contributing

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
