#!/bin/bash

paperFolder="$HOME/OneDrive/Documents/Paper"
javaCommand="java -Xmx4G -Xms1G -jar $paperFolder/paper.jar"

# 1. Check if the folder exists
if [ ! -d "$paperFolder" ]; then
    echo "Creating folder: $paperFolder"
    mkdir -p "$paperFolder"
else
    # Go to start (skipping the folder creation)
    : start
fi

# 2. Check if the file *paper*.jar exists
if [ ! -e "$paperFolder/paper*.jar" ]; then
    echo "Error: paper.jar not found in $paperFolder"
    echo
    echo "Please download the paper.jar file then continue"
    open "https://papermc.io/downloads/paper"
    read -p "Press Enter after downloading..."
    mv "$HOME/Downloads/paper*.jar" "$paperFolder"
    goto start
fi

# 2.2 Move the downloaded paper*.jar files to $paperFolder
mv "$HOME/Downloads/paper*.jar" "$paperFolder"

# 2.3 Rename the paper*.jar files to paper.jar
for file in "$paperFolder/paper*.jar"; do
    newFileName="$paperFolder/paper.jar"
    mv "$file" "$newFileName"
done

# 3. Run the Java command
echo "Running Java command: $javaCommand"
cd "$paperFolder"
$javaCommand

# 3.2 Notify if Java command fails
if [ $? -ne 0 ]; then
    echo "Error: Java failed."
fi
