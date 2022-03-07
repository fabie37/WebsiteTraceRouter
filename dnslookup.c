#include <arpa/inet.h>
#include <errno.h>
#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

void dnsLookup(const char *url, const char *port, struct addrinfo **addresses);
void strip(char *str);

int main(int argc, char *argv[]) {
    // 1. Iterate through arguments
    for (int index = 1; index < argc; index++) {
        // Get URL
        char *url = argv[index];
        strip(url);

        // Perform dnsLookup
        const char *port = "80";
        struct addrinfo *addresses;
        dnsLookup(url, port, &addresses);

        // Output addresses
        struct addrinfo *addr;
        for (addr = addresses; addr != NULL; addr = addr->ai_next) {
            // 1. Print url
            void *src;
            printf("%s ", url);

            // 2. Print family
            int ip_length = INET_ADDRSTRLEN;

            if (addr->ai_family == AF_INET) {
                printf("IPv4 ");
                src = &(((struct sockaddr_in *)addr->ai_addr)->sin_addr);
            } else if (addr->ai_family == AF_INET6) {
                printf("IPv6 ");
                ip_length = INET6_ADDRSTRLEN;
                src = &(((struct sockaddr_in6 *)addr->ai_addr)->sin6_addr);
            }

            // 3. Print IP address
            char ip[ip_length];
            inet_ntop(addr->ai_family, src, ip, ip_length);
            printf("%s\n", ip);
        }
    }
}

void dnsLookup(const char *url, const char *port, struct addrinfo **addresses) {
    struct addrinfo hints;
    int i;
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = PF_UNSPEC;      // Unspecified protocol
    hints.ai_socktype = SOCK_STREAM;  // Want a tcp socket

    // Do DNS lookup, addressess is a pointer head to a linked list
    if ((i = getaddrinfo(url, port, &hints, addresses)) != 0) {
        printf("Error: Unable to lookup IP address: %s \n", gai_strerror(i));
    }
}

void strip(char *str) {
    int len;
    if (str == NULL) {
        return;
    }
    len = strlen(str);
    if (str[len - 1] == '\n') {
        str[len - 1] = '\0';
    }
    len = strlen(str);
    if (str[len - 1] == '\r') {
        str[len - 1] = '\0';
    }
}