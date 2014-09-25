accountSettings = ((@Meteor.settings or {}).public or {}).account or
  emailDomainWhitelist: off
  loginExpirationInDays: 90

Accounts.config
  sendVerificationEmail: yes

  restrictCreationByEmailDomain: (email) ->
    not accountSettings.emailDomainWhitelist or
      _.contains accountSettings.emailDomainWhitelist or [], email.split('@').pop()

  loginExpirationInDays: accountSettings.loginExpirationInDays
