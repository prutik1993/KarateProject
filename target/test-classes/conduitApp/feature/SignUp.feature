Feature: Sign Up new user

Background: Preconitions

    * def dataGenerator = Java.type('helpers.dataGenarator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def randomEmail = dataGenarator.getRandomEmail();
    * def randomUsername = dataGenarator.getRandomUsername();
    Given url apiUrl

Scenario: New user sigm up
 // Given def userData = {"email": "prutik111@test.com", "username": "anastasiya1993"} we created random generated data
    Given path 'users'

    And request //{"user": {"email": #(userData.email),"password": "12345678", "username": #(userData.username)}}
    """
        {
            "user": {
                "email": #(randomEmail),
                "password": "12345678",
                "username": #(randomUsername)
            }
        }
        """
        When method Post
        Then status 200

        And match response ==
        """
            {
            "user":{
                "id": "#number",
                "email":"#(randomEmail)",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "username": "#(ramdomUsername)",
                "bio": null,
                "image": null,
                "token": "#string"
            }
        }
        """

 Scenario Outline: Validate Sign Up error
    * def randomEmail = dataGenarator.getRandomEmail();
    * def randomUsernamae = dataGenarator.getRandomUsername();

    Given path 'users'

    And request 
    """
        {
            "user": {
                "email": "<email>",
                "password": "<password>",
                "username": "<username>"
            }
        }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
        |email               |password  |username          |errorResponse                                                                         |
        |#(randomEmail)      |Karate123 |KarateUser123     |{"errors":{"username":["has already been taken"]}}                                   |
        |KarateUser1@test.com|Karate123 |#(randomUsername) |{"errors":{"email":["has already been taken"]}}                                      |
        |KarateUser1         |Karate123 |#(randomUsername) |{"errors": {"email": ["is invalid"]}}                                                |
        |#(randomEmail)      |Karate123 |Karate123123123123|{"errors": {"username": ["is too long (maximum is 20 characters)"]}}                 |
        |#(randomEmail)      |Kar       |#(randomUsername) |{"errors": {"username": ["is too short (miniomum is 8 characters)"]}}                |
        |                    |Karate123 |#(randomUsername) |{"errors":{"email":["can't be blank"]}}                                              |
        |#(randomEmail)      |          |#(randomUsername) |{"errors": {"password": ["can't be blank"]}}                                         |
        |#(randomEmail)      |Karate123 |                  |{"errors": {"username": ["can't be blank", "is too short (minimum is 1 character)"]}}|



