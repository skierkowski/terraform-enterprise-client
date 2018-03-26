

module TerraformEnterprise
  module Commands
    STRINGS = {
      options: {
        table: 'Format list output as a table'
      },
      workspaces: {
        attributes: {
          terraform_version: 'Version of Terraform to use for this workspace.',
          working_directory: 'Relative path that Terraform will execute within.',
          oauth_token: 'VCS Connection (OAuth Conection + Token) to use as identified; obtained from the oauth_tokens subcommand.',
          branch: 'Repository branch that Terraform will execute from.',
          ingress_submodules: 'Submodules should be fetched when cloning the VCS repository.',
          repo: 'Reference to VCS repository in the format :org/:repo.',
          import_legacy: 'Specifies the legacy Environment to use as the source of the migration/',
          organization: 'Organization to which this workspaces belongs to.',
          auto_apply: 'Auto-apply enabled',
        },
        commands: {
          create: 'Create a new workspace',
          list: 'List worksapces in the organization',
          get: 'Get workspace details by name',
          delete: 'Delete the workspace',
          update: 'Update the workspace',
          lock: 'Lock the workspace by workspace ID',
          unlock: 'Unlock the workspace by workspace ID'
        }
      },
      organizations: {
        commands: {
          create: 'Create a new organization',
          list: 'List all the organizations',
          get: 'Get organization details by name',
          delete: 'Delete the organization',
        },
        attributes: { }
      },
      teams: {
        commands: {
          create: 'Create a new team',
          delete: 'Delete the team by ID',
          list: 'List teams in organization',
          get: 'Get team details'
        },
        attributes: {
          organization: 'Organization to which this Team belongs to.'
        }
      },
      oauth_tokens: {
        commands: {
          list: 'List the OAuth tokens in the organization'
        },
        attributes: {
          organization: 'Organization to which this OAuth Token belongs to.'
        }
      }
    }
  end
end
