# debian only
#
.PHONY: init
init:
	apt-get install -y iptables-persistent
	# save the current config(blank on the new node)
	iptables-save > iptables.rules.v4.`date +%F`
	ip6tables-save > iptables.rules.v6.`date +%F`

.PHONY: install
install:
	./iptables.sh

.PHONY: install6
install6:
	./iptables.sh 6
