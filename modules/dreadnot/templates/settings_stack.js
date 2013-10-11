        '<%= stack_name %>': {
            github_base_url: '<%= github_url %>',
            git_url: '<%= git_url %>',
            tip: 'master',
            tip_ttl: 120 * 1000,
            project_dir: '<%= project_dir %>',
<% if @commander_script -%>
            commander_script: '<%= commander_script %>',
<% end -%>
            regions: ['<%= region %>']
        },
