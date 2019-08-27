SOURCE = "."
CONFIG = {
  'post' => File.join(SOURCE, "orgmode/kinesiska"),
  'post_ext' => "org"
}

# definitions
def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/,/, '/')}") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end

namespace :utkast do
  namespace :orgmode do
      desc "To create a dir for orgmode posts"
      task "mkdir" do
        sh "mkdir -p ./orgmode"
      end

      desc "Add a orgmode draft in ./orgmode/kinesiska"
      task :post, :title do |t, args|
        FileUtils.mkdir "#{CONFIG['post']}" unless FileTest.directory?(CONFIG['post'])
        if args.title
          title = args.title
        else
          title = get_stdin("Enter a title: ")
        end
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        begin
          date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
        end
        filename = File.join(CONFIG['post'], "#{date}-#{slug}.#{CONFIG['post_ext']}")
        if File.exist?(filename)
          abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
        end

        puts "Das ist dein neu post: #{filename}"
        open(filename, 'w') do |post|
          post.puts "\#\+TITLE: #{title.gsub(/-/, ' ')}"
          post.puts "\#\+OPTIONS: toc:nil"
          post.puts "\#\+STARTUP: showall indent"
          post.puts "\#\+STARTUP: hidestars"
          post.puts "---"
          post.puts 'sidebar: auto'
          post.puts '---'
        end
      end
  end
end
