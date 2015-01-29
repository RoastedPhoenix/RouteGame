require 'bundler'
Bundler.require

$options = ['charmander', 'squirtle', 'bulbasaur', 'helixfossil' 'rayquaza' 'missingno']

get '/pokemon/:object' do
  @red = params[:object]
  @rival = ['charmander', 'squirtle', 'bulbasaur'].sample
  @rayquza_number = rand(100)

if @red == 'rayquaza'
redirect 'http://bulbapedia.bulbagarden.net/wiki/Cheating'
elsif @red == 'missingno'
  game.missingno
  elsif @red == 'helixfossil'
    'You use the mighty Helix Fossil to CRUSH THE OPPOSITION!'
  elsif @rayquaza_number.to_f == 99
    'You chose ' + @red + '!' ' Your rival chose Rayquaza! You Lose!'
  elsif @rival == 'charmander'
    if @red == 'charmander'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " It's a Tie!"
    elsif @red == 'squirtle'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " You Win!"
    elsif @red == 'bulbasaur'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " You Lose!"
    end

  elsif @rival == 'squirtle'
    if @red == 'charmander'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " You Lose!"
    elsif @red == 'squirtle'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " It's a Tie!"
    elsif @red == 'bulbasaur'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " You Win!"
    end

  elsif @rival == 'bulbasaur'
    if @red == 'charmander'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " You Win!"
    elsif @red == 'squirtle'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " You Lose!"
    elsif @red == 'bulbasaur'
      'You chose ' + @red + '!' ' Your rival chose ' + @rival + '!' + " It's a Tie!"
    end
  end

end
