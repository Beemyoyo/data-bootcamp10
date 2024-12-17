library(RSQLite)
con <- dbConnect(SQLite(), "restaurant.db")

dbWriteTable(con, "Staff",
             data.frame(id = 1:5,
                        names = c("chaewon", "yunjin", "sakura", "kazuha", "eunchae"),
                        salaries = c(30000, 27000, 28500, 27000, 26000)))

dbWriteTable(con, "menu",
             data.frame(menu_id = 1:5,
             menus = c("bibimbap", "tteokbokki", "bulgogi", "kimchi jjigae", "jajangmyeon"),
             prices = c(320, 240, 300, 270, 220)))

dbWriteTable(con, "customer",
             data.frame(customer_id = 1:10,
                        customer_name = c("beem", "aun", "nack", "new", "joe", "plub", "sunny", "hein", "oak", "mind"),
                        date = c("2024-07-10", "2024-07-8", "2024-07-11", "2024-07-7", "2024-07-11", "2024-07-11", "2024-07-10", "2024-07-4", "2024-07-6", "2024-07-5"),
                        id = c(1,3,5,2,4,3,2,1,4,5),
                        menu_id = c(1,4,5,5,3,2,2,1,4,3)))

dbListTables(con)

dbListFields(con, "Staff")
dbListFields(con, "menu")
dbListFields(con, "customer")

dbGetQuery(con, "select * from customer")

dbDisconnect(con)