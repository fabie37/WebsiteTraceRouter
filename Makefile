dnslookup: dnslookup.o
	clang -W -Wall dnslookup.o -o dnslookup

dnslookup.o: dnslookup.c
	clang -c dnslookup.c

clean:
	rm dnslookup *.o lookup ipv4/* ipv6/* processed_ipv4/* processed_ipv6/* *.pdf *.dot 


lookup: dnslookup websites
	xargs -a websites ./dnslookup > lookup

traceroute: lookup
	sudo ./trace.sh 

processroutes:
	python format_traceroute.py
	cat processed_ipv4/* | sort | uniq > router-topology-v4.dot
	cat processed_ipv6/* | sort | uniq > router-topology-v6.dot
	python graphify.py
	dot -T pdf -o router-topology-v4.pdf router-topology-v4.dot
	dot -T pdf -o router-topology-v6.pdf router-topology-v6.dot