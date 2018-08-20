#require 'mechanize'
# require 'pry'

class MagicClass
    EMAIL_REGEX =  /\b([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}(?<!gif|psd|htm|pdf|js|min|aspx|css|jpg|html|gov|edu|jpeg|abc.com|png|example.com))\b/i
    
    def self.agent
      @agent ||= Mechanize.new{|a|
      }
    end
  
    def self.email_from_text str
      return $1 if str[EMAIL_REGEX]
  
      str = str.gsub(/(?<=[A-Z0-9])[\s\[\]|()+_]*(?:spam|removeme|remove)[\s\[\]|()+_]*(?=[A-Z0-9])/i, '')
      str = str.gsub(/(?<=[A-Z0-9])[\s\[\]|()+_]*at[\s\[\]|()+_]*(?=[A-Z0-9])/i, '@')
      str = str.gsub(/(?<=[A-Z0-9])[\s\[\]|()+_]*dot[\s\[\]|()+_]*(?=[A-Z0-9])/i, '.')
  
      return $1 if str[EMAIL_REGEX]
    end
    
    def self.get_mobile(url)
      page = agent.get(url)
      page.at('meta[name="viewport"]')['content'] rescue ''
    end
  
    def self.get_email(url)
      page = agent.get(url)
      if email = email_from_text(page.body)
        return email
      end
  
      as = page.search('a[href]').select{|a| a.text[/about|contact/i] || a[:href][/about|contact/i]}
  
      uris = as.map{|a| page.uri.merge(a[:href])}.uniq
      uris.each do |uri|
        page = agent.get(uri)
        if email = email_from_text(page.body)
          return email
        end
      end
    end
  
    def self.get_description(url)
      page = agent.get(url)
      page.at('meta[name="description"]')['content'] rescue ''
  
    end
  end
  
  # email = MagicClass.get_email('http://sunshinemint.com/')
  # puts email
  
  # description = MagicClass.get_description('https://www.muenzeoesterreich.at/')
  # puts description
  
  =begin
  https://www.muenzeoesterreich.at/
  http://www.nwtmint.com/
  
  http://sunshinemint.com/
  http://coinable.com/
  http://www.osbornecoin.com/
  
  
  
  body = <<EOF
  userna dme@d omain.com
  username at domain.com
  username at domain dot com
  username (at) domain (dot) com (with and without spaces)
  username [at] domain [dot] com (with and without spaces)
  username_at_domain_dot_com
  userSPAMname at domain dot com
  userREMOVEMEname at domain dot com
  user(SPAM)name at domain dot com
  username+spam at domain dot com
  
  EOF
  
  
  email = MagicClass::email_from_text(body)
  puts email
  =end
  