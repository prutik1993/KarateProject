Feature: Articles

Background: Define URL
    * url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.dataGenarator')
    * set articleRequestBody.article.title = dataGenarator.getRandomArticleValues().title
    * set articleRequestBody.article.description = dataGenarator.getRandomArticleValues().description
    * set articleRequestBody.article.body = dataGenarator.getRandomArticleValues().body

#     Given path 'users/login'
#     And request {"user": {"email": "prutik111@test.com","password": "12345678"}}
#     When method Post
#     Then status 200
# * def token = response.user.token
# * def tokenResponse == callonce read('classpath:helpers/CreateToken.feature') 
# * def token = tokenResponse.authToken
 // instead of two last lines we wrote param var in the karate.config
 // we also created var for headers that will be used accros our feature files
@skip
Scenario: Create a new article
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 200
    And match response.article.title == articleRequestBody.article.title

@debug
Scenario: Create and delete article
    Given path 'articles'
    And request {"article":{"tagList":[],"title":"Delete Article6","description":"About the world","body":"Olalalalalala"}}
    When method Post
    Then status 200
    //* def articleID == response.article.slug
    
    # Given params { limit: 10, offset: 0}
    # Given path 'articles'
    # When method Get
    # Then status 200
    # And match response.articles[0].title == 'Delete Article3'

    # Given header Authorization = 'Token ' + token
    # Given path 'articles', articleID
    # When method Delete
    # Then status 204
    # And match response.articles[0].title != 'Delete Article3'

    
    
