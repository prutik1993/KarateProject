Feature: Add likes

Background:
    * url apiUrl

Scenario:
    Given path 'articles', slug, 'favorite'
    And request {}
    When method Post
    Then status 200
    * def likesCount = response.articles.favoritesCount

