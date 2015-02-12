namespace :curl do
  # Before:
  # edit /etc/hosts
  # add  127.0.0.1 fm.com
  desc "Run curl Test ok."
  task :run_ok => :environment do
    url_elements = ["users", "subjects", "posts", "topics", "wishes", "catalogs", "activities/index", "page/about",
                    "page/development", "contact-us", "users/sign_in", "users/sign_up", "users/password/new", "users/1",
                    "topics/1"]

    url_elements.each do |url|
      str = `curl -Is http://fm.com:3000/#{url} | head -n 1`
      if str =~ /200/
        p "OK"
      else
        p str
      end
    end
  end

  desc "Run curl Test found."
  task :run_found => :environment do
    url_elements = ["subjects/new", "posts/new", "topics/new", "wishes/new"]

    url_elements.each do |url|
      str = `curl -Is http://fm.com:3000/#{url} | head -n 1`
      if str =~ /302/
        p "OK"
      else
        p str
      end
    end
  end
end
