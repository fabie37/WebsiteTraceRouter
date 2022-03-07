# Simply add the graphy routertopology header

def getFile(filename):
    file = []
    with open(filename, 'r') as f:
        for line in f:
            file.append(line)
    return file


def writeFile(filename, file):
    with open(filename, 'w') as f:
        f.writelines(file)


start = "graph routertopology {\n"
end = "}\n"

# For IPV4 Addresses
file = getFile("router-topology-v4.dot")
file.insert(0, start)
file.append(end)
writeFile("router-topology-v4.dot", file)

# For IPV6 Addresses
file = getFile("router-topology-v6.dot")
file.insert(0, start)
file.append(end)
writeFile("router-topology-v6.dot", file)
