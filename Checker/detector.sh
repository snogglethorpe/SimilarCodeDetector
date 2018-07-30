#!/bin/sh

#  detector.sh
#  Checker
#
#  Created by Ellie Shin on 7/16/18.
#  Copyright © 2018 Ellie Shin. All rights reserved.


echo "Starting anonymization + pmd cpd"

rm -rf ../processed;
for ((i=100; i<=500; i += 50)) {
echo "anonymization-cpd-" $i
date; for filepath in `find . -type f \( -name "*er.swift" -o -name "*View.swift" -o -name "*Button.swift" -o -name "*Label.swift" -o -name "*Field.swift" \) ! -name "*Builder.swift" ! -name "*PluginManager.swift" ! -name "*WorkerManager.swift" ! -name "ApplicationLaunchManager.swift" ! -name "*TestHelper.swift" ! -name "AccessibilityID*.swift" ! -name "BugReporter*.swift" ! -iname  "*Deprecated*.swift" ! -name "*___FILEBASENAME___*" | sed 's/ /%/g'` ; do f=`echo "$filepath" | sed 's/%/ /g'`; mkdir -p ../processed/`dirname "$filepath"`; /Users/$USER/Developer/Checker/Checker/runcheck.sh "$f" > ../processed/"$filepath"; done; pmd cpd --language swift --encoding UTF-8 --failOnViolation true --minimum-tokens $i --files ../processed > anonymized-cpd-$i.txt; date;
}


echo "Starting pmd cpd"

for ((i=100; i<=500; i += 50)) {
echo "cpd-" $i
date; find . -type f \( -name "*er.swift" -o -name "*View.swift" -o -name "*Button.swift" -o -name "*Label.swift" -o -name "*Field.swift" \) ! -name "*Builder.swift" ! -name "*PluginManager.swift" ! -name "*WorkerManager.swift"  ! -name "ApplicationLaunchManager.swift" ! -name "*TestHelper.swift" ! -name "AccessibilityID*.swift" ! -name "BugReporter*.swift" ! -iname  "*Deprecated*.swift" ! -name "*___FILEBASENAME___*" -exec pmd cpd --language swift --encoding UTF-8 --failOnViolation true --minimum-tokens $i --files {} > cpd-$i.txt +
date;
}

