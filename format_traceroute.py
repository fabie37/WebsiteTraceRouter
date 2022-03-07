"""
    This script formats the trace route files found in ipv4/ and ipv6/
"""
from os import listdir
from os.path import isfile, join


def saveLines(dir, filename, processedLines):
    with open("processed_"+dir+filename, mode='w') as f:
        for line in processedLines:
            f.write(line+"\n")


def getLines(filename):
    lines = []
    with open(filename, mode="r") as f:
        for line in f:
            lines.append(line.rstrip())
    return lines


def getFileNames(dir):
    return [f for f in listdir(dir) if isfile(join(dir, f))]


def getIP(line):
    splitLine = line.split(" ")
    if "*" in splitLine:
        return None
    splitLine = list(filter(None, splitLine))
    return splitLine[1]


def processLines(lines):
    # Exclude first line
    lines = lines[1:]
    output = []
    index = 0

    currentOutput = ""
    hasOutput = False
    while index < len(lines):

        # Extract IP from line
        ip = getIP(lines[index])

        # Case 1 - No new output
        if ip and not hasOutput:
            currentOutput += f'"{ip}" -- '
            hasOutput = True

        # Case 2 - Prior output found
        elif ip and hasOutput:
            currentOutput += f'"{ip}"'
            output.append(currentOutput)
            currentOutput = f'"{ip}" -- '
        index += 1

    return output


def main():
    dirs = ["ipv4/", "ipv6/"]

    # Iterate through directories
    for dir in dirs:
        print(f"Getting files from {dir}... \n")
        fileNames = getFileNames(dir)

        # Iterate through files in dir
        for fileName in fileNames:

            # Get lines of file
            lines = getLines(dir+fileName)

            # Process lines
            processedLines = processLines(lines)

            # Save lines to new files
            saveLines(dir, fileName, processedLines)


main()
