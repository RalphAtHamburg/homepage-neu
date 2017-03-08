# Local configs
set :site_name, 'Middleman with Tachyons'
set :version,   'v0.0.1'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Activate sprockets
activate :sprockets

# Add bower's directory to sprockets asset path
after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

################################################################################
# View Helpers
# Methods defined in the helpers block are available in templates
################################################################################

helpers do
  # Calculate the years for a copyright
  def copyright_years(start_year)
    end_year = Date.today.year
    if start_year === end_year
      start_year
    else
      start_year + ' - ' + end_year.to_s
    end
  end
end

################################################################################
# The :i18n extension provides a way to localize the site.
################################################################################
activate :i18n

################################################################################
# Configure the directorys
################################################################################

config[:css_dir] = 'assets/stylesheets'
config[:js_dir] = 'assets/javascripts'
config[:images_dir] = 'assets/images'
config[:fonts_dir] = 'assets/webfonts'

configure :development do
  set :debug_assets, true
end

configure :build do
  activate :relative_assets
end

# Build-specific configuration
configure :build do

  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
  
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
