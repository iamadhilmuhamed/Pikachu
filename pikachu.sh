#!/bin/bash

echo "⚡ Pikachu: Enter target domain:"
read domain

# Create output directory
mkdir -p results

echo "⚡ Pikachu is on the hunt for live subdomains... Gotta catch 'em all!"

# Subdomain Enumeration
subfinder -all -d "$domain" -o results/subfinder.txt
assetfinder -subs-only "$domain" > results/assetfinder.txt
findomain -t "$domain" -u results/findomain.txt

# Combine and get unique subdomains
sort -u results/subfinder.txt results/assetfinder.txt results/findomain.txt > results/all_subs.txt

# Find only live subdomains
cat results/all_subs.txt | httprobe > results/alive.txt
sed 's#https\?://##' results/alive.txt | sort -u > results/live_subdomains.txt

# Clean up unnecessary files
rm results/subfinder.txt results/assetfinder.txt results/findomain.txt results/all_subs.txt results/alive.txt

echo "⚡ Pikachu found the live subdomains! Results saved in 'results/live_subdomains.txt'"
echo "⚡ Mission accomplished! Time for a Thunderbolt! ⚡"
