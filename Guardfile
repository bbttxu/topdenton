# vim: syntax=ruby

# interactor :off

group :frontend do
  guard :bundler do
    watch('Gemfile')
  end

  # guard :livereload do
  #   watch(%r{^app/.+\.(erb|haml)})
  #   watch(%r{^app/helpers/.+\.rb})
  #   watch(%r{^public/.+\.(css|js|html)})
  #   watch(%r{^config/locales/.+\.yml})
  # end
end

guard :minitest, :all_on_start => true do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?test_(.*)\.rb})
  watch(%r{^lib/(.*/)?([^/]+)\.rb})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb})      { 'test' }

  # Rails 3.2
  watch(%r{^app/controllers/(.*)\.rb}) { |m| "test/controllers/#{m[1]}_test.rb" }
  watch(%r{^app/helpers/(.*)\.rb})     { |m| "test/helpers/#{m[1]}_test.rb" }
  watch(%r{^app/models/(.*)\.rb})      { |m| "test/unit/#{m[1]}_test.rb" }
end



group :backend do
  guard 'rails' do
    watch('Gemfile.lock')
    watch(%r{^(config|lib)/.*})
  end
end

