Feature: work with DB

Background: 
    * def dbHandler = Java.type('helpers.DbHandler')

Scenario: Seed databese with a new Job
    * eval dbHandler.addNewJobWithName("QA3")

Scenario: Get level for Job
    * def level = dbHandler.getMinAndMaxLevelForJob("QA3")
    * print level.minLvl
    * print level.maxLvl
    And match level.minLvl = '50'
    And match level.maxLvl = '100'