function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
   config.userEmail = 'prutik111@test.com'
   config.userPassword = '12345678'

  }  if (env == 'qa') {
    config.userEmail = 'ana111@test.com'
    config.userPassword = 'hello1234'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})
  
  return config;
}

// mvn test -Dkarate.options="--tags @debug" -Dkarate.env="qa"  This is comment to run different environtment