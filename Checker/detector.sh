#!/bin/sh

#  detector.sh
#  Checker
#
#  Created by Ellie Shin on 7/16/18.
#  Copyright © 2018 Ellie Shin. All rights reserved.


rm -f checker-results.txt; rm -rf ../processed; for filepath in `find . -type f \( -name "*er.swift" -o -name "*View.swift" \) ! -name "*TestHelper.swift" ! -name "AccessibilityID*.swift" ! -name "BugReporter*.swift" ! -iname  "*Deprecated*.swift" ! -name "*___FILEBASENAME___*" | sed 's/ /%/g'` ; do f=`echo "$filepath" | sed 's/%/ /g'`; mkdir -p ../processed/`dirname "$filepath"`; /Users/$USER/Developer/Checker/Checker/runcheck.sh "$f" > ../processed/"$filepath"; done; pmd cpd --language swift --encoding UTF-8 --failOnViolation true --minimum-tokens 100 --files ../processed > checker-results.txt



find . -type f \( -name "*er.swift" -o -name "*View.swift" \) ! -name "*TestHelper.swift" ! -name "AccessibilityID*.swift" ! -name "BugReporter*.swift" ! -iname  "*Deprecated*.swift" ! -name "*___FILEBASENAME___*" -exec pmd cpd --language swift --encoding UTF-8 --failOnViolation true --minimum-tokens 80 --files {} > pmd-results.txt + 

