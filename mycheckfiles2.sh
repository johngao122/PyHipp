#!/bin/bash

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l

echo ""
echo "#==========================================================="
echo "Start Times"

for file in $(ls -1t *-slurm*.out | head -n 2); do
    echo "==> $file <=="
    grep "time.struct_time" "$file" | head -n 1
done

echo "End Times"

for file in $(ls -1t *-slurm*.out | head -n 2); do
    echo "==> $file <=="
    grep "time.struct_time" "$file" | tail -n 1
    grep -h "^[0-9]*\.[0-9]*$" "$file" | tail -n 1
    grep -h '"MessageId":' "$file" | tail -n 1
done

echo "#==========================================================="	
