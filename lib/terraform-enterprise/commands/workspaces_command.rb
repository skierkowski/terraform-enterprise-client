require 'terraform-enterprise/commands/command'

module TerraformEnterprise
  module Commands
    class WorkspacesCommand < TerraformEnterprise::Commands::Command

      desc 'list', 'Lists all workspaces in the organization'
      option :organization, required: true, type: :string, desc: 'Organization name'
      option :table, type: :boolean, default: true, desc: 'Format output in a table'
      def list
        render client.workspaces.list(options), except:[:permissions, :actions, :environment, 'created-at']
      end

      desc 'create <name>', 'Creates a new organization'
      option :terraform_version, type: :string, desc: "Version of Terraform to use for this workspace."
      option :working_directory, type: :string, desc: "Relative path that Terraform will execute within."
      option :oauth_token, type: :string, desc: 'VCS Connection (OAuth Conection + Token) to use as identified; obtained from the oauth_tokens subcommand.'
      option :branch, type: :string, desc: "Repository branch that Terraform will execute from."
      option :ingress_submodules, type: :boolean, desc: "Submodules should be fetched when cloning the VCS repository."
      option :repo, type: :string, desc: 'Reference to VCS repository in the format :org/:repo'
      option :import_legacy_environment, type: :string, desc: 'Specifies the legacy Environment to use as the source of the migration'
      option :organization, required: true, type: :string, desc: 'Organization name'
      def create(name)
        params = {
          organization: options[:organization],
          name: name,
          'working-directory' => options[:working_directory] || '',
        }
        if options[:branch] || options[:repo] || options[:oauth_token] || options[:ingress_submodules]
          repo = {}
          repo['branch']             = options[:branch] if options[:branch]
          repo['identifier']         = options[:repo] if options[:repo]
          repo['oauth-token-id']     = options[:oauth_token] if options[:oauth_token]
          repo['ingress-submodules'] = options[:ingress_submodules] if options[:ingress_submodules]
          params['vcs-repo'] = repo
        end

        params['migration-environment'] = options[:import_legacy_environment] if options[:import_legacy_environment]
        params['terraform_version']     = options[:terraform_version] if options[:terraform_version]
        render client.workspaces.create(params), except:[:permissions, :actions, :environment]
      end

      desc 'get <name>', 'Gets the workspace details'
      option :organization, required: true, type: :string, desc: 'Organization name'
      def get(name)
        params = {
          organization: options[:organization],
          workspace: name
        }
        render client.workspaces.get(params), except:[:permissions, :actions, :environment]
      end

      desc 'delete <name>', 'Deletes the workspace'
      option :organization, required: true, type: :string, desc: 'Organization name'
      def delete(name)
        params = {
          organization: options[:organization],
          workspace: name
        }
        render client.workspaces.delete(params), except:[:permissions, :actions, :environment]
      end

      desc 'update <name>', 'Update the workspace'
      option :working_directory, type: :string, desc: "Relative path that Terraform will execute within."
      option :terraform_version, type: :string, desc: "Version of Terraform to use for this workspace."
      option :auto_apply, type: :boolean, desc: 'Auto-apply enabled'
      option :organization, required: true, type: :string, desc: 'Organization name'
      def update(name)
        params = options
        params[:workspace] = name
        render client.workspaces.update(params), except:[:permissions, :actions, :environment]
      end

      desc 'lock <id>', "Locks the workspace"
      def lock(id)
        render client.workspaces.action(action: :lock, id: id), except:[:permissions, :actions, :environment]
      end

      desc 'unlock <id>', 'Unlocks the workspace'
      def unlock(id)
        render client.workspaces.action(action: :unlock, id: id), except:[:permissions, :actions, :environment]
      end
    end
  end
end
