cwlVersion: "cwl:draft-3.dev3"
class: Workflow

inputs:
  - {id: "#schema_in", type: File}
  - {id: "#schema_target", type: string}
  - {id: "#context_target", type: string}
  - {id: "#rdfs_target", type: string}

outputs:
  - id: index_out
    type: File
    source: "#doc/out"

  - id: context_out
    type: File
    source: "#context/out"

  - id: rdfs_out
    type: File
    source: "#rdfs/out"

steps:
  - id: doc
    run: makedoc.cwl
    inputs:
      - { id: source, source: "#schema_in" }
      - { id: target, source: "#schema_target" }
    outputs:
      - { id: out }

  - id: context
    run: "makecontext.cwl#makecontext"
    inputs:
      - { id: schema, source: "#schema_in" }
      - { id: target, source: "#context_target"}
    outputs:
      - { id: out}

  - id: rdfs
    run: "makecontext.cwl#makerdfs"
    inputs:
      - { id: schema, source: "#schema_in" }
      - { id: target, source: "#rdfs_target"}
    outputs:
      - { id: out}