#!/bin/bash


fruit="apple"

case "$fruit" in
    "apple")
        echo "It's an apple."
        ;;
    "banana")
        echo "It's a banana."
        ;;
    "orange")
        echo "It's an orange."
        ;;
    *)
        echo "It's an unknown fruit."
        ;;
esac