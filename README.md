# Sync AEM plugin for neovim

this plugin is a wrapper for Adobe's Repo tool https://github.com/Adobe-Marketing-Cloud/tools/tree/master/Repo

## install

Lazy
```lua
  {
    "tylopilus/sync-aem.nvim",
    opts = {},
  },
```

## Usage
This plugin creates four commands 
- `:AEMExportFile` - Exports the file in current buffer to `http://localhost:4502`
- `:AEMExportFolder` - Exports the folders of the current buffers file to
`http://localhost:4502`
- `:AEMImportFile` - Imports the file in current buffer from
`http://localhost:4502`
- `:AEMImportFilder` - Imports the folder of the current buffers file from
`http://localhost:4502`


Additionally accepts args to absolute filepath e.g. `:AEMImportFolder
~/projects/repo/ui.apps/src/main/content/jcr_root/apps`
