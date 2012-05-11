class MessengerController < ApplicationController

  # POST /messenger/sms - incoming request from Twilio
  def sms
    #split the message so that the user can TXT in something like 'join 1' or 'register Jon'
    message = params['Body'].split(" ")
    command = message.first
    args = message.last
    reply = '' #sms reply to be sent back to the user

    @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']

    player = Player.find_by_phone_number(params['From'])
    if command == 'new'
      reply = sms_new(player, args)
    elsif command == 'start'
      reply = sms_start(player)
    else #when the user texts in 'Name #' to join a game
      if player.nil?
        reply = sms_join(params['From'], command, args.to_i)
      else
        reply = "You are already playing a game! Wait until it is over to join another."
      end
    end
    
    response = Twilio::TwiML::Response.new do |r|
      r.Sms reply
    end
    render :xml => response.text
  end

private
  # user sms 'new <name>'
  # Allows the player to create a new game
  def sms_new(player, name)
    if player.nil?
      game = Game.new
      game.save
      player = Player.new
      player.phone_number = params['From']
      player.game = game
      player.name = name
      player.save
      return "You have created game #{game.id} - tell your friends to TXT in 'Name #{game.id}' where Name is their first name."
    else
      return "You are already involved with a game, sorry."
    end
  end

  # user sms 'start'
  # starts the player's current game
  def sms_start(player)
    game = player.game
    if player.nil?
      return "You can't start a game if you are not even playing!"
    elsif player.first?
      game.started = true
      game.save
      @call = @client.account.calls.create(
        :from => ENV['telephone_number'],
        :to => game.players.first.phone_number,
        :url => url_for(:action => 'start_call', :controller => 'messenger')
      )
      return "Let the Twilio games begin!"
    else
      return "You did not create this game!"
    end
  end

  def sms_join(phone_number, name, game_id)
    game = Game.find_by_id(game_id)
    if game.nil? #no such game
      return 'That game does not exist, to start a game TXT in "new Name" (where Name is your first name)'
    else #game exists
      player = Player.where(:phone_number => phone_number, :game_id => game_id).first_or_create(:name => name)
      player.save
      return "#{player.name} - You have joined Game #{game.id} - you will receive a phone call when it is your turn!"
    end
  end
end
