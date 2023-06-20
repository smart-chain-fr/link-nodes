set -x

set

# ensure we can run octez-client commands without specifying client dir
ln -s /var/tezos/client /home/tezos/.tezos-client
#
# Not every error is fatal on start.  In particular, with zerotier,
# the listen-addr may not yet be bound causing octez-node to fail.
# So, we try a few times with increasing delays:

for d in 1 1 5 10 20 60 120; do
	/usr/local/bin/octez-node run				\
			--bootstrap-threshold 0			\
			--config-file /etc/tezos/config.json     \
			--network ghostnet		\
			--rpc-addr '0.0.0.0:8732' 		\
			--allow-all-rpc '0.0.0.0:8732'
	sleep $d
done

#
# Keep the container alive for troubleshooting on failures:

sleep 3600
