require 'rake/testtask'

task :default => [:test]

desc "Run automated tests"
Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['test/east_game_test.rb']
  t.verbose = true
end
