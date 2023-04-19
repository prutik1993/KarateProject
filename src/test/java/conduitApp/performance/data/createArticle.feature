Feature: Articles

Background: Define URL
    * url 'https://api.realworld.io/api/'
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = __gatling.Title // reading from csv file
    * set articleRequestBody.article.description = __gatling.Description // reading the data from the feeter
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

    

Scenario: Create and delete article
    * configure headers = {"Authorization": #('Token ' + __gatling.token)}
    Given path 'articles'
    And request articleRequestBody
    And header karate-name = 'Create title requested:' + __gatling.Title // naming for reports
    When method Post
    Then status 200
    * def articleId = response.article.slug

    * pause(5000)

    Given path 'articles',articleId
    When method Delete
    Then status 204