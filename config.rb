# frozen_string_literal: true

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :livereload
activate :directory_indexes
activate :relative_assets
activate :autoprefixer do |prefix|
  prefix.browsers = 'last 2 versions'
end

set :relative_links, true

# Deploy to multiple sites
case ENV['TARGET'].to_s.downcase
when 'github'
  activate :deploy do |deploy|
    deploy.deploy_method = :git
    # Optional Settings
    # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
    # deploy.branch   = 'custom-branch' # default: gh-pages
    # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
    # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
    deploy.build_before = true # build before deploy, default: false
  end
else
  activate :deploy do |deploy|
    deploy.deploy_method = :rsync
    deploy.host          = 'openwebslid.es'
    deploy.path          = '/opt/openwebslides/openwebslides/site/'

    # Optional Settings
    deploy.user          = 'openwebslides' # no default
    # deploy.password = 'secret' # no default

    deploy.build_before = true # default: false
  end
end

# Add external assets here
Dir['./node_modules/@fortawesome/fontawesome-free/webfonts/*'].each do |file|
  import_file file, File.join('webfonts', File.basename(file))
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
end
