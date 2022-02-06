-- Default setup commands run when server is attached.
local on_attach = function(_, bufnr)
  local function buf_nmap(...) config.buf_nmap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  buf_nmap('gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_nmap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_nmap('gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_nmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

-- default options used for setting up a new server.
local setup_opts = {}
setup_opts.on_attach = on_attach
setup_opts.flags = {
    debounce_text_changes = 150
}

-- make sure cmp gets the capabilities added.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
setup_opts.capabilities = capabilities

local servers = {'yamlls', 'tsserver', 'sumneko_lua', 'dockerls', 'bashls', 'cssls', 'eslint', 'terraformls' }

local function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

local lsp_installer_servers = require'nvim-lsp-installer.servers'

for count = 1, #servers do
    local server = servers[count]
    local opts = setup_opts
    if isModuleAvailable('lsp/'..server) then
      opts = require('lsp/'..server).setup_opts
      for k,v in pairs(setup_opts) do 
        opts[k] = opts[k] or v
      end
    end

    local server_available, requested_server = lsp_installer_servers.get_server(server)
    if server_available then
        requested_server:on_ready(function ()
            if requested_server.name == "eslint" then
              opts.on_attach = function(client, bufnr)
                client.resolved_capabilities.document_formatting = true
                on_attach(client, bufnr)
              end
            end

            requested_server:setup(opts)
        end)
        if not requested_server:is_installed() then
            requested_server:install()
        end
    end
end

local native_installed_servers = { 'solargraph' }

for _, server in pairs(native_installed_servers) do
  require('lspconfig')[server].setup(setup_opts)
end
