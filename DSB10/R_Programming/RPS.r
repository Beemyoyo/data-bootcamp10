opions <- c("hammer", "scissor", "paper")


play_game <- function () {
  user_point <- 0
  bot_point <- 0
  for (i in 1:10) {
    print(paste("Round", i))
    user_pick <- readline("Pick (hammer, scissor, paper):")
    bot_pick <- sample(opions, 1)
    print(paste("Bot pick:", bot_pick))
    if (user_pick == bot_pick) {
      print("Tie")
    } else if((user_pick == "hammer" & bot_pick == "scissor")|| 
      (user_pick == "scissor" & bot_pick == "paper")|| 
      (user_pick == "paper" & bot_pick == "hammer")) {
      print("You Win")
      user_point <- user_point + 1
    } else {
      print("You lose")
      bot_point <- bot_point + 1
    }
  }
  print("Total score")
  print(paste("User:", user_point))
  print(paste("Bot:", bot_point))

  if (user_point > bot_point) {
    print("You're so lucky!")
  } else if (user_point < bot_point) {
    print("Try next time!")
  } else {
    print("Let's fight next time")
  }
}


play_game()