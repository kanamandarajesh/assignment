# 1.Building the Image

1.Save the above Dockerfile as Dockerfile in your desired directory.

2.Open a terminal in that directory.

3.Run the following command to build the image:

#### docker build -t my-ubuntu-image .

# Running the Container

After building the image, you can run a container from it using the following command:
Use the docker run command with the -it flags to start an interactive terminal session within the container.

#### docker run -it my-ubuntu-image

##### Check if /bin/bash is available:

Once inside the container, you can check if /bin/bash is available by running the following commands:

#### which bash
===================================================
# 2.Auditing Hardware

This bash script audits various hardware specifications on a RHEL system and generates a report.

#### Instructions

1. Save the above script content in a file named `audit_script.sh`.

2. Open a terminal and navigate to the directory where the script is saved.

3. Run the following command to make the script executable:

#### chmod +x audit_script.sh

4.Run the script with the following command:
#### ./audit_script.sh

This will generate the audit report with highlighted differences if any.

===================================================
# 3. Managing Disk Space
### Running the Script

1.Save the script as managing-disk-space.sh on the server where your audio files are stored.

2.Open a terminal window on the server.

3.Make the script executable with the following command:

#### chmod +x managing-disk-space.sh


Optional: Clean Up Files Older Than Specific Time

To clean up files older than a specific time (e.g., 10 hours), run the script with the time as an argument:

#### ./managing-disk-space.sh 10h


Default Behavior (Clean Up Files Older Than 40 Hours)If no argument is provided, 
the script will clean up files older than the default threshold of 40 hours (144000 seconds).

#### Log File:
The script will create a log file named deleted-files-<date>-<month>-<year>.log containing information about deleted files.


Explanation:

The script uses find to locate all .wav files in the /data/audios directory.
It calculates the age of each file by comparing its creation time with the current time.
If a file is older than the specified threshold (default 40 hours or provided argument), the script deletes the file and logs its name, creation time, and deletion time.



