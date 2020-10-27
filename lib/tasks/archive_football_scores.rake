desc "This task archives football scores"

task :archive_football_scores => :environment do
  active_scores = FootballScore.where("archived_state = false")

  current_time = Time.now

  active_scores.each do | score |
    if current_time > score.created_at + 4.hours
      score.update(archived_state: true)
    end
  end
end
