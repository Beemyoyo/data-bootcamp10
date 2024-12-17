menu <- c("New York pizza", "Chicago pizza", "Italian pizza")
price <- c(3, 7, 4)
topping <- c("pepeloni", "sausage", "seafood")
price_top <- c(1.5, 2, 5)


pizza <- function() {
  print(paste("Hello welcome to pizzeria restaurant! Mr./Mrs:", readline("name:")))
  print("This is our menus and prices!")
  df_pizza <- data.frame(menu, price, topping, price_top)
  print(df_pizza)
  order <- readline("order:")
  if (order %in% df_pizza$menu) {
    price_matched_order <- df_pizza[df_pizza$menu == order,]$price[1]
  }
  ask_top <- readline("Do you want a topping? y/n:")
  if (ask_top == "y") {
    order_top <- readline("topping:")
    if (order_top %in% topping) {
      price_matched_top <- df_pizza[df_pizza$topping == order_top,]$price_top[1]
      print(paste("Total price:", price_matched_order + price_matched_top))
      print("Thankyou so much")
    }
  } else {
    print(paste("Total price:", price_matched_order))
    print("Thankyou so much")
  }
}

pizza()