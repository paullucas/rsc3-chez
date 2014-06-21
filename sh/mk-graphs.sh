#!/bin/sh

g=md/graphs.md

echo "## graphs" > $g
echo "" >> $g
for i in help/graph/*.scm
do
    echo "- [$(basename $i .scm)](?t=rsc3&scm=$i)" >> $g
done
