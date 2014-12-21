require 'rest-client'
require 'ostruct'
class Resp
end

class ApiConnection
  attr_reader :server, :player_id, :session_id
  def initialize(player_id="davidhuangdw@163.com",
                 server= "http://strikingly-hangman.herokuapp.com/game/on")
    @server = server
    @player_id = player_id
  end

  def start_game
    res = post(action:'startGame')
    @session_id = res['sessionId']
  end

  def next_word
    res = post(action:'nextWord')
    res['data']['word']
  end

  def guess_word(char)
    res = post(guess:char)
    res['data']['word']
  end

  def get_result
    res = post(action:'getResult')
    res['data']['score']
  end

  def submit_result
    post(action:'submitResult')
  end

  private
  def post(action:'guessWord', **opt)
    opt.merge!(playerId:@player_id, action:action)
    opt.merge!(sessionId:@session_id) if @session_id
    JSON.parse(post_payload(opt.to_json)).tap{|res| puts res}
  end
  def post_payload(payload)
    puts "request #{payload}"
    RestClient.post(@server, payload, content_type: :json, accept: :json)
  end
end