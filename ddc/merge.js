import fs from 'fs'

const atoms = JSON.parse(fs.readFileSync("ddc-atoms.json"))
var ddc = fs.readFileSync("ddc-concepts.ndjson").toString().split("\n").filter(Boolean).map(JSON.parse)

ddc = ddc.map(c => {
  if (c.uri in atoms) {
    c.memberSet = atoms[c.uri]    
  }
  return c
})

fs.writeFileSync("ddc-concepts.ndjson", ddc.map(c => JSON.stringify(c)+"\n").join(""))
