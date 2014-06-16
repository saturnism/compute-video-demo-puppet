$zonea = 'us-central1-a'
$zoneb = 'us-central1-b'
$region = 'us-central1'

gce_disk { 'puppet-agent-1':
	ensure		=> absent,
	zone		=> "$zonea",
}

gce_instance { 'puppet-agent-1':
	ensure		=> absent,
	zone		=> "$zonea",
}
gce_disk { 'puppet-agent-2':
	ensure		=> absent,
	zone		=> "$zonea",
}

gce_instance { 'puppet-agent-2':
	ensure		=> absent,
	zone		=> "$zonea",
}
gce_disk { 'puppet-agent-3':
	ensure		=> absent,
	zone		=> "$zoneb",
}

gce_instance { 'puppet-agent-3':
	ensure		=> absent,
	zone		=> "$zoneb",
}

gce_disk { 'puppet-agent-4':
	ensure		=> absent,
	zone		=> "$zoneb",
}

gce_instance { 'puppet-agent-4':
	ensure		=> absent,
	zone		=> "$zoneb",
}

gce_firewall { 'puppet-http':
	ensure			=> absent,
}

#destroy load balancer and other resources required by the load balancer
gce_httphealthcheck { 'puppet-http':
	ensure		=> absent,
}

gce_targetpool { 'puppet-pool':
	ensure		=> absent,
	region		=> "$region",
}

gce_forwardingrule { 'puppet-rule':
	ensure		=> absent,
	region		=> "$region",
}
Gce_instance['puppet-agent-1', 'puppet-agent-2', 'puppet-agent-3', 'puppet-agent-4'] -> Gce_disk['puppet-agent-1', 'puppet-agent-2', 'puppet-agent-3', 'puppet-agent-4']
Gce_forwardingrule['puppet-rule'] -> Gce_targetpool['puppet-pool']
Gce_targetpool['puppet-pool'] -> Gce_httphealthcheck['puppet-http']
