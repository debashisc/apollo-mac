
  var OAuth = require('OAuth');

     var OAuth2 = OAuth.OAuth2;    
     var twitterConsumerKey = 'zv9pctwvr9w4b2rsadatqeuz';
     var twitterConsumerSecret = 'yWd6pp6ATC';
     var oauth2 = new OAuth2(twitterConsumerKey,
       twitterConsumerSecret, 
       'http://api.rdio.com', 
       null,
       'oauth/request_token', 
       null);
     oauth2.getOAuthAccessToken(
       '',
       {'grant_type':'client_credentials'},
       function (e, access_token, refresh_token, results){
       console.log('bearer: ',access_token);
       //done();
     });