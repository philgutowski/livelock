#!/usr/bin/env ruby

require 'lockitron'

TOKEN = 'd6d1d1b65fe8598a106f5d6b9ab183eacd32227f156010d4cde1e5d171fcc281'


user = Lockitron::User.new(TOKEN)
lock = user.locks.first

lock.as(user) do |l|
  l.invite(email: "phil@shipyardrehearsals.com")
end
