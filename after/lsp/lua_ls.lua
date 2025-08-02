return {
  settings = {
    Lua = {
      diagnostics = {
        -- vimでWARNINGが出るのを抑止
        globals = {
          'vim',
        },
      },
    },
  }
}
