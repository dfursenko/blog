namespace :blog do
  desc 'Counts the number of ruby-files in the project'
  task count_files: :environment do
    puts Dir.glob('./**/*.rb').length
  end
end

namespace :blog do
  desc 'Counts the number of ruby-file strings in the project'
  task count_strings: :environment do
    strings = 0
    Dir.glob('./**/*.rb').each do |file|
      File.readlines(file).each do |string|
        strings += 1
      end
    end
    puts strings
  end
end
