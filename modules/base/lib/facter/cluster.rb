Facter.add("cluster") do
  setcode do
    hostname = Facter.value('hostname')
    case hostname
    when /^es\d+/
      "elasticsearch"
    when /^web\d+/
      "web"
    when /^db\d+/
      "database"
    when /^red\d+/
      "redis"
    when /^cel\d+/
      "celery"
    when /^mc\d+/
      "memcache"
    end
  end
end
