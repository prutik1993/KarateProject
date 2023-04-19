

Feature: test for the home page

Background: Define URL
    Given url apiUrl

Scenario: Get all tags
   Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['welcome', 'introduction']
    And match response.tags !contains 'Hitler'
    And match response.tags contains any ['fish', 'dog'] // "any" will chack for any value from given array, must have at least one match
    And match response.tags == "#array"
    And match each response.tags == "#string"


@ignore
Scenario: Get 10 articles from the page
    * def timeValidator = read('classpath:helpers/timeValidator.js')

    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == "#[10]"
    And match response.articlesCount  == 197
    And match response  == {"articles": "#array", "articlesCount": 500}
    And match response.articles[0].createdAt contains '2020'
    And match response.articles[*].favoriteCount contains 1
    And match response.articles[*].author.bio contains null
    // And match response..bio contains null -> we can put .. and it will simplyfy
    And match each response..following == false
    And match each response..following == '#boolean' // data type validation -> fuzzy matcher
    And match each response..favoriteCount == '#number'
    And match each response..bio == '##string' // ## -> it may be a srting # -> # it must be a string

    #Schema validation
    And match each response.articles == 
    """
        {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string.",
            "tagList": [
                "#string",
                "#string",
                "#string",
                "#string"
            ],
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": '#boolean',
            "favoritesCount": '#number',
            "author": {
                "username": "#string",
                "bio": "#string",
                "image": "#string",
                "following": '#boolean'
            }
        }
    """

Scenario: Conditional logic
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def article = response.articles[0]

    #* if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)

    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount 

    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == result

Scenario: Retry call
   
    * configure retry = {count 10, inretval: 5000}
    
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    And retry until response.articles[0].favoritesCount == result
    When method Get
    Then status 200

Scenario: Sleep
   
    * def sleep = function(puase){java.lang.Thread.sleep(pause)}
    
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    * eval sleep(5000)
    Then status 200

Scenario: Number to String
    * def foo = 10
    * def json = {"bar": #(foo + '')}
    * match json == {"bar": '10'}

Scenario:  String to Number 
    * def foo = '10'
    * def json = {"bar": #(foo*1)} 
    * def json2 = {"bar": #(~~perseInt(foo))} // it return a double so we need to use ~~ to get rid off decimals
    * match json == {"bar": 10}
    * match json2 == {"bar": 10}








