import { readFile, writeFile } from "fs"

class BlockingRuls {
  constructor(domain) {
    return {
      trigger: {
        "url-filter": `.*${domain}`
      },
      action: {
        type: "block"
      }
    }
  }
}

readFile("src/domains.txt", "utf8", (err, data) => {
  if (err) {
    console.error(err)
    return
  }

  const lines = data.split("\n")
  const ruls = lines.map((domain) => new BlockingRuls(domain))
  const jsonData = JSON.stringify(ruls)

  writeFile("dist/blockingRules.json", jsonData, (err) => {
    if (err) {
      console.error("Error writing file", err)
    } else {
      console.log("File has been written successfully")
    }
  })
})
