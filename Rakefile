require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList["spec/*_spec.rb"]
  t.verbose = true
  t.name = :spec
  t.description = "Run specs for growler alerts"
end

task default: :spec
