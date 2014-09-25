helpers = [
  [ 'isAdmin', () -> Roles.isUserInRole Meteor.userId(), ['admin'] ]
  [ 'Collections', share.App.Collections]
]

_.each helpers, (helperArgs) ->
  [name, helper] = helperArgs
  Template.registerHelper name, helper
