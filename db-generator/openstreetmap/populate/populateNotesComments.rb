# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'lorem'
num = ARGV[0].to_i

note_num = ARGV[1].to_i

RNG = Random.new(1098109928029800)

statuses = ['open', 'closed', 'hidden']
num.times.map do |i|
    lat = RNG.rand(-90, 90)
    lng = RNG.rand(-180, 180)
    status = statueses[rand(statueses.length)]
    closed_at = nil
    created_at = Time.zone.now - rand(86400 * 365 * 2)
    if status == 'closed'
        closed_at = rand(created_at, Time.zone.now)
    end
    note = Note.create(:latitude => lat, :longitude => lng, :status => status, :created_at => created_at, :closed_at => closed_at )
    puts "create note ", note.id.to_s
end

notes = Note.all
users = User.all
note_comment_statuses = ['opened', 'closed', 'reopened', 'commented', 'hidden']
note_num.times.map do |i|
    note = notes[rand(notes.length)]
    author_id = users[rand(users.length)].id
    status = note_comment_statuses[rand(note_comment_statuses.length)]
    created_at = Time.zone.now - rand(86400 * 365 * 2)
    body = Lorem::Base.new('chars', rand(300)).output
    NoteComment.create(:note_id => note.id, :body => body, :author_id => author_id, :body => Lorem::Base.new('chars', 200).output, :event => status, :visible => rand(2), :created_at => created_at)
end
