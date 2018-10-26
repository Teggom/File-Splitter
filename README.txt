# File-Splitter

There is an application called discord which is built using the same backend as Slack ((A more beefy version of Skype))

Discord allows for sending pictures and files in conversation, however the maximum size of these files without Discord-Nitro is 8 MB

This was a program I threw together to play with the idea of circumventing that limit by sending picture fragments and then rebuilding them on the other side. 

As a proof of concept it just deconstructs a picture into a lot of little pieces and the rebuilds it, stop at the '#### File Broken- Rebuilds below.' line (36) to see what the files look like completely splintered. 

