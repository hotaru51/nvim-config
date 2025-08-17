local status, schemastore = pcall(require, 'schemastore')
local schemas = nil
if status then
  schemas = schemastore.json.schemas()
end

return {
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
    },
  },
}
