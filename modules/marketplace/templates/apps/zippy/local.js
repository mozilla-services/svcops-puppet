// Note: New keys must be additionally defined in default.js before being overriden here.
module.exports = {
  // Add a non-empty value to the zero-ith key.
  signatureKeys: {0: '<%= @signature_key %>'},
  // These are OAuth-related key, secret and realm.
  OAuthCredentials: {
    consumerKey: '<%= @oauth_key %>',
    consumerSecret: '<%= @oauth_secret %>',
  },
  OAuthRealm: '<%= @oauth_realm %>',
  // Session secret cannot be blank.
  sessionSecret: '<%= @session_secret %>',
  logging: {format: 'dev'},
  redisConn: {
      database: 3,
      host: '<%= @redis_host %>',
      port: <%= @redis_port %>
  }
};
