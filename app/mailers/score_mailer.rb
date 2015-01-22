class ScoreMailer < ActionMailer::Base
  default from: "certification@grandstream.com"
  
  def score_email(score, correct, wrong)
    @score = score
    @correct_answers = correct
    @wrong_answers = wrong
    @test = Test.find(@score.test_id).name
    @user = User.find(@score.user_id)
    mail(to: @user.email, subject: 'Grandstream Certification Score')
  end
end
