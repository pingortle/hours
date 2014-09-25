App = share.App

App.Collections = Collections = {}
App.Schema = Schema = {}

Schema.UserProfile = new SimpleSchema
  firstName:
    type: String
    regEx: /^[a-zA-Z-]{2,25}$/
    optional: yes
  lastName:
    type: String
    regEx: /^[a-zA-Z]{2,25}$/
    optional: yes
  birthday:
    type: Date
    optional: yes
  gender:
    type: String
    allowedValues: [
      "Male"
      "Female"
    ]
    optional: yes

Schema.UserPrivileges = new SimpleSchema
  paidTimeOff:
    type: Number

Schema.User = new SimpleSchema
  _id:
    type: String
    regEx: SimpleSchema.RegEx.Id
  username:
    type: String
    regEx: /^[a-z0-9A-Z_]{3,15}$/
    index: yes
    unique: yes
  emails:
    type: [Object]
    # This should be optional if other login services are ever added.
    # optional: true
  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email
    index: yes
    unique: yes
  "emails.$.verified":
    type: Boolean
  createdAt:
    type: Date
  profile:
    type: Schema.UserProfile
    optional: yes
  services:
    type: Object
    optional: yes
    blackbox: yes
  # Add `roles` to your schema if you use the meteor-roles package.
  # Note that when using this package, you must also specify the
  # `Roles.GLOBAL_GROUP` group whenever you add a user to a role.
  # Roles.addUsersToRoles(userId, ["admin"], Roles.GLOBAL_GROUP);
  # You can't mix and match adding with and without a group since
  # you will fail validation in some cases.
  roles:
    type: Object
    optional: yes
    blackbox: yes
  privileges:
    type: Schema.UserPrivileges
    optional: yes

Meteor.users.attachSchema Schema.User

Schema.Absence = new SimpleSchema
  user:
    type: String
    regEx: Schema.User.schema('username').regEx
  start:
    type: Date
  hours:
    type: Number
    decimal: yes
    autoform:
      step: 1
  note:
    type: String
    optional: yes
    autoform:
      rows: 3

Collections.Absences = new Mongo.Collection 'absences'
Collections.Absences.attachSchema Schema.Absence
