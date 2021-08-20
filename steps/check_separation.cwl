class: CommandLineTool
cwlVersion: v1.0
id: step2
baseCommand:
  - python3
  - script.py
inputs:
  - id: ms
    type: Directory
  - id: min_separation
    type: int?
outputs: []
label: check
hints:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: script.py
        entry: |
          import sys
          sys.exit(1)
stdout: check.log
