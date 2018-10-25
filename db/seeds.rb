### USERS ###
User.create(username: "steven")
User.create(username: "dario")

### CATEGORIES ###
Category.create(name: "Mindfulness", count: 0)
Category.create(name: "Shamanic", count: 0)

### USER_CATEGORY ###
UserCategory.create(user_id: 1, category_id: 1)
UserCategory.create(user_id: 1, category_id: 2)
UserCategory.create(user_id: 2, category_id: 1)
UserCategory.create(user_id: 2, category_id: 2)

