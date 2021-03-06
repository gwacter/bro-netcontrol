Bro NetControl connector scripts
================================

This repository contains scripts that can be used to connect the Bro NetControl
framework to systems outside of Bro and, e.g., send out switch commands via OpenFlow.

Please note that the NetControl framework and scripts is still under active
development; the API is not completely fixed yet and the scripts have not seen
thorough testing.

Installation Instructions
-------------------------

To use the connector scripts, you need to install a current master version
of Bro with commands similar to this:

	git clone --recursive git://git.bro.org/bro
	./configure --prefix=[install prefix] --with-libcaf=[libcaf location]
	make install

To allow python to find the installed python broker bindings, it might be necessary
to adjust the PYTHONPATH variable similar to this:

	export PYTHONPATH=[install prefix]/lib/python:[this directory]

after that, you should be able to launch the provided scripts.

API
---

The [netcontrol](netcontrol/) directory contains a python API for the broker backend
of the Bro netcontrol framework. This API converts the Bro data structures into python
dictionaries and allows to send back success and error messages to bro.

A simple [example script](test/simple-client.py) is provided in the [test](test/)
directory. The API is also used by the command-line connector.

Command-line connector
----------------------

The [command-line](command-line/) directory contains a script that can be used to
interface the NetControl framework to command-line invocations.
[commands.yaml](command-line/commands.yaml) shows an example that can be used to
invoke iptables. An example script that simply blocks all connections is provided in
[example.bro](command-line/example.bro).

OpenFlow connector
------------------

The [openflow](openflow/) directory contains the source for a Ryu OpenFlow
controller, that can be used to interface the Bro NetControl framework with an
OpenFlow capable switch. To use the controller, you need to first install the
[Ryu SDN framework](https://osrg.github.io/ryu/).

After installation, you can run the openflow controller by executing

	ryu-manager --verbose openflow/controller.py

or similar. After that, OpenFlow switches should be able to connect to port 6633;
Broker connections can be made to port 9999. An example script that shunts all
connection traffic to a switch after an SSL, SSH or GridFTP session has been
established is provided in [example.bro](openflow/example.bro).

Acld connector
--------------

The [acld](acld/) directory contains the source for an connector to [acld](ftp://ftp.ee.lbl.gov/acld.tar.gz) ([more information](http://ee.lbl.gov/leres/acl2.html)).
An example script that simply blocks all connections is provided in
[example.bro](acld/example.bro).

