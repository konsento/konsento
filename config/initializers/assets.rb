# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Setup bower components folder for lookup
Rails.application.config.assets.paths << Rails.root.join(
  'vendor',
  'assets',
  'bower_components'
)

# Fonts
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

# Images
Rails.application.config.assets.precompile << /\.(?:png|jpg)$/

# Vendor assets
Rails.application.config.assets.precompile += %w(base.js)
Rails.application.config.assets.precompile += %w(base.css)

# Themes
Rails.application.config.assets.precompile += [
  'angle/themes/theme-a.css',
  'angle/themes/theme-b.css',
  'angle/themes/theme-c.css',
  'angle/themes/theme-d.css',
  'angle/themes/theme-e.css',
  'angle/themes/theme-f.css',
  'angle/themes/theme-g.css',
  'angle/themes/theme-h.css'
]

# Controller assets
# Rails.application.config.assets.precompile += [
#   'dashboard.js',
#   'dashboard.css'
# ]
