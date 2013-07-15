== Twilio Telephone Game

This game is a recreation of the traditional children's game, Telephone, but using Twilio. https://en.wikipedia.org/wiki/Chinese_whispers

It was written by @JonMarkGo for his workshop at Code Academy in Chicago

== How to Run

1. heroku create --stack cedar mygameurl

2. heroku config:add account_sid=YOUR_ACCOUNT_SID auth_token=YOUR_AUTH_TOKEN telephone_number=YOUR_TWILIO_NUMBER
   (make sure YOUR_TWILIO_NUMBER is in the format +16461234567)

3. git push heroku master

4. heroku run rake db:migrate

5. Set your Twilio SMS URL for the number that you entered to 'http://mygameurl.herokuapp.com/messenger/sms' and the method to POST

6. All set to play!

== How to Play

1. To start a game, TXT "new NAME" to your Twilio phone number

2. Your friends can then TXT "NAME GAMEID" to the same number (you will get the game id upon successful creation of a game)

3. Once all of your friends have joined, TXT "start" to the number

4. ???

5. FUN!
[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/6f3b664857e61f96fbaf74f601421263 "githalytics.com")](http://githalytics.com/jonmarkgo/Twilio-Telephone-Game)
