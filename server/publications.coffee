Meteor = @Meteor
Collections = share.App.Collections

Meteor.publish null, () ->
  Meteor.roles.find()

Meteor.publish 'allAbsences', () ->
  Collections.Absences.find() if Roles.userIsInRole @userId, ['view-records', 'admin']
