dnslookup: dnslookup.o
	clang -W -Wall dnslookup.o -o dnslookup

dnslookup.o: dnslookup.c
	clang -c dnslookup.c

clean:
	rm dnslookup *.o lookup ipv4/* ipv6/* processed_ipv4/* processed_ipv6/* *.pdf *.dot 


lookup: dnslookup websites
	xargs -a websites ./dnslookup > lookup

traceroute: lookup
	if ! [ -d "ipv4" ]; then mkdir ipv4; fi
	if ! [ -d "ipv6" ]; then mkdir ipv6; fi
	./trace.sh 

processroutes:
	if ! [ -d "processed_ipv4" ]; then mkdir processed_ipv4; fi
	if ! [ -d "processed_ipv6" ]; then mkdir processed_ipv6; fi
	python3 format_traceroute.py
	cat processed_ipv4/* | sort | uniq > router-topology-v4.dot
	cat processed_ipv6/* | sort | uniq > router-topology-v6.dot
	python3 graphify.py
	dot -T pdf -o router-topology-v4.pdf router-topology-v4.dot
	dot -T pdf -o router-topology-v6.pdf router-topology-v6.dot