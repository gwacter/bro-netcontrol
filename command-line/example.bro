@load base/protocols/conn
@load base/frameworks/netcontrol

const broker_port: port = 9977/tcp &redef;

event NetControl::init()
	{
	local netcontrol_broker = NetControl::create_broker(127.0.0.1, broker_port, "bro/event/netcontrol-example", F);
	NetControl::activate(netcontrol_broker, 0);
	}

event NetControl::init_done()
	{
	print "NeControl is starting operations";
	}

event BrokerComm::outgoing_connection_established(peer_address: string,
                                            peer_port: port,
                                            peer_name: string)
	{
	print "BrokerComm::outgoing_connection_established", peer_address, peer_port;
	}

event NetControl::rule_added(r: NetControl::Rule, p: NetControl::PluginState, msg: string)
	{
	print "Rule added successfully", r$id, msg;
	}

event NetControl::rule_error(r: NetControl::Rule, p: NetControl::PluginState, msg: string)
	{
	print "Rule error", r$id, msg;
	}

event NetControl::rule_timeout(r: NetControl::Rule, i: NetControl::FlowInfo, p: NetControl::PluginState)
	{
	print "Rule timeout", r$id, i;
	}

event connection_established(c: connection)
	{
	local id = c$id;
	local flow = NetControl::Flow(
		$src_h=addr_to_subnet(id$orig_h),
		$dst_h=addr_to_subnet(id$resp_h)
	);
	local e: NetControl::Entity = [$ty=NetControl::FLOW, $flow=flow];
	local r: NetControl::Rule = [$ty=NetControl::DROP, $target=NetControl::FORWARD, $entity=e, $expire=20sec];

	NetControl::add_rule(r);
	}

