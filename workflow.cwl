class: Workflow
cwlVersion: v1.0
id: prep
label: workflow
inputs:
  - id: msin
    type: 'Directory[]'
  - id: min_separation
    type: int?
outputs: []
steps:
  - id: select_first
    in:
      - id: input
        source:
          - msin
    out:
      - id: output
    run: steps/select_first.cwl
    label: select_first
  - id: check_separation
    in:
      - id: ms
        source:
          - select_first/output
      - id: min_separation
        source: min_separation
    out: []
    run: steps/check_separation.cwl
    label: check_separation
requirements: []
