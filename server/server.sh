#!/bin/bash

# Set the port
PORT=5050

# Stop any program currently running on the set port
echo 'preparing port' $PORT '...'
fuser -k 5050/tcp

# switch directories
cd build/web/

# Start the server
echo 'Server starting on port' $PORT '...'
<<<<<<< HEAD
python3 -m http.server $PORT
=======
python3 -m http.server $PORT
>>>>>>> 64b537176efe83695f2badc6fc12448d0c01149d
