#!/bin/bash

# List of ports to kill
PORTS=(8000 5173 12080)

for PORT in "${PORTS[@]}"; do
    # Find process IDs using the port
    PIDS=$(lsof -t -i :"$PORT")
    
    if [ -n "$PIDS" ]; then
        echo "Killing processes on port $PORT: $PIDS"
        kill -9 $PIDS
    else
        echo "No processes found on port $PORT"
    fi
done

