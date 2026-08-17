#!/bin/bash

echo "Current hostname:"
hostnamectl

echo "Changing hostname to rvs..."
hostnamectl set-hostname rvs

echo "Starting new Bash shell..."
exec bash
