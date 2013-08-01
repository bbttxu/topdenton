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

# guard :rspec do
#   watch(%r{^spec/.+_spec\.rb$})
#   watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
#   watch('spec/spec_helper.rb')  { "spec" }

#   # Rails example
#   watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
#   watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
#   watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
#   watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
#   watch('config/routes.rb')                           { "spec/routing" }
#   watch('app/controllers/application_controller.rb')  { "spec/controllers" }

#   # Capybara features specs
#   watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/features/#{m[1]}_spec.rb" }

#   # Turnip features and steps
#   watch(%r{^spec/acceptance/(.+)\.feature$})
#   watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
# end

guard 'minitest', :all_after_pass => true, :all_on_start => true do # --drb , , :foreman => true:keep_failed => true, :focus_on_failed => true,  :cli => '--format doc --color'

  # with Minitest::Unit
  watch(%r|^test/test_helper\.rb|) { "test" }
  watch(%r|^test/support/(.*)\.rb|) { "test" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r|^app/models/(.*)\.rb|) {|m| ["test/unit/#{m[1]}_test.rb", "test/functional/#{m[1]}s_controller_test.rb"] }
  watch(%r|^app/controllers/(.*)\.rb|) {|m| ["test/controllers/#{m[1]}_test.rb", "test/functional/#{m[1]}_test.rb"] }
  watch(%r|^app/views/(.*)\.html|) {|m| "test/functional/#{m[1]}_test.rb" }
  watch(%r|^app/objects/(.*)\.rb|) {|m| "test/objects/#{m[1]}_object_test.rb" }
  watch(%r|^app/helpers/(.*)\.rb|) { |m| "test/unit/helpers/#{m[1]}_test.rb" }
end




