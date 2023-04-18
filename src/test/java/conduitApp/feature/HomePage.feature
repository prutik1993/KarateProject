

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






