Feature: Validate Tech Global backend function

Background:
  Given url 'https://tech-global-training.com/'
  Given path 'students'
  And request {"firstName": "Mar","lastName": "Sun","email": "ll7tau1r23k@gmnail.com","dob": "1997-01-01"}
  When method Post
  Then status 200
  * def id = response.id
 
  


  
  

Scenario: Get a student
    Given path 'students/' + id
    When method Get
    Then status 200

Scenario: Get all students
  Given path 'students'
  When method Get
  Then status 200


