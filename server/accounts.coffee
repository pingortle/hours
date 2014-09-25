Accounts.onCreateUser (opts, user) ->
  user.profile = opts.profile if opts.profile

  email = user.emails[0].address
  user.username = email.split("@")[0]

  user

Accounts.onLogin do (adminRoles = ['admin']) -> (attempt) ->
  userId = attempt.user._id
  if Meteor.users.find().count() is 1 and not Roles.userIsInRole userId, adminRoles
    Roles.addUsersToRoles userId, adminRoles, Roles.GLOBAL_GROUP
