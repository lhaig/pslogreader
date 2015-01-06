## pslogreader

#Quest NDS Migrator Powershell Logfile Parser

This Powershell script enables you to extract the errors found in the 
Quest NDS Migrator Copy Engine Server logfiles into a new smaller text
 file.

This script is licensed under the GPL v3 OpenSource License.

## Using the script

On each copy engine server share out the folder where the log files are
being written to. Keep these all the same as you will need to change
the path in the line 

    $sourcePath = "\\$copyMachine\ndsmig\Logs\File Migration\"

to match your path. As you can see we used the default path

Create a folder called Logs on your server D: I created a 500GB disk 
as we expected a large number of large files. You should also create two
more folders 

    D:\Logs\logs
    D:\Logs\errors

Next create a copy of the qmcopyservers.txt file and rename it
qmcopyservers.csv. Open the file and add you will see two fields,
the Volume field and the CopyMachine field.

The reason for the Volume field is to allow each log file to be named 
with the volume name which makes it easier to know which volumes errors
you are working on.

## Note on Patches/Pull Requests

 * Fork the project.
 * Make your feature addition or bug fix.
 * Send me a pull request.


## Copyright
Copyright (c) GPLv2. See LICENSE.txt for details.
