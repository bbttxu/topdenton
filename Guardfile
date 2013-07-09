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

guard 'minitest', :all_after_pass => true, :all_on_start => true do # --drb , , :foreman => true:keep_failed => true, :focus_on_failed => true,  :cli => '--format doc --color'

  # with Minitest::Unit
  watch(%r|^test/test_helper\.rb|) { "test" }
  watch(%r|^test/support/(.*)\.rb|) { "test" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r|^app/models/(.*)\.rb|) {|m| ["test/unit/#{m[1]}_test.rb", "test/functional/#{m[1]}s_controller_test.rb"] }
  watch(%r|^app/workers/(.*)\.rb|) {|m| "test/workers/#{m[1]}_test.rb" }
  watch(%r|^app/controllers/(.*)\.rb|) {|m| ["test/controllers/#{m[1]}_test.rb", "test/functional/#{m[1]}_test.rb"] }
  watch(%r|^app/views/(.*)\.html|) {|m| "test/functional/#{m[1]}_test.rb" }
  watch(%r|^app/objects/(.*)\.rb|) {|m| "test/objects/#{m[1]}_object_test.rb" }
  watch(%r|^app/helpers/(.*)\.rb|) { |m| "test/unit/helpers/#{m[1]}_test.rb" }
end
