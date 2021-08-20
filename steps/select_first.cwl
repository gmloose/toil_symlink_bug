cwlVersion: v1.0
class: ExpressionTool
id: selectfirst
label: selectfirst
inputs:
    - id: input
      type: Directory[]
outputs: 
    - id: output
      type: Directory
requirements:
    - class: InlineJavascriptRequirement
    - class: InitialWorkDirRequirement
      listing:
        - $(inputs.input)
expression: |
  ${
    return {'output': inputs.input[0]}
  }

