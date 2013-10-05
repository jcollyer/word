require_relative "../../app/models/biblebook"

namespace :db do
  desc "Filling database with sample data for development. Pass --force to delete a production database"
  task :populate, [:force] => [:environment] do |t, args|
    if Rails.env.production? && args[:force] != "--force"
      raise "\nIf you wish to run rake db:populate in production, run like 'rake db:populate[--force]\n"
    end
    Rake::Task['db:schema:load'].invoke
    load_data
  end
end

def load_data
  load_rails
  load_octopress
end


# Not using yaml b/c of no support for here-is docs
def load_rails
  puts "created Rails biblebook"
  p = Biblebook.new
  p.title = "Ruby on Rails"
  p.author = "Rails Community"
  p.published_at = Date.new 2012, 12, 31
  p.intro = "Rails is a super *web application* framework"
  load_rails_md p
  p.save!
end

def load_octopress
  puts "created Octopress biblebook"
  p = Biblebook.new
  p.title = "Octopress"
  p.author = "imathis"
  p.published_at = Date.new 2011, 1, 15
  p.intro = "Octopress is a super cool __blogging__ framework"
  load_octopress_md p
  p.save!
end
